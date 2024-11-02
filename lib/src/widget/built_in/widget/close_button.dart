import 'package:flutter/material.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    this.showCloseButton = true,
    required this.icon,
    required this.iconColor,
    this.onCloseTap,
  });

  final bool showCloseButton;
  final VoidCallback? onCloseTap;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
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
              ? SizedBox.square(
                  dimension: 30,
                  child: Material(
                    key: const ValueKey('close_button_visible'),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: Builder(builder: (context) {
                      return InkWell(
                        onTap: onCloseTap,
                        borderRadius: BorderRadius.circular(5),
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: 18,
                        ),
                      );
                    }),
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
