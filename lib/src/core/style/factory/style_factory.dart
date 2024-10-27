import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class StyleFactory {
  static BuiltInStyle createStyle(
    ToastificationStyle style,
    ToastificationType type,
    ThemeData theme,
  ) {
    return switch (style) {
      ToastificationStyle.minimal => MinimalStyle(type, theme),
      ToastificationStyle.fillColored => FilledStyle(type, theme),
      ToastificationStyle.flatColored => FlatColoredStyle(type, theme),
      ToastificationStyle.flat => FlatStyle(type, theme),
      ToastificationStyle.simple => SimpleStyle(type, theme),
    };
  }
}
