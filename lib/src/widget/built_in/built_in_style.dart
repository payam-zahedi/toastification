import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

/// default style for info toastification

/// Base abstract class for built-in styles
abstract class BuiltInStyle {
  const BuiltInStyle(this.type);

  factory BuiltInStyle.fromToastificationStyle(
    ToastificationStyle style,
    ToastificationType type,
  ) {
    return switch (style) {
      ToastificationStyle.minimal => MinimalStyle(type),
      ToastificationStyle.fillColored => FilledStyle(type),
      ToastificationStyle.flatColored => FlatColoredStyle(type),
      ToastificationStyle.flat => FlatStyle(type),
      ToastificationStyle.simple => SimpleStyle(type),
    };
  }

  final ToastificationType type;

  EdgeInsetsGeometry padding(BuildContext context) =>
      const EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16);

  MaterialColor primaryColor(BuildContext context) =>
      ToastHelper.createMaterialColor(type.color);
  MaterialColor onPrimaryColor(BuildContext context);
  Color backgroundColor(BuildContext context);
  Color foregroundColor(BuildContext context);

  IconData icon(BuildContext context) => type.icon;

  Color iconColor(BuildContext context);

  IconData closeIcon(BuildContext context);
  Color closeIconColor(BuildContext context);

  BorderSide borderSide(BuildContext context);

  BorderRadiusGeometry borderRadius(BuildContext context);

  TextStyle? titleTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            color: foregroundColor(context),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.2,
          );

  TextStyle? descriptionTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            color: foregroundColor(context).withOpacity(.7),
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 1.2,
          );

  double elevation(BuildContext context) => 0.0;
  List<BoxShadow> boxShadow(BuildContext context) => const [];

  double progressIndicatorStrokeWidth(BuildContext context) => 2.0;

  ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context);
}
