import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'dart:math' as math;

final class ToastHolderWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ToastHolderWidget({
    required this.item,
    required this.animation,
    required this.alignment,
    required this.transformerBuilder,
  });

  final ToastificationItem item;

  final Animation<double> animation;
  final AlignmentGeometry alignment;

  final ToastificationAnimationBuilder transformerBuilder;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(item.id),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyLarge ??
            ThemeData.light().textTheme.bodyLarge!,
        child: _AnimationTransformer(
          animation: animation,
          alignment: alignment,
          transformerBuilder: transformerBuilder,
          child: item.builder(context, item),
        ),
      ),
    );
  }
}

class _AnimationTransformer extends AnimatedWidget {
  const _AnimationTransformer({
    required Animation<double> animation,
    required this.alignment,
    required this.transformerBuilder,
    required this.child,
  }) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  final AlignmentGeometry alignment;

  final ToastificationAnimationBuilder transformerBuilder;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    const AlignmentDirectional axisAlign = AlignmentDirectional(-1.0, 0);

    final alignment = this.alignment.resolve(Directionality.of(context));

    final slideInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0,
          0.6,
          curve: Curves.easeInOut,
        ),
      ),
    );

    final targetAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0.3,
          1,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return Align(
      alignment: axisAlign,
      heightFactor: math.max(slideInAnimation.value, 0.0),
      child: transformerBuilder(context, targetAnimation, alignment, child),
    );
  }
}
