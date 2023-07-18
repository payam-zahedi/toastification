import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.showCloseButton = true,
    this.onCloseTap,
    required this.defaultStyle,
  });

  final bool showCloseButton;
  final VoidCallback? onCloseTap;
  final BuiltInStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !showCloseButton,
      child: AnimatedOpacity(
        opacity: showCloseButton ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: Builder(builder: (context) {
            return InkWell(
              onTap: onCloseTap,
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  defaultStyle.closeIcon(context),
                  color: defaultStyle.closeIconColor(context),
                  size: 18,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
