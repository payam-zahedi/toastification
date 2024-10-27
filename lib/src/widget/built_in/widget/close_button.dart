import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.onCloseTap,
    required this.showCloseButton,
  });

  final VoidCallback? onCloseTap;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final toastTheme = context.toastTheme;

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
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: onCloseTap,
                  borderRadius: BorderRadius.circular(5),
                  child: Icon(
                    toastTheme.closeIcon,
                    color: toastTheme.closeIconColor,
                    size: 18,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
