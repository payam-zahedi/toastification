import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Utility class for color manipulation and conversion operations.
class ColorUtils {
  const ColorUtils._();

  /// Converts a [Color] to [MaterialColor] if possible.
  ///
  /// This method attempts to:
  /// 1. Return null if the input color is null
  /// 2. Return the color directly if it's already a [MaterialColor]
  /// 3. Find a matching primary color from [Colors.primaries]
  /// 4. Create a new [MaterialColor] if no match is found
  ///
  /// Returns a [MaterialColor] instance or null if the input is null.
  static MaterialColor? convertToMaterialColor(Color? color) {
    if (color == null) return null;

    if (color is MaterialColor) return color;

    final findInMaterialColors = Colors.primaries
        .firstWhereOrNull((element) => element.shade500 == color);

    return findInMaterialColors ?? createMaterialColor(color);
  }

  /// Creates a custom [MaterialColor] swatch from a base [Color].
  ///
  /// Generates a complete swatch of shades based on the input color by:
  /// - Creating 10 different strength variations of the color
  /// - Adjusting RGB values for each strength level
  /// - Maintaining the alpha channel at 1.0 (fully opaque)
  ///
  /// Returns a [MaterialColor] with the generated swatch map.
  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};

    final r = color.intRed, g = color.intGreen, b = color.intBlue;

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

    final colorIntValue = color.intValue;

    return MaterialColor(colorIntValue, swatch);
  }
}

/// Extension on [Color] to provide integer-based color component access.
///
/// Adds functionality to get color components (ARGB) as 8-bit integers
/// and retrieve the complete color value as a 32-bit integer.
extension IntColorComponents on Color {
  /// Alpha component as an 8-bit integer (0-255)
  int get intAlpha => alpha;

  /// Red component as an 8-bit integer (0-255)
  int get intRed => _floatToInt8(r);

  /// Green component as an 8-bit integer (0-255)
  int get intGreen => _floatToInt8(g);

  /// Blue component as an 8-bit integer (0-255)
  int get intBlue => _floatToInt8(b);

  /// Complete color value as a 32-bit integer in ARGB format
  int get intValue => intAlpha << 24 | intRed << 16 | intGreen << 8 | intBlue;

  /// Converts a normalized float color component (0.0-1.0) to an 8-bit integer (0-255)
  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }

  MaterialColor get toMaterialColor => ColorUtils.convertToMaterialColor(this)!;
}
