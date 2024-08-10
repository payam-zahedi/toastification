import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/model/build_in_content_model.dart';
import 'package:toastification/toastification.dart';

class ToastModel {
  const ToastModel({
    required this.type,
    this.title,
    this.description,
    this.icon,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.onCloseTap,
    this.showCloseButton,
    this.applyBlurEffect = false,
    this.showIcon,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
  });
  FlatStyle get defaultStyle => FlatStyle(type);

  BuildInContentModel getBuildInContentModel({BuiltInStyle? style}) {
    return BuildInContentModel(
      style: style ?? defaultStyle,
      title: title,
      description: description,
      primaryColor: primaryColor,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      showProgressBar: showProgressBar ?? false,
      progressBarValue: progressBarValue,
      progressBarWidget: progressBarWidget,
      progressIndicatorTheme: progressIndicatorTheme,
    );
  }

  Color iconColor(BuildContext context) =>
      foregroundColor ?? defaultStyle.iconColor(context);

  Color background(BuildContext context) =>
      primaryColor ?? defaultStyle.backgroundColor(context);

  final ToastificationType type;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  final bool applyBlurEffect;

  final bool? showIcon;

  final bool? showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;
}
