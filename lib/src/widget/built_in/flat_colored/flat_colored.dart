import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/toastification.dart';

class FlatColoredToastWidget extends StatelessWidget {
  const FlatColoredToastWidget({
    super.key,
    required this.type,
    required this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.item,
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
    required this.closeIcon,
    this.progressIndicatorTheme,
  });

  final ToastificationType type;

  final String title;
  final String? description;
  final ToastificationItem? item;

  final Widget? icon;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;
  final IconData closeIcon;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  FlatColoredStyle get defaultStyle => FlatColoredStyle(type);

  @override
  Widget build(BuildContext context) {
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = defaultStyle.borderSide(context);

    final direction = this.direction ?? Directionality.of(context);

    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme,
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
                constraints: const BoxConstraints(minHeight: 64),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: borderRadius,
                  border: Border.fromBorderSide(borderSide),
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
    );
  }
}
