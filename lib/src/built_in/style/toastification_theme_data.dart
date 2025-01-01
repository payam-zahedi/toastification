import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationThemeData extends Equatable {
  const ToastificationThemeData({
    this.toastStyle,
    required this.flutterTheme,
    required this.direction,
    this.showProgressBar = false,
    this.applyBlurEffect = false,
    this.showIcon = true,
  });

  final BaseToastStyle? toastStyle;
  final ThemeData flutterTheme;

  final TextDirection direction;
  final bool showProgressBar;
  final bool applyBlurEffect;
  final bool showIcon;

  ToastificationThemeData copyWith({
    BaseToastStyle? toastStyle,
    TextDirection? direction,
    bool? showProgressBar,
    bool? applyBlurEffect,
    bool? showIcon,
    ProgressIndicatorThemeData? progressIndicatorTheme,
  }) {
    return ToastificationThemeData(
      toastStyle: toastStyle ?? this.toastStyle,
      flutterTheme: flutterTheme,
      direction: direction ?? this.direction,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      applyBlurEffect: applyBlurEffect ?? this.applyBlurEffect,
      showIcon: showIcon ?? this.showIcon,
    );
  }

  @override
  List<Object?> get props => [
        flutterTheme,
        toastStyle,
        showProgressBar,
        applyBlurEffect,
        showIcon,
        direction,
      ];
}
