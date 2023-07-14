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
    this.boxShadow,
    this.direction,
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

  final TextDirection? direction;

  final bool? showCloseButton;

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
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
                border: Border.fromBorderSide(defaultStyle.borderSide(context)),
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
          ),
        ),
      ),
    );
  }
}
