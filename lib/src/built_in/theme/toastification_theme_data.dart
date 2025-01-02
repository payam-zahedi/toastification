import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// A class that defines the theming data for Toastification widgets.
/// 
/// This class holds various styling and behavioral properties that can be used to
/// customize the appearance and functionality of toast notifications.
class ToastificationThemeData extends Equatable {
  /// Creates a new instance of [ToastificationThemeData].
  /// 
  /// [toastStyle] defines the visual style of the toast.
  /// [flutterTheme] is the base Flutter theme to be used.
  /// [direction] determines the text direction for the toast content.
  /// [showProgressBar] controls the visibility of the progress indicator.
  /// [applyBlurEffect] determines if a blur effect should be applied to the toast.
  /// [showIcon] controls the visibility of the toast icon.
  const ToastificationThemeData({
    this.toastStyle,
    required this.flutterTheme,
    required this.direction,
    this.showProgressBar = false,
    this.applyBlurEffect = false,
    this.showIcon = true,
  });

  /// Defines the visual style and appearance of the toast notification.
  /// 
  /// When null, the default toast style will be used.
  final BaseToastStyle? toastStyle;

  /// The base Flutter theme data used for general styling.
  /// 
  /// This theme data provides the base colors, typography, and other visual properties.
  final ThemeData flutterTheme;

  /// The text direction to be used for the toast content.
  /// 
  /// Determines whether the text and layout should be left-to-right or right-to-left.
  final TextDirection direction;

  /// Whether to display a progress indicator in the toast.
  /// 
  /// Defaults to false.
  final bool showProgressBar;

  /// Whether to apply a blur effect to the toast background.
  /// 
  /// Defaults to false.
  final bool applyBlurEffect;

  /// Whether to display an icon in the toast.
  /// 
  /// Defaults to true.
  final bool showIcon;

  /// Creates a copy of this theme data with the given fields replaced with new values.
  /// 
  /// This method is useful for creating variations of the existing theme while
  /// maintaining the values of unspecified fields.
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

