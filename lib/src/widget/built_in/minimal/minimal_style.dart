import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in_style.dart';
import 'package:toastification/toastification.dart';

class MinimalStyle extends BuiltInStyle {
  const MinimalStyle(ToastificationType type) : super(type);

  @override
  EdgeInsetsGeometry padding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 18, vertical: 14);
  }

  @override
  MaterialColor primaryColor(BuildContext context) {
    final color = switch (type) {
      ToastificationType.info => const Color(0xff84C4FF),
      ToastificationType.warning => const Color(0xffFFCE84),
      ToastificationType.success => const Color(0xff59C83E),
      ToastificationType.failed => const Color(0xffFF8484),
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
    return Colors.black;
  }

  @override
  IconData icon(BuildContext context) {
    return switch (type) {
      ToastificationType.info => Icons.question_mark_rounded,
      ToastificationType.warning => Icons.warning_amber_rounded,
      ToastificationType.success => Icons.done,
      ToastificationType.failed => Icons.priority_high_rounded,
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
    return const BorderSide(
      color: Color(0xffEBEBEB),
      width: 2,
    );
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(16));
  }

  @override
  TextStyle? titleTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
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
