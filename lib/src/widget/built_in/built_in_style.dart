import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

const infoColor = Color(0xFF47AFFF);
const successColor = Color(0xFF32BC32);
const warningColor = Color(0xFFFFB600);
const errorColor = Color(0xFFFF3A30);

const lowModeShadow = [
  BoxShadow(
    color: Color(0x07000000),
    blurRadius: 16,
    offset: Offset(0, 16),
    spreadRadius: 0,
  )
];
const highModeShadow = [
  BoxShadow(
    color: Color(0x14000000),
    blurRadius: 30,
    offset: Offset(0, 20),
    spreadRadius: 0,
  )
];

abstract class BuiltInStyle {
  const BuiltInStyle(this.type);

  final ToastificationType type;

  EdgeInsetsGeometry padding(BuildContext context);

  MaterialColor primaryColor(BuildContext context);
  MaterialColor onPrimaryColor(BuildContext context);
  Color backgroundColor(BuildContext context);
  Color foregroundColor(BuildContext context);

  IconData icon(BuildContext context) {
    return switch (type) {
      ToastificationType.success => Iconsax.tick_circle_copy,
      ToastificationType.info => Iconsax.info_circle_copy,
      ToastificationType.warning => Iconsax.danger_copy,
      ToastificationType.error => Iconsax.close_circle_copy,
    };
  }

  Color iconColor(BuildContext context);

  IconData closeIcon(BuildContext context);
  Color closeIconColor(BuildContext context);

  BorderSide borderSide(BuildContext context);

  BorderRadiusGeometry borderRadius(BuildContext context);

  TextStyle? titleTextStyle(BuildContext context);
  TextStyle? descriptionTextStyle(BuildContext context);

  double elevation(BuildContext context) => 0.0;
  List<BoxShadow> boxShadow(BuildContext context) => const [];

  double progressIndicatorStrokeWidth(BuildContext context);
  Color progressIndicatorValueColor(BuildContext context);
  Color progressIndicatorBackgroundColor(BuildContext context);
}
