import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationTheme {
  final BuiltInStyle defaultStyle;
  final BuildContext context;

  // User customizable properties
  final MaterialColor? _primaryColor;
  final MaterialColor? _backgroundColor;
  final Color? _foregroundColor;
  final EdgeInsetsGeometry? _padding;
  final BorderRadiusGeometry? _borderRadius;
  final BorderSide? _borderSide;
  final List<BoxShadow>? _boxShadow;
  final TextDirection? _direction;
  final bool _showCloseButton;
  final bool _showProgressBar;
  final bool _applyBlurEffect;
  final bool _showIcon;
  final ProgressIndicatorThemeData? _progressIndicatorTheme;

  ToastificationTheme({
    required this.defaultStyle,
    required this.context,
    MaterialColor? primaryColor,
    MaterialColor? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    bool showCloseButton = true,
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
        _showCloseButton = showCloseButton,
        _showProgressBar = showProgressBar,
        _applyBlurEffect = applyBlurEffect,
        _showIcon = showIcon,
        _progressIndicatorTheme = progressIndicatorTheme;

  // Getters that prioritize user-set values over default style values
  MaterialColor get primaryColor =>
      _primaryColor ?? defaultStyle.primaryColor(context);
  Color get backgroundColor =>
      _backgroundColor ?? defaultStyle.backgroundColor(context);
  Color get foregroundColor =>
      _foregroundColor ?? defaultStyle.foregroundColor(context);

  Color get decorationColor =>
      _applyBlurEffect ? backgroundColor.withOpacity(0.5) : backgroundColor;
  EdgeInsetsGeometry get padding => _padding ?? defaultStyle.padding(context);
  BorderRadiusGeometry get borderRadius =>
      _borderRadius ?? defaultStyle.borderRadius(context);
  BorderSide get borderSide =>
      _borderSide ??
      defaultStyle.borderSide(context).copyWith(color: primaryColor);
  Border get decorationBorder => Border.fromBorderSide(borderSide);

  List<BoxShadow> get boxShadow =>
      _boxShadow ?? defaultStyle.boxShadow(context);
  TextDirection get direction => _direction ?? Directionality.of(context);
  bool get showCloseButton => _showCloseButton;
  bool get showProgressBar => _showProgressBar;
  bool get applyBlurEffect => _applyBlurEffect;
  bool get showIcon => _showIcon;
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      _progressIndicatorTheme ?? defaultStyle.progressIndicatorTheme(context);

  // Additional getters that depend on the above properties
  Color get iconColor => primaryColor;
  Color get closeIconColor => foregroundColor.withOpacity(0.3);
  IconData get icon => defaultStyle.icon(context);
  IconData get closeIcon => defaultStyle.closeIcon(context);

  TextStyle? get titleTextStyle =>
      defaultStyle.titleTextStyle(context)?.copyWith(
            color: foregroundColor,
          );

  TextStyle? get descriptionTextStyle =>
      defaultStyle.descriptionTextStyle(context)?.copyWith(
            color: foregroundColor.withOpacity(.7),
          );

  // You can add more getters as needed

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
    bool? showCloseButton,
    bool? showProgressBar,
    bool? applyBlurEffect,
    bool? showIcon,
    ProgressIndicatorThemeData? progressIndicatorTheme,
  }) {
    return ToastificationTheme(
      defaultStyle: defaultStyle,
      context: context,
      primaryColor: primaryColor ?? _primaryColor,
      backgroundColor: backgroundColor ?? _backgroundColor,
      foregroundColor: foregroundColor ?? _foregroundColor,
      padding: padding ?? _padding,
      borderRadius: borderRadius ?? _borderRadius,
      borderSide: borderSide ?? _borderSide,
      boxShadow: boxShadow ?? _boxShadow,
      direction: direction ?? _direction,
      showCloseButton: showCloseButton ?? _showCloseButton,
      showProgressBar: showProgressBar ?? _showProgressBar,
      applyBlurEffect: applyBlurEffect ?? _applyBlurEffect,
      showIcon: showIcon ?? _showIcon,
      progressIndicatorTheme: progressIndicatorTheme ?? _progressIndicatorTheme,
    );
  }
}
