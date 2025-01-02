import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class StandardToastStyleFactory {
  const StandardToastStyleFactory._();

  static BaseToastStyle createStyle({
    required ToastificationStyle style,
    required ToastificationType type,
    StandardStyleValues? providedValues,
    ThemeData? flutterTheme,
  }) {
    return switch (style) {
      ToastificationStyle.minimal => MinimalToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      ToastificationStyle.fillColored => FilledToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      ToastificationStyle.flatColored => FlatColoredToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      ToastificationStyle.flat => FlatToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
      ToastificationStyle.simple => SimpleToastStyle(
          type: type,
          providedValues: providedValues,
          flutterTheme: flutterTheme,
        ),
    };
  }
}
