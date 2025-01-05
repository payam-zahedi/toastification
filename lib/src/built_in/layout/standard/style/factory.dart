import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class StandardToastStyleFactory {
  const StandardToastStyleFactory._();

  static BaseStandardToastStyle createStyle({
    required StandardStyle style,
    required ToastificationType type,
    StandardStyleValues? providedValues,
    ThemeData? flutterTheme,
  }) {
    return switch (style) {
      StandardStyle.minimal => MinimalStandardToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      StandardStyle.fillColored => FilledStandardToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      StandardStyle.flatColored => FlatStandardColoredToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      StandardStyle.flat => FlatStandardToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      StandardStyle.simple => SimpleStandardToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
    };
  }
}
