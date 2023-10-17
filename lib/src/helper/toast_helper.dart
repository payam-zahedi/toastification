import 'package:flutter/material.dart';

/// ToastHelper is a helper class that contains some useful utility methods like [convertRange] and [createMaterialColor]
class ToastHelper {
  const ToastHelper._();

  /// Converts a value from one range to another
  ///
  /// example:
  /// ```dart
  /// convertRange(0, 100, 0, 1, 50) // returns 0.5
  /// ```
  ///
  static double convertRange(
    double originalStart,
    double originalEnd,
    double newStart,
    double newEnd,
    double value,
  ) {
    double scale = (newEnd - newStart) / (originalEnd - originalStart);
    return (newStart + ((value - originalStart) * scale));
  }

  /// creates a [MaterialColor] from a given [Color]
  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};

    final r = color.red, g = color.green, b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = .95 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
