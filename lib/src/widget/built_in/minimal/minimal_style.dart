import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class MinimalStyle extends BuiltInStyle {
  const MinimalStyle(ToastificationType type) : super(type);

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
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xffFfffff)
        : const Color(0xff2B2B2B);
  }

  @override
  Color foregroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  @override
  IconData icon(BuildContext context) {
    return switch (type) {
      ToastificationType.info => Icons.stop_circle,
      ToastificationType.warning => Icons.stop_circle,
      ToastificationType.success => Icons.stop_circle,
      ToastificationType.error => Icons.stop_circle,
    };
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
    return primaryColor(context).shade100;
  }

  @override
  BorderSide borderSide(BuildContext context) {
    return const BorderSide(
      color: Color(0xffEBEBEB),
      width: 1.5,
    );
  }

  BoxBorder boxBorder(BuildContext context) {
    return Border.fromBorderSide(
      borderSide(context),
    );
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(12));
  }

  BorderRadiusGeometry effectiveBorderRadius(BorderRadius borderRadius) {
    return BorderRadiusDirectional.only(
      topEnd: borderRadius.topRight.clamp(
        minimum: const Radius.circular(0),
        maximum: const Radius.circular(30),
      ),
      bottomEnd: borderRadius.bottomRight.clamp(
        minimum: const Radius.circular(0),
        maximum: const Radius.circular(30),
      ),
    );
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
