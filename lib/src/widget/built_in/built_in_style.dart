import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const infoColor = Color(0xFF47AFFF);
const successColor = Color(0xFF32BC32);
const warningColor = Color(0xFFFFB600);
const errorColor = Color(0xFFFF3A30);

abstract class BuiltInStyle {
  const BuiltInStyle(this.type);

  final ToastificationType type;

  EdgeInsetsGeometry padding(BuildContext context);

  MaterialColor primaryColor(BuildContext context);
  MaterialColor onPrimaryColor(BuildContext context);
  Color backgroundColor(BuildContext context);
  Color foregroundColor(BuildContext context);

  IconData icon(BuildContext context);
  Color iconColor(BuildContext context);

  IconData closeIcon(BuildContext context);
  Color closeIconColor(BuildContext context);

  BorderSide borderSide(BuildContext context);

  BorderRadiusGeometry borderRadius(BuildContext context);

  TextStyle? titleTextStyle(BuildContext context);
  TextStyle? descriptionTextStyle(BuildContext context);

  double elevation(BuildContext context);
  List<BoxShadow> boxShadow(BuildContext context);

  double progressIndicatorStrokeWidth(BuildContext context);
  Color progressIndicatorValueColor(BuildContext context);
  Color progressIndicatorBackgroundColor(BuildContext context);
}
