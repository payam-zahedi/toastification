import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// TODO(payam): refactor this class and add more comments
class ToastificationThemeData extends Equatable {
  const ToastificationThemeData({
    required this.selectedStyle,
    required this.themeData,
    this.toastStyle,
    MaterialColor? primaryColor,
    MaterialColor? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    Color? closeIconColor,
    required TextDirection direction,
    bool showProgressBar = false,
    bool applyBlurEffect = false,
    bool showIcon = true,
    ProgressIndicatorThemeData? progressIndicatorTheme,
  })  : _padding = padding,
        _borderRadius = borderRadius,
        _borderSide = borderSide,
        _boxShadow = boxShadow,
        _direction = direction,
        _showProgressBar = showProgressBar,
        _applyBlurEffect = applyBlurEffect,
        _showIcon = showIcon,
        _progressIndicatorTheme = progressIndicatorTheme;

  final BuiltInStyle selectedStyle;
  final BaseToastStyle? toastStyle;
  final ThemeData themeData;

  final EdgeInsetsGeometry? _padding;
  final BorderRadiusGeometry? _borderRadius;
  final BorderSide? _borderSide;
  final List<BoxShadow>? _boxShadow;
  final bool _showProgressBar;
  final bool _applyBlurEffect;
  final bool _showIcon;
  final TextDirection _direction;
  final ProgressIndicatorThemeData? _progressIndicatorTheme;

  // Getters that prioritize user-set values over default style values

  EdgeInsetsGeometry get padding => _padding ?? selectedStyle.padding;
  BorderRadiusGeometry get borderRadius =>
      _borderRadius ?? selectedStyle.borderRadius;
  BorderSide? get borderSide => _borderSide;
  Border get decorationBorder =>
      Border.fromBorderSide(borderSide ?? selectedStyle.borderSide);

  List<BoxShadow> get boxShadow => _boxShadow ?? selectedStyle.boxShadow;
  TextDirection get direction => _direction;
  bool get showProgressBar => _showProgressBar;
  bool get applyBlurEffect => _applyBlurEffect;
  bool get showIcon => _showIcon;
  ProgressIndicatorThemeData? get progressIndicatorTheme =>
      _progressIndicatorTheme;

  // Additional getters that depend on the above properties
  IconData get icon => selectedStyle.icon;
  Color get iconColor => selectedStyle.iconColor;

  IconData get closeIcon => selectedStyle.closeIcon;

// TODO: we have to remvoe this method
  BorderRadiusGeometry effectiveBorderRadius(BorderRadius borderRadius) =>
      BorderRadiusDirectional.only(
        topEnd: borderRadius.topRight.clamp(
          minimum: const Radius.circular(0),
          maximum: const Radius.circular(30),
        ),
        bottomEnd: borderRadius.bottomRight.clamp(
          minimum: const Radius.circular(0),
          maximum: const Radius.circular(30),
        ),
      );

  // Method to create a new instance with updated properties
  ToastificationThemeData copyWith({
    BaseToastStyle? toastStyle,
    MaterialColor? primaryColor,
    MaterialColor? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    bool? showProgressBar,
    bool? applyBlurEffect,
    bool? showIcon,
    ProgressIndicatorThemeData? progressIndicatorTheme,
  }) {
    return ToastificationThemeData(
      toastStyle: toastStyle ?? this.toastStyle,
      selectedStyle: selectedStyle,
      themeData: themeData,
      padding: padding ?? _padding,
      borderRadius: borderRadius ?? _borderRadius,
      borderSide: borderSide ?? _borderSide,
      boxShadow: boxShadow ?? _boxShadow,
      direction: direction ?? _direction,
      showProgressBar: showProgressBar ?? _showProgressBar,
      applyBlurEffect: applyBlurEffect ?? _applyBlurEffect,
      showIcon: showIcon ?? _showIcon,
      progressIndicatorTheme: progressIndicatorTheme ?? _progressIndicatorTheme,
    );
  }

  @override
  List<Object?> get props => [
        selectedStyle,
        themeData,
        toastStyle,
        _padding,
        _borderRadius,
        _borderSide,
        _boxShadow,
        _showProgressBar,
        _applyBlurEffect,
        _showIcon,
        _direction,
        _progressIndicatorTheme,
      ];
}
