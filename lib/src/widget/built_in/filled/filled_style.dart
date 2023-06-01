import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in_style.dart';
import 'package:toastification/toastification.dart';

class FilledStyle extends BuiltInStyle {
  const FilledStyle(ToastificationType type) : super(type);

  @override
  EdgeInsetsGeometry padding(BuildContext context) {
    return const EdgeInsets.all(12);
  }

  @override
  MaterialColor primaryColor(BuildContext context) {
    final color = switch (type) {
      ToastificationType.info => Colors.blue,
      ToastificationType.warning => Colors.amber,
      ToastificationType.success => Colors.green,
      ToastificationType.failed => Colors.red,
    };

    return color;
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
  IconData icon(BuildContext context) {
    return switch (type) {
      ToastificationType.info => Icons.info,
      ToastificationType.warning => Icons.warning_rounded,
      ToastificationType.success => Icons.check_rounded,
      ToastificationType.failed => Icons.error,
    };
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
    return foregroundColor(context).withOpacity(.4);
  }

  @override
  BorderSide borderSide(BuildContext context) {
    return BorderSide.none;
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(8));
  }

  @override
  TextStyle? titleTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: foregroundColor(context),
          fontWeight: FontWeight.w500,
          height: 1.3,
        );
  }

  @override
  TextStyle? descriptionTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          color: foregroundColor(context),
          height: 1.3,
        );
  }

  @override
  double elevation(BuildContext context) {
    return 8.0;
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
