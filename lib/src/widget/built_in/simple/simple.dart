import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    required this.type,
    this.title,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.applyBlurEffect = false,
  });

  final ToastificationType type;

  final Widget? title;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final bool applyBlurEffect;

  SimpleStyle get defaultStyle => SimpleStyle(type);

  @override
  Widget build(BuildContext context) {
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = this.borderSide ?? defaultStyle.borderSide(context);

    final direction = this.direction ?? Directionality.of(context);

    return Directionality(
      textDirection: direction,
      child: Center(
        child: buildContent(
          context: context,
          background: background,
          borderSide: borderSide,
          borderRadius: borderRadius,
          applyBlurEffect: applyBlurEffect,
        ),
      ),
    );
  }

  Widget buildContent({
    required BuildContext context,
    required Color background,
    required BorderSide borderSide,
    required BorderRadiusGeometry borderRadius,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        border: Border.fromBorderSide(borderSide),
        boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
        borderRadius: borderRadius,
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
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
