import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// how many toasts are visible while the stack is collapsed.
const _visibleCount = 3;

/// how far a toast sticks out from behind the toast in front of it.
const _peek = 8.0;

/// how much smaller a toast is than the toast in front of it.
const _scaleStep = 0.05;

/// Lays out its children, newest first, as a stack of toasts.
///
/// while [expansion] is 0, the first child is in front and the others stick
/// out from behind it. while it is 1, the children are shown one after
/// another like a list.
class ToastStack extends MultiChildRenderObjectWidget {
  const ToastStack({
    super.key,
    required this.expansion,
    required this.relayout,
    required this.reverse,
    super.children,
  });

  final Animation<double> expansion;

  /// notifies when [expansion] or the animation of a [ToastStackSlot]
  /// changes.
  final Listenable relayout;

  /// whether the stack grows from the bottom to the top.
  final bool reverse;

  @override
  RenderToastStack createRenderObject(BuildContext context) {
    return RenderToastStack(
      expansion: expansion,
      relayout: relayout,
      reverse: reverse,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderToastStack renderObject) {
    renderObject
      ..expansion = expansion
      ..relayout = relayout
      ..reverse = reverse;
  }
}

/// Gives the enter and exit [animation] of a toast to its [ToastStack].
class ToastStackSlot extends ParentDataWidget<ToastStackParentData> {
  const ToastStackSlot({
    super.key,
    required this.animation,
    required super.child,
  });

  final Animation<double> animation;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData! as ToastStackParentData;

    if (parentData.animation == animation) return;

    parentData.animation = animation;
    renderObject.parent?.markNeedsLayout();
  }

  @override
  Type get debugTypicalAncestorWidgetClass => ToastStack;
}

class ToastStackParentData extends ContainerBoxParentData<RenderBox> {
  /// the enter and exit animation of the toast.
  Animation<double> animation = kAlwaysCompleteAnimation;

  /// the scale, the opacity and the visible part of the toast, set by the
  /// layout.
  double scale = 1;
  double opacity = 1;
  Rect clip = Rect.largest;
}

/// The render object of [ToastStack].
///
/// it listens to the animations itself, so a hover relayouts and repaints the
/// stack without rebuilding the toasts.
class RenderToastStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ToastStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, ToastStackParentData> {
  RenderToastStack({
    required this._expansion,
    required this._relayout,
    required this._reverse,
  });

  Animation<double> _expansion;
  set expansion(Animation<double> value) {
    if (_expansion == value) return;

    _expansion = value;
    markNeedsLayout();
  }

  Listenable _relayout;
  set relayout(Listenable value) {
    if (attached) {
      _relayout.removeListener(markNeedsLayout);
      value.addListener(markNeedsLayout);
    }
    _relayout = value;
  }

  bool _reverse;
  set reverse(bool value) {
    if (_reverse == value) return;

    _reverse = value;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _relayout.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _relayout.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! ToastStackParentData) {
      child.parentData = ToastStackParentData();
    }
  }

  @override
  void performLayout() {
    final childConstraints = constraints.widthConstraints();

    // the height of the toast in front while the stack is collapsed. a toast
    // that is animating in takes the front from the one behind it step by
    // step, so the height never jumps.
    var frontHeight = 0.0;
    var depth = 0.0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      child.layout(childConstraints, parentUsesSize: true);

      frontHeight = math.max(
        frontHeight,
        clampDouble(1 - depth, 0, 1) * child.size.height,
      );
      depth += _parentData(child).animation.value;
    }

    final expansion = _expansion.value;

    // the offsets are measured from the edge where the newest toast is.
    var collapsedHeight = frontHeight;
    var expandedHeight = 0.0;
    depth = 0.0;
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final parentData = _parentData(child);

      // 0 for the toast in front, 1 for the toasts behind it.
      final behind = math.min(depth, 1.0);
      // toasts behind the visible ones share the last visible place.
      final place = math.min(depth, _visibleCount - 1.0);

      // a toast behind ends a peek after the toast in front of it.
      collapsedHeight = frontHeight + place * _peek;
      final collapsedTop = behind * (collapsedHeight - child.size.height);
      // a toast behind never shows more than the height of the front toast.
      final collapsedClip = behind * place * _peek;

      parentData
        ..offset = Offset(
          0,
          lerpDouble(collapsedTop, expandedHeight, expansion)!,
        )
        ..clip = Rect.fromLTRB(
          Rect.largest.left,
          lerpDouble(collapsedClip, 0, expansion)!,
          Rect.largest.right,
          Rect.largest.bottom,
        )
        ..scale = lerpDouble(1 - place * _scaleStep, 1, expansion)!
        ..opacity = lerpDouble(
          clampDouble(_visibleCount - depth, 0, 1),
          1,
          expansion,
        )!;

      expandedHeight += child.size.height;
      depth += parentData.animation.value;
    }

    size = constraints.constrain(
      Size(
        constraints.maxWidth,
        lerpDouble(collapsedHeight, expandedHeight, expansion)!,
      ),
    );

    if (!_reverse) return;

    // the newest toast is at the bottom, so the offsets are mirrored.
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final parentData = _parentData(child);

      parentData
        ..offset = Offset(
          0,
          size.height - parentData.offset.dy - child.size.height,
        )
        ..clip = Rect.fromLTRB(
          Rect.largest.left,
          Rect.largest.top,
          Rect.largest.right,
          size.height - parentData.clip.top,
        );
    }
  }

  ToastStackParentData _parentData(RenderBox child) =>
      child.parentData! as ToastStackParentData;

  /// moves the [child] to its offset and scales it around the middle of the
  /// edge that sticks out of the stack.
  Matrix4 _childTransform(RenderBox child) {
    final parentData = _parentData(child);
    final anchor = Offset(
      child.size.width / 2,
      _reverse ? 0 : child.size.height,
    );

    return Matrix4.translationValues(
        parentData.offset.dx + anchor.dx,
        parentData.offset.dy + anchor.dy,
        0,
      )
      ..scaleByDouble(parentData.scale, parentData.scale, 1, 1)
      ..translateByDouble(-anchor.dx, -anchor.dy, 0, 1);
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_childTransform(child));
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (var child = firstChild; child != null; child = childAfter(child)) {
      final isHit = result.addWithPaintTransform(
        transform: _childTransform(child),
        position: position,
        hitTest: (result, position) =>
            child!.hitTest(result, position: position),
      );

      // only the toast in front can be used while the stack is collapsed.
      if (isHit || _expansion.value == 0) return isHit;
    }

    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // the newest toast is painted last, on top of the others.
    for (var child = lastChild; child != null; child = childBefore(child)) {
      final toast = child;
      final parentData = _parentData(toast);

      void paintToast(PaintingContext context, Offset offset) {
        context.pushClipRect(needsCompositing, offset, parentData.clip, (
          PaintingContext context,
          Offset offset,
        ) {
          context.pushTransform(
            needsCompositing,
            offset,
            _childTransform(toast),
            toast.paint,
          );
        });
      }

      if (parentData.opacity == 1) {
        paintToast(context, offset);
      } else if (parentData.opacity > 0) {
        context.pushOpacity(
          offset,
          (parentData.opacity * 255).round(),
          paintToast,
        );
      }
    }
  }
}
