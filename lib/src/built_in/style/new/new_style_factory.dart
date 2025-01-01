import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/new/filled_style.dart';
import 'package:toastification/src/built_in/style/new/flat_colored_style.dart';
import 'package:toastification/src/built_in/style/new/flat_style.dart';
import 'package:toastification/src/built_in/style/new/minimal_style.dart';
import 'package:toastification/src/built_in/style/new/simple_style.dart';
import 'package:toastification/toastification.dart';

class NewStyleFactory {
  static BaseToastStyle createStyle({
    required ToastificationStyle style,
    required ToastificationType type,
    StyleValues? providedValues,
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
