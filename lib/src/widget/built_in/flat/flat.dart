import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/flat/flat_style.dart';

class FlatToastWidget extends StatelessWidget {
  const FlatToastWidget({
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
    this.boxShadow,
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

  final List<BoxShadow>? boxShadow;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  FlatStyle get defaultStyle => FlatStyle(type);

  @override
  Widget build(BuildContext context) {
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = defaultStyle.borderSide(context);
    return IconTheme(
      data: Theme.of(context).primaryIconTheme,
      child: Container(
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
              child: Material(
                color: Colors.transparent,

                borderRadius: BorderRadius.circular(4),
                child: Builder(builder: (context) {
                  return InkWell(
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
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
