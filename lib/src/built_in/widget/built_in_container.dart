import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

@visibleForTesting
class BuiltInContainerKeys {
  static const mouseRegion = Key('toastification-built-in-mouse-region');
}

/// This widget help you to use the default behavior of the built-in
/// toastification Items
final class BuiltInContainer extends StatelessWidget {
  const BuiltInContainer({
    super.key,
    required this.item,
    required this.margin,
    required this.closeOnClick,
    required this.pauseOnHover,
    required this.dragToClose,
    this.dismissDirection,
    required this.callbacks,
    this.onHoverMouseCursor,
    required this.child,
  });

  final ToastificationItem item;

  final EdgeInsetsGeometry margin;

  final bool closeOnClick;

  final bool dragToClose;

  final DismissDirection? dismissDirection;

  final bool pauseOnHover;

  final ToastificationCallbacks callbacks;

  final MouseCursor? onHoverMouseCursor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasTimeout = item.hasTimer;

    Widget toast = Padding(
      padding: margin,
      child: child,
    );

    if (pauseOnHover && hasTimeout) {
      toast = MouseRegion(
        onEnter: (event) {
          item.pause();
        },
        onExit: (event) {
          item.start();
        },
        child: toast,
      );
    }

    if (closeOnClick || callbacks.onTap != null) {
      toast = GestureDetector(
        onTap: () {
          // if close on click is enabled dismiss the toast
          if (closeOnClick) toastification.dismiss(item);

          // call the onTap callback
          callbacks.onTap?.call(item);
        },
        child: toast,
      );
    }

    if (onHoverMouseCursor != null) {
      toast = MouseRegion(
        key: BuiltInContainerKeys.mouseRegion,
        cursor: onHoverMouseCursor!,
        child: toast,
      );
    }

    if (dragToClose) {
      toast = _FadeDismissible(
        item: item,
        pauseOnHover: pauseOnHover,
        dismissDirection: dismissDirection,
        onDismissed: callbacks.onDismissed == null
            ? null
            : () {
                callbacks.onDismissed?.call(item);
              },
        child: toast,
      );
    }

    return toast;
  }
}

class _FadeDismissible extends StatefulWidget {
  const _FadeDismissible({
    required this.item,
    required this.pauseOnHover,
    this.onDismissed,
    this.dismissDirection,
    required this.child,
  });

  final ToastificationItem item;
  final bool pauseOnHover;
  final VoidCallback? onDismissed;
  final DismissDirection? dismissDirection;
  final Widget child;

  @override
  State<_FadeDismissible> createState() => _FadeDismissibleState();
}

class _FadeDismissibleState extends State<_FadeDismissible> {
  double currentOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _handleDragUpdate(true, event.kind);
      },
      onPointerUp: (event) {
        _handleDragUpdate(false, event.kind);
      },
      child: Dismissible(
        key: ValueKey('dismiss-${widget.item.id}'),
        onUpdate: (details) {
          setState(() {
            currentOpacity = details.progress;
          });
        },
        direction: widget.dismissDirection ?? DismissDirection.horizontal,
        behavior: HitTestBehavior.deferToChild,
        onDismissed: (direction) {
          // call the onDismissed callback
          widget.onDismissed?.call();

          toastification.dismiss(widget.item, showRemoveAnimation: false);
        },
        child: Opacity(
          opacity: 1 - currentOpacity,
          child: widget.child,
        ),
      ),
    );
  }

  void _handleDragUpdate(bool startDrag, PointerDeviceKind pointerKind) {
    if (widget.pauseOnHover && pointerKind == PointerDeviceKind.mouse) return;

    if (widget.item.hasTimer && startDrag) {
      widget.item.pause();
    } else {
      widget.item.start();
    }
  }
}
