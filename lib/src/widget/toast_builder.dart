import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'dart:math' as math;

class DefaultToastTransition extends StatelessWidget {
  const DefaultToastTransition({
    Key? key,
    required this.animation,
    required this.alignment,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: alignment.y >= 0 ? const Offset(0, 1) : const Offset(0, -1),
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }
}

class ToastHolderWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ToastHolderWidget({
    required this.item,
    required this.animation,
    this.income = true,
    required this.child,
  });

  final ToastificationItem item;
  final Animation<double> animation;
  final bool income;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(item.id),
      child: DefaultTextStyle(
        style: ThemeData.light().textTheme.bodyLarge!,
        child: Transition(
          income: income,
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}

class Transition extends AnimatedWidget {
  const Transition({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.income = true,
    this.child,
  }) : super(listenable: sizeFactor);

  final Axis axis;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  final double axisAlignment;

  final bool income;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }

    return Align(
      alignment: alignment,
      heightFactor:
          axis == Axis.vertical ? math.max(sizeFactor.value, 0.0) : null,
      widthFactor:
          axis == Axis.horizontal ? math.max(sizeFactor.value, 0.0) : null,

      child: income
          ? child
          : FadeTransition(
              opacity: sizeFactor,
              child: child,
            ),
    );
  }
}
