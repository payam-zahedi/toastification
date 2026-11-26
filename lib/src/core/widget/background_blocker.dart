import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// absorbs the pointer events that reach the [child] area while [blocks]
/// returns true.
///
/// [blocks] is read on every hit test, so a new value needs no rebuild and
/// can change while the widget tree is building.
class BackgroundBlocker extends SingleChildRenderObjectWidget {
  const BackgroundBlocker({super.key, required this.blocks, super.child});

  final ValueGetter<bool> blocks;

  @override
  RenderBackgroundBlocker createRenderObject(BuildContext context) =>
      RenderBackgroundBlocker(blocks);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderBackgroundBlocker renderObject,
  ) {
    renderObject.blocks = blocks;
  }
}

/// the render object of [BackgroundBlocker].
class RenderBackgroundBlocker extends RenderProxyBox {
  RenderBackgroundBlocker(this.blocks);

  ValueGetter<bool> blocks;

  @override
  bool hitTestSelf(Offset position) => blocks();
}
