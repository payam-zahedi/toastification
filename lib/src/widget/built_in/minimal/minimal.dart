import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/toastification.dart';

class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
    super.key,
    required this.type,
    this.item,
    required this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.direction,
    this.onCloseTap,
    this.showCloseButton,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
    required this.closeIcon,
  });

  final ToastificationType type;
  final ToastificationItem? item;
  final String title;
  final String? description;

  final Widget? icon;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final VoidCallback? onCloseTap;

  final TextDirection? direction;

  final bool? showCloseButton;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  final IconData closeIcon;

  MinimalStyle get defaultStyle => MinimalStyle(type);

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? defaultStyle.primaryColor(context);
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final direction = this.direction ?? Directionality.of(context);

    final borderRadius =
        (this.borderRadius ?? defaultStyle.borderRadius(context))
            .resolve(direction);
    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Material(
            color: Colors.transparent,
            shape: LinearBorder.start(
              side: BorderSide(
                color: primary,
                width: 3,
              ),
            ),
            child: GestureDetector(
              onTap: onCloseTap == null
                  ? () {
                      if (item != null) {
                        toastification.dismiss(item!);
                      }
                    }
                  : () {
                      onCloseTap!();
                      if (item != null) {
                        toastification.dismiss(item!);
                      }
                    },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius:
                          defaultStyle.effectiveBorderRadius(borderRadius),
                      border: Border.fromBorderSide(
                          defaultStyle.borderSide(context)),
                      boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
                    ),
                    padding: padding ?? defaultStyle.padding(context),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: icon ??
                              Icon(
                                defaultStyle.icon(context),
                                size: 40,
                                color: iconColor,
                              ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: BuiltInContent(
                            style: defaultStyle,
                            title: title,
                            description: description,
                            primaryColor: primaryColor,
                            foregroundColor: foregroundColor,
                            backgroundColor: backgroundColor,
                            showProgressBar: showProgressBar,
                            progressBarValue: progressBarValue,
                            progressBarWidget: progressBarWidget,
                            progressIndicatorTheme: progressIndicatorTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 13,
                    child: ToastCloseButton(
                      showCloseButton: showCloseButton,
                      defaultStyle: defaultStyle,
                      closeIcon: closeIcon,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
