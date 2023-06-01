import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/filled/filled_style.dart';

class FilledToastWidget extends StatelessWidget {
  const FilledToastWidget({
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

  FilledStyle get style => FilledStyle(type);

  @override
  Widget build(BuildContext context) {
    final showCloseButton = this.showCloseButton ?? true;

    final foreground = foregroundColor ?? style.foregroundColor(context);
    final background = backgroundColor ?? style.backgroundColor(context);

    final borderRadius = this.borderRadius ?? style.borderRadius(context);
    return IconTheme(
      data: Theme.of(context).iconTheme,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: style.borderSide(context),
        ),
        elevation: elevation ?? style.elevation(context),
        child: Padding(
          padding: padding ?? style.padding(context),
          child: Row(
            children: [
              icon ??
                  Icon(
                    style.icon(context),
                    size: 28,
                    color: style.iconColor(context),
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: BuiltInContent(
                  style: style,
                  title: title,
                  description: description,
                  foregroundColor: foreground,
                ),
              ),
              const SizedBox(width: 4),
              Offstage(
                offstage: !showCloseButton,
                child: IconButton(
                  icon: Icon(
                    style.closeIcon(context),
                    color: style.closeIconColor(context),
                  ),
                  splashRadius: 24,
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: onCloseTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
