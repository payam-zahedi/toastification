import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

/// This class is responsible for creating the default animation for the toastification
///
/// for now, it creates fade and slide animations
class DefaultToastificationTransition extends AnimatedWidget {
  const DefaultToastificationTransition({
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
    final alignment = this.alignment.resolve(Directionality.of(context));

    final isCenter = alignment.x == 0;

    final slideOffset = isCenter
        ? alignment.y >= 0
            ? const Offset(0, 1)
            : const Offset(0, -1)
        : alignment.x >= 0
            ? const Offset(1, 0)
            : const Offset(-1, 0);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: slideOffset,
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      ),
    );
  }
}

/// Using this class you can create your own animation for the timer of the toastification
///
/// for example, you can create a linear progress indicator which shows the remaining time of the toastification
class ToastTimerAnimationBuilder extends StatefulWidget {
  const ToastTimerAnimationBuilder({
    super.key,
    required this.item,
    required this.builder,
    this.child,
  });

  final ToastificationItem item;

  final ValueWidgetBuilder<double> builder;

  final Widget? child;

  @override
  State<ToastTimerAnimationBuilder> createState() =>
      _ToastTimerAnimationBuilderState();
}

class _ToastTimerAnimationBuilderState extends State<ToastTimerAnimationBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant ToastTimerAnimationBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item != oldWidget.item) {
      _disposeAnimation();
      _initAnimation();
    }
  }

  @override
  void dispose() {
    _disposeAnimation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (context, child) {
        return widget.builder(context, controller.value, child);
      },
    );
  }

  void _disposeAnimation() {
    controller.dispose();
    widget.item.removeListenerOnTimeStatus(_timeStatusListener);
  }

  void _initAnimation() {
    if (widget.item.hasTimer) {
      controller = AnimationController(
        value: ToastHelper.convertRange(
          0,
          widget.item.originalDuration!.inMicroseconds.toDouble(),
          0,
          1.0,
          widget.item.elapsedDuration!.inMicroseconds.toDouble(),
        ),
        duration: widget.item.originalDuration,
        vsync: this,
      );

      widget.item.addListenerOnTimeStatus(_timeStatusListener);

      if (widget.item.isStarted) {
        controller.forward();
      }
    } else {
      controller = AnimationController(
        value: 0,
        duration: widget.item.originalDuration,
        vsync: this,
      );
    }
  }

  void _timeStatusListener() {
    switch (widget.item.timeStatus) {
      case ToastTimeStatus.init:
        controller.reset();
        break;
      case ToastTimeStatus.started:
        controller.forward();
        break;
      case ToastTimeStatus.paused:
        controller.stop(canceled: false);
        break;
      case ToastTimeStatus.stopped:
        controller.stop(canceled: false);
        break;
      case ToastTimeStatus.finished:
        break;
    }
  }
}
