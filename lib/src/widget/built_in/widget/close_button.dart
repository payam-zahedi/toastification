import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.onCloseTap,
    required this.showCloseButton,
    this.customCloseButton,
  });

  final VoidCallback? onCloseTap;
  final bool showCloseButton;
  final Widget? customCloseButton;

  @override
  Widget build(BuildContext context) {
    final toastTheme = context.toastTheme;

    return IgnorePointer(
      ignoring: !showCloseButton,
      child: SizedBox(
        height: 30,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 1,
                child: child,
              ),
            );
          },
          child: showCloseButton
              ? SizedBox(
                  key: const ValueKey('close_button_visible'),
                  child: customCloseButton ??
                      SizedBox.square(
                        dimension: 30,
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: Builder(builder: (context) {
                            return InkWell(
                              onTap: onCloseTap,
                              borderRadius: BorderRadius.circular(5),
                              child: Icon(
                                toastTheme.closeIcon,
                                color: toastTheme.closeIconColor,
                                size: 18,
                              ),
                            );
                          }),
                        ),
                      ),
                )
              : const SizedBox.shrink(
                  key: ValueKey('close_button_hidden'),
                ),
        ),
      ),
    );
  }
}
