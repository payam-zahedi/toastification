import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';

import 'minimal_style.dart';

class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
    super.key,
    required this.type,
    required this.title,
    this.description,
    this.primaryColor,
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

  final MaterialColor? primaryColor;

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
    final primary = primaryColor ?? defaultStyle.primaryColor(context);
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        (this.borderRadius ?? defaultStyle.borderRadius(context))
            .resolve(Directionality.of(context));

    return IconTheme(
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
          child: Material(
            color: background,
            shape: RoundedRectangleBorder(
              side: defaultStyle.borderSide(context),
              borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
            ),
            elevation: elevation ?? defaultStyle.elevation(context),
            child: Padding(
              padding: padding ?? defaultStyle.padding(context),
              child: Row(
                children: [
                  icon ??
                      Icon(
                        defaultStyle.icon(context),
                        size: 24,
                        color: iconColor,
                      ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BuiltInContent(
                      style: defaultStyle,
                      title: title,
                      description: description,
                      foregroundColor: foregroundColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Offstage(
                    offstage: !showCloseButton,
                    child: InkWell(
                      onTap: onCloseTap,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          defaultStyle.closeIcon(context),
                          color: defaultStyle.closeIconColor(context),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}