import 'package:flutter/material.dart';

/// default style for info toastification

/// Base abstract class for built-in styles
abstract class BuiltInStyle {
  const BuiltInStyle();

  EdgeInsetsGeometry get padding;

  MaterialColor get primaryColor;
  Color get backgroundColor;
  Color get foregroundColor;
  IconData get icon;

  Color get iconColor;

  IconData get closeIcon;
  Color get closeIconColor;

  BorderSide get borderSide;

  BorderRadiusGeometry get borderRadius;

  TextStyle? get titleTextStyle;
  TextStyle? get descriptionTextStyle;

  double get elevation;
  List<BoxShadow> get boxShadow;

  double get progressIndicatorStrokeWidth;

  ProgressIndicatorThemeData get progressIndicatorTheme;
}
