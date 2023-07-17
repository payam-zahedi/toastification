import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'dart:math' as math;

class ToastHolderWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ToastHolderWidget({
    required this.item,
    required this.child,
  });

  final ToastificationItem item;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(item.id),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyLarge ??
            ThemeData.light().textTheme.bodyLarge!,
        child: child,
      ),
    );
  }
}

class ToastificationTransition extends AnimatedWidget {
  const ToastificationTransition({
    super.key,
    required Animation<double> animation,
    required this.alignment,
    this.child,
  }) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  final AlignmentGeometry alignment;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const AlignmentDirectional axisAlign = AlignmentDirectional(-1.0, 0);

    final alignment = this.alignment.resolve(Directionality.of(context));

    return Align(
      alignment: axisAlign,
      heightFactor: math.max(animation.value, 0.0),
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: alignment.y >= 0 ? const Offset(0, 1) : const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        ),
      ),
    );
  }
}
