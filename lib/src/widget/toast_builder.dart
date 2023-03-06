
import 'package:flutter/material.dart';
import 'package:toastification/src/notification/toastification_item.dart';

class ContainerTransition extends StatelessWidget {
  const ContainerTransition({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
      ).animate(animation),
      child: SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
    );
  }
}

class ToastBuilderWidget extends StatelessWidget {
  const ToastBuilderWidget({
    Key? key,
    required this.animation,
    required this.item,
  }) : super(key: key);

  final Animation<double> animation;
  final ToastificationItem item;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: ThemeData.light().textTheme.bodyLarge!,
      child: SizeTransition(
        key: ValueKey(item.hashCode),
        sizeFactor: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: item.builder(context, item),
        ),
      ),
    );
  }
}
