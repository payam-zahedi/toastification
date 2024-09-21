import 'package:toastification/toastification.dart';

class StyleFactory {
  static BuiltInStyle createStyle(
      ToastificationStyle style, ToastificationType type) {
    return switch (style) {
      ToastificationStyle.minimal => MinimalStyle(type),
      ToastificationStyle.fillColored => FilledStyle(type),
      ToastificationStyle.flatColored => FlatColoredStyle(type),
      ToastificationStyle.flat => FlatStyle(type),
      ToastificationStyle.simple => SimpleStyle(type),
    };
  }
}
