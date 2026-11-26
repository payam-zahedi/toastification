import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

class StandardToastStyleFactory {
  const StandardToastStyleFactory._();

  static BaseStandardToastStyle createStyle({
    required StandardStyle style,
    required ToastificationType type,
    StandardStyleValues? providedValues,
    ThemeData? flutterTheme,
    Brightness brightness = Brightness.light,
  }) {
    return switch (style) {
      StandardStyle.minimal => MinimalStandardToastStyle(
        type: type,
        providedValues: providedValues,
        flutterTheme: flutterTheme,
        brightness: brightness,
      ),
      StandardStyle.fillColored => FilledStandardToastStyle(
        type: type,
        providedValues: providedValues,
        flutterTheme: flutterTheme,
        brightness: brightness,
      ),
      StandardStyle.flatColored => FlatStandardColoredToastStyle(
        type: type,
        providedValues: providedValues,
        flutterTheme: flutterTheme,
        brightness: brightness,
      ),
      StandardStyle.flat => FlatStandardToastStyle(
        type: type,
        providedValues: providedValues,
        flutterTheme: flutterTheme,
        brightness: brightness,
      ),
      StandardStyle.simple => SimpleStandardToastStyle(
        type: type,
        providedValues: providedValues,
        flutterTheme: flutterTheme,
        brightness: brightness,
      ),
    };
  }
}
