import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.showCloseButton = true,
    required this.defaultStyle,
    required this.closeIcon,
  });

  final bool showCloseButton;
  final IconData closeIcon;
  final BuiltInStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: IgnorePointer(
        ignoring: !showCloseButton,
        child: AnimatedOpacity(
          opacity: showCloseButton ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: Builder(builder: (context) {
              return Icon(
                closeIcon,
                color: Colors.white,
                size: 35,
              );
            }),
          ),
        ),
      ),
    );
  }
}
