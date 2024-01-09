import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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
    this.isBlur = false,
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

  final bool isBlur;

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
          child: ClipRRect(
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: isBlur
                  ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
                  : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isBlur ? background.withOpacity(0.5) : background,
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
        ),
      ),
    );
  }
}
