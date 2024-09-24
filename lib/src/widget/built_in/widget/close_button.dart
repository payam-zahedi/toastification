import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.onCloseTap,
  });
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: IgnorePointer(
        ignoring: !context.toastTheme.showCloseButton,
        child: AnimatedOpacity(
          opacity: context.toastTheme.showCloseButton ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: Builder(builder: (context) {
              return InkWell(
                onTap: onCloseTap,
                borderRadius: BorderRadius.circular(5),
                child: Icon(
                  context.toastTheme.closeIcon,
                  color: context.toastTheme.closeIconColor,
                  size: 18,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
