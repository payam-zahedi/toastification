import 'package:flutter/material.dart';
import 'package:toastification/src/core/style_parameter_builder.dart';

class ToastCloseButton extends StatelessWidget {
  const ToastCloseButton({
    super.key,
    required this.styleParameters,
    this.onCloseTap,
  });
  final StyleParameters styleParameters;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: IgnorePointer(
        ignoring: !styleParameters.showCloseButton,
        child: AnimatedOpacity(
          opacity: styleParameters.showCloseButton ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: Builder(builder: (context) {
              return InkWell(
                onTap: onCloseTap,
                borderRadius: BorderRadius.circular(5),
                child: Icon(
                  styleParameters.closeIcon,
                  color: styleParameters.closeIconColor,
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
