import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class FlatColoredStyle extends BuiltInStyle {
  const FlatColoredStyle(ToastificationType type) : super(type);

  @override
  EdgeInsetsGeometry padding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  }

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
    return primaryColor(context);
  }

  @override
  IconData closeIcon(BuildContext context) {
    return Icons.close;
  }

  @override
  Color closeIconColor(BuildContext context) {
    return Colors.black26;
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
  TextStyle? titleTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall?.copyWith(
          color: foregroundColor(context),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.4,
        );
  }

  @override
  TextStyle? descriptionTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: foregroundColor(context).withOpacity(.7),
          height: 1.3,
        );
  }

  @override
  double elevation(BuildContext context) {
    return 0;
  }

  @override
  List<BoxShadow> boxShadow(BuildContext context) {
    return [];
  }

  @override
  double progressIndicatorStrokeWidth(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Color progressIndicatorValueColor(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Color progressIndicatorBackgroundColor(BuildContext context) {
    throw UnimplementedError();
  }
}
