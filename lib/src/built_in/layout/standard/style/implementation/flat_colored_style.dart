import 'package:material_ui/material_ui.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class FlatStandardColoredToastStyle extends BaseStandardToastStyle {
  const FlatStandardColoredToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
    super.brightness,
  });

  @override
  DefaultStyleValues get defaults => switch (brightness) {
    Brightness.light => DefaultStyleValues(
      primaryColor: type.color.toMaterialColor,
      surfaceLight: Colors.white,
      surfaceDark: Colors.black,
    ),
    // surfaceLight is the background, so it holds the dark surface.
    Brightness.dark => DefaultStyleValues(
      primaryColor: type.color.toMaterialColor,
      surfaceLight: const Color(0xff2B2B2B),
      surfaceDark: Colors.white,
    ),
  };

  @override
  Color get backgroundColor => switch (brightness) {
    Brightness.light => primaryColor.shade50,
    // a faint tint of the type color, like shade50 but over the dark surface.
    Brightness.dark => Color.alphaBlend(
      primaryColor.withValues(alpha: .15),
      defaults.surfaceLight,
    ),
  };

  @override
  Color get iconColor => providedValues?.surfaceDark ?? defaults.surfaceDark;

  @override
  BorderSide get borderSide =>
      providedValues?.borderSide ?? BorderSide(color: primaryColor, width: 1.5);
}
