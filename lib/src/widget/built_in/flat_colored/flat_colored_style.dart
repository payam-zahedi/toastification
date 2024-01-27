import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

class FlatColoredStyle extends BuiltInStyle {
  const FlatColoredStyle(super.type);

  @override
  MaterialColor primaryColor(BuildContext context) {
    final color = switch (type) {
      ToastificationType.info => infoColor,
      ToastificationType.warning => warningColor,
      ToastificationType.success => successColor,
      ToastificationType.error => errorColor,
    };

    return ToastHelper.createMaterialColor(color);
  }

  @override
  MaterialColor onPrimaryColor(BuildContext context) {
    return ToastHelper.createMaterialColor(Colors.white);
  }

  @override
  Color backgroundColor(BuildContext context) {
    return primaryColor(context).shade50;
  }

  @override
  Color foregroundColor(BuildContext context) {
    return Colors.black;
  }

  @override
  Color iconColor(BuildContext context) {
    return foregroundColor(context);
  }

  @override
  IconData closeIcon(BuildContext context) {
    return Icons.close;
  }

  @override
  Color closeIconColor(BuildContext context) {
    return foregroundColor(context).withOpacity(.3);
  }

  @override
  BorderSide borderSide(BuildContext context) {
    return BorderSide(
      color: primaryColor(context),
      width: 1.5,
    );
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(12));
  }

  @override
  ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context) {
    return ProgressIndicatorThemeData(
      color: foregroundColor(context).withOpacity(.15),
      linearMinHeight: super.progressIndicatorStrokeWidth(context),
      linearTrackColor: foregroundColor(context).withOpacity(.05),
      refreshBackgroundColor: foregroundColor(context).withOpacity(.05),
    );
  }
}
