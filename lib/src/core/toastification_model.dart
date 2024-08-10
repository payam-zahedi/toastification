import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

class ToastificationModel {
  ToastificationModel({
    this.item,
    this.type,
    this.onCloseTap,
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
    this.callbacks = const ToastificationCallbacks(),
  });

  VoidCallback onCloseButtonTap() {
    return () {
      callbacks != null
          ? callbacks!.onCloseButtonTap != null
              ? callbacks!.onCloseButtonTap?.call(item!)
              : _defaultCloseButtonTap()
          : _defaultCloseButtonTap();
    };
  }

  void _defaultCloseButtonTap() {
    Toastification().dismiss(item!);
  }

  ToastModel toastModel(bool showCloseButton) => ToastModel(
        type: type ?? ToastificationType.info,
        title: title,
        description: description,
        icon: icon,
        primaryColor: buildMaterialColor(primaryColor),
        backgroundColor: buildMaterialColor(backgroundColor),
        foregroundColor: foregroundColor,
        brightness: brightness,
        padding: padding,
        borderRadius: borderRadius,
        borderSide: borderSide,
        boxShadow: boxShadow,
        direction: direction,
        onCloseTap: onCloseTap,
        showCloseButton: showCloseButton,
        applyBlurEffect: applyBlurEffect ?? false,
        showIcon: showIcon,
        showProgressBar: showProgressBar ?? false,
        progressBarWidget: progressBarWidget,
        progressIndicatorTheme: progressBarTheme,
      );
  MaterialColor? buildMaterialColor(Color? color) {
    if (color == null) return null;

    if (color is MaterialColor) return color;

    final findInMaterialColors = Colors.primaries
        .firstWhereOrNull((element) => element.shade500 == color);

    return findInMaterialColors ?? ToastHelper.createMaterialColor(color);
  }

  ToastTimerAnimationBuilder? get progressBarWidget =>
      (showProgressBar ?? false) && item != null
          ? ToastTimerAnimationBuilder(
              item: item!,
              builder: (context, value, _) {
                return LinearProgressIndicator(value: value);
              },
            )
          : null;

  final ToastificationItem? item;

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

  final VoidCallback? onCloseTap;

  final ToastificationCallbacks? callbacks;
}
