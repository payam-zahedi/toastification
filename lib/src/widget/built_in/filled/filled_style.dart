import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

class FilledStyle extends BuiltInStyle {
  const FilledStyle(super.type);

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
    return primaryColor(context);
  }

  @override
  Color foregroundColor(BuildContext context) {
    return onPrimaryColor(context);
  }

  @override
  Color iconColor(BuildContext context) {
    return onPrimaryColor(context);
  }

  @override
  IconData closeIcon(BuildContext context) {
    return Icons.close;
  }

  @override
  Color closeIconColor(BuildContext context) {
    return foregroundColor(context).withOpacity(.6);
  }

  @override
  BorderSide borderSide(BuildContext context) {
    return const BorderSide(
      color: Colors.black12,
      width: 1,
    );
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(12));
  }

  @override
  TextStyle? descriptionTextStyle(BuildContext context) {
    return super.descriptionTextStyle(context)?.copyWith(
          color: foregroundColor(context).withOpacity(.9),
        );
  }

  @override
  ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context) {
    return ProgressIndicatorThemeData(
      color: foregroundColor(context).withOpacity(.30),
      linearMinHeight: super.progressIndicatorStrokeWidth(context),
      linearTrackColor: foregroundColor(context).withOpacity(.15),
      refreshBackgroundColor: foregroundColor(context).withOpacity(.15),
    );
  }
}
