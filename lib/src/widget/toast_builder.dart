import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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
    required this.child,
  });

  final ToastificationItem item;
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(item.id),
      child: DefaultTextStyle(
        style: ThemeData.light().textTheme.bodyLarge!,
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}
