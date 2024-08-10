import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationModel {
  final ToastificationItem item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final bool? showProgressBar;

  final bool? applyBlurEffect;

  final bool? showIcon;

  final ProgressIndicatorThemeData? progressBarTheme;

  final CloseButtonShowType? closeButtonShowType;

  final bool? closeOnClick;

  final bool? dragToClose;

  final DismissDirection? dismissDirection;

  final bool? pauseOnHover;

  final ToastificationCallbacks callbacks;

  ToastificationModel({
    required this.item,
    this.type,
    this.style,
    this.title,
    this.description,
    this.icon,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.showProgressBar,
    this.applyBlurEffect,
    this.showIcon,
    this.progressBarTheme,
    this.closeButtonShowType,
    this.closeOnClick,
    this.dragToClose,
    this.dismissDirection,
    this.pauseOnHover,
    required this.callbacks,
  });
}
