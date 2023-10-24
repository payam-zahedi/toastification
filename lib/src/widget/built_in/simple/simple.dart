import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/simple/simple_style.dart';

import '../../../../toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    required this.type,
    required this.title,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.direction,
  });

  final ToastificationType type;

  final String title;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  SimpleStyle get defaultStyle => SimpleStyle(type);

  @override
  Widget build(BuildContext context) {
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = defaultStyle.borderSide(context);

    final direction = this.direction ?? Directionality.of(context);

    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
              border: Border.fromBorderSide(borderSide),
              boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
            ),
            padding: padding ?? defaultStyle.padding(context),
            child: BuiltInContent(
              style: defaultStyle,
              title: title,
              description: null,
              primaryColor: primaryColor,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              showProgressBar: false,
              progressBarValue: null,
              progressBarWidget: null,
              progressIndicatorTheme: null,
            ),
          ),
        ),
      ),
    );
  }
}
