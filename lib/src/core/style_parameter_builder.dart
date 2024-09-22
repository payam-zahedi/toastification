import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class StyleParameters {
  final BuiltInStyle defaultStyle;
  final BuildContext context;
  StyleParameters(this.defaultStyle, this.context);

  MaterialColor? _primaryColor;
  MaterialColor? _backgroundColor;
  Color? _foregroundColor;
  EdgeInsetsGeometry? _padding;
  BorderRadiusGeometry? _borderRadius;
  BorderSide? _borderSide;
  List<BoxShadow>? _boxShadow;
  TextDirection? _direction;
  bool _showCloseButton = true;
  bool _showProgressBar = false;
  bool _applyBlurEffect = false;
  bool _showIcon = true;
  ProgressIndicatorThemeData? _progressIndicatorTheme;
  Color get iconColor => _primaryColor ?? defaultStyle.iconColor(context);
  Color get closeIconColor =>
      _foregroundColor?.withOpacity(0.3) ??
      defaultStyle.closeIconColor(context);
  Color get backgroundColor =>
      _backgroundColor ?? defaultStyle.backgroundColor(context);

  bool get showCloseButton => _showCloseButton;

  BorderRadiusGeometry get borderRadius =>
      _borderRadius ?? defaultStyle.borderRadius(context);
  BorderSide get borderSide =>
      _borderSide ??
      defaultStyle.borderSide(context).copyWith(color: _primaryColor);

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
  TextDirection get direction => _direction ?? Directionality.of(context);

  bool get showIcon => _showIcon;

  Color get decorationColor =>
      _applyBlurEffect ? backgroundColor.withOpacity(0.5) : backgroundColor;
  Border get decorationBorder => Border.fromBorderSide(borderSide);

  List<BoxShadow> get boxShadow =>
      _boxShadow ?? defaultStyle.boxShadow(context);
  EdgeInsetsGeometry get padding => _padding ?? defaultStyle.padding(context);

  IconData get icon => defaultStyle.icon(context);
  IconData get closeIcon => defaultStyle.closeIcon(context);
  bool get showProgressBar => _showProgressBar;
  bool get applyBlurEffect => _applyBlurEffect;
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      _progressIndicatorTheme ?? defaultStyle.progressIndicatorTheme(context);
  Color? get foregroundColor => _foregroundColor;
  Color get primaryColor => _primaryColor ?? defaultStyle.primaryColor(context);
  StyleParameters setPrimaryColor(MaterialColor? primaryColor) {
    _primaryColor = primaryColor;
    return this;
  }

  StyleParameters setBackgroundColor(MaterialColor? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  StyleParameters setForegroundColor(Color? foregroundColor) {
    _foregroundColor = foregroundColor;
    return this;
  }

  StyleParameters setPadding(EdgeInsetsGeometry? padding) {
    _padding = padding;
    return this;
  }

  StyleParameters setBorderRadius(BorderRadiusGeometry? borderRadius) {
    _borderRadius = borderRadius;
    return this;
  }

  StyleParameters setBorderSide(BorderSide? borderSide) {
    _borderSide = borderSide;
    return this;
  }

  StyleParameters setBoxShadow(List<BoxShadow>? boxShadow) {
    _boxShadow = boxShadow;
    return this;
  }

  StyleParameters setDirection(TextDirection? direction) {
    _direction = direction;
    return this;
  }

  StyleParameters setShowIcon(bool? showIcon) {
    _showIcon = showIcon ?? _showIcon;
    return this;
  }

  StyleParameters setShowCloseButton(bool showCloseButton) {
    _showCloseButton = showCloseButton;
    return this;
  }

  StyleParameters setApplyBlurEffect(bool? applyBlurEffect) {
    _applyBlurEffect = applyBlurEffect ?? _applyBlurEffect;
    return this;
  }

  StyleParameters setShowProgressBar(bool showProgressBar) {
    _showProgressBar = showProgressBar;
    return this;
  }

  StyleParameters setProgressIndicatorTheme(
      ProgressIndicatorThemeData? progressIndicatorTheme) {
    _progressIndicatorTheme = progressIndicatorTheme;
    return this;
  }

  StyleParameters build() {
    return this;
  }
}
