import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/minimal/minimal_style.dart';
import 'package:toastification/toastification.dart';

class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
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

  MinimalStyle get defaultStyle => MinimalStyle(type);

  @override
  Widget build(BuildContext context) {
    final primary = defaultStyle.primaryColor(context);

    final foreground = foregroundColor ?? defaultStyle.foregroundColor(context);
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    return IconTheme(
      data: Theme.of(context).primaryIconTheme,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: defaultStyle.borderSide(context),
        ),
        elevation: elevation ?? defaultStyle.elevation(context),
        child: Padding(
          padding: padding ?? defaultStyle.padding(context),
          child: Row(
            children: [
              icon ??
                  MinimalIconHolder(
                    color: primary,
                    icon: Icon(
                      defaultStyle.icon(context),
                      size: 20,
                      color: defaultStyle.iconColor(context),
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
              const SizedBox(width: 4),
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

class MinimalIconHolder extends StatelessWidget {
  const MinimalIconHolder({super.key, required this.color, required this.icon});
  final Color color;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Material(
        color: color.withOpacity(.3),
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(3.33),
          child: Material(
            color: color,
            shape: const CircleBorder(),
            child: icon,
          ),
        ),
      ),
    );
  }
}
