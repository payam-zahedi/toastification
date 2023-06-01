import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/flat_colored/flat_colored_style.dart';

class FlatColoredToastWidget extends StatelessWidget {
  const FlatColoredToastWidget({
    super.key,
    required this.type,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.onCloseTap,
    this.showCloseButton,
  });

  final ToastificationType type;

  final String title;
  final String? description;

  final Widget? icon;

  final MaterialColor? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final double? elevation;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  FlatColoredStyle get defaultStyle => FlatColoredStyle(type);

  @override
  Widget build(BuildContext context) {
    final primaryColor = defaultStyle.primaryColor(context);

    final foreground = foregroundColor ?? defaultStyle.foregroundColor(context);
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = defaultStyle.borderSide(context);

    return IconTheme(
      data: Theme.of(context).primaryIconTheme,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: borderSide,
        ),
        elevation: elevation ?? defaultStyle.elevation(context),
        child: Padding(
          padding: padding ?? defaultStyle.padding(context),
          child: Row(
            children: [
              icon ??
                  Material(
                    color: primaryColor,
                    borderRadius: borderRadius / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        defaultStyle.icon(context),
                        size: 22,
                        color: defaultStyle.iconColor(context),
                      ),
                    ),
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: BuiltInContent(
                  style: defaultStyle,
                  title: title,
                  description: description,
                  foregroundColor: foreground,
                ),
              ),
              const SizedBox(width: 16),
              Offstage(
                offstage: !showCloseButton,
                child: InkWell(
                  onTap: onCloseTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      defaultStyle.closeIcon(context),
                      color: defaultStyle.closeIconColor(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
