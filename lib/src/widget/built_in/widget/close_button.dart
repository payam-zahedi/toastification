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
        ),
      ),
    );
  }
}
