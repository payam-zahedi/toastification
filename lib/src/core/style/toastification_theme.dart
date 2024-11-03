import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// TODO(payam): refactor this class and add more comments
class ToastificationTheme extends Equatable {
  final BuiltInStyle selectedStyle;
  final ThemeData themeData;

  // User customizable properties
  final MaterialColor? _primaryColor;
  final MaterialColor? _backgroundColor;
  final Color? _foregroundColor;
  final EdgeInsetsGeometry? _padding;
  final BorderRadiusGeometry? _borderRadius;
  final BorderSide? _borderSide;
  final List<BoxShadow>? _boxShadow;
  final bool _showProgressBar;
  final bool _applyBlurEffect;
  final bool _showIcon;
  final TextDirection _direction;
  final ProgressIndicatorThemeData? _progressIndicatorTheme;

  const ToastificationTheme({
    required this.selectedStyle,
    required this.themeData,
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
  })  : _primaryColor = primaryColor,
        _backgroundColor = backgroundColor,
        _foregroundColor = foregroundColor,
        _padding = padding,
        _borderRadius = borderRadius,
        _borderSide = borderSide,
        _boxShadow = boxShadow,
        _direction = direction,
        _showProgressBar = showProgressBar,
        _applyBlurEffect = applyBlurEffect,
        _showIcon = showIcon,
        _progressIndicatorTheme = progressIndicatorTheme;

  // Getters that prioritize user-set values over default style values
  MaterialColor get primaryColor => _primaryColor ?? selectedStyle.primaryColor;
  Color get backgroundColor =>
      _backgroundColor ?? selectedStyle.backgroundColor;
  Color get foregroundColor =>
      _foregroundColor ?? selectedStyle.foregroundColor;

  MaterialColor? get primary => _primaryColor;
  Color? get background => _backgroundColor;
  Color? get foreground => _foregroundColor;

  Color get decorationColor =>
      _applyBlurEffect ? backgroundColor.withOpacity(0.5) : backgroundColor;
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
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      _progressIndicatorTheme ?? selectedStyle.progressIndicatorTheme;

  // Additional getters that depend on the above properties
  IconData get icon => selectedStyle.icon;
  Color get iconColor => selectedStyle.iconColor;

  IconData get closeIcon => selectedStyle.closeIcon;
  Color get closeIconColor =>
      foreground?.withOpacity(.4) ?? selectedStyle.closeIconColor;

  TextStyle? get titleTextStyle => selectedStyle.titleTextStyle?.copyWith(
        color: foregroundColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  TextStyle? get descriptionTextStyle =>
      selectedStyle.descriptionTextStyle?.copyWith(
        color: foregroundColor.withOpacity(.7),
        fontSize: 14,
        fontWeight: FontWeight.w300,
        height: 1.2,
      );

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
  ToastificationTheme copyWith({
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
    return ToastificationTheme(
      selectedStyle: selectedStyle,
      themeData: themeData,
      primaryColor: primaryColor ?? _primaryColor,
      backgroundColor: backgroundColor ?? _backgroundColor,
      foregroundColor: foregroundColor ?? _foregroundColor,
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
        _primaryColor,
        _backgroundColor,
        _foregroundColor,
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
