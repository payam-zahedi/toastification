import 'package:material_ui/material_ui.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class SimpleStandardToastStyle extends BaseStandardToastStyle {
  const SimpleStandardToastStyle({
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
      borderSide: const BorderSide(color: Color(0xffEBEBEB), width: 1.5),
      constraints: const BoxConstraints(),
    ),
    // surfaceLight is the background, so it holds the dark surface.
    Brightness.dark => DefaultStyleValues(
      primaryColor: type.color.toMaterialColor,
      surfaceLight: const Color(0xff2B2B2B),
      surfaceDark: Colors.white,
      borderSide: const BorderSide(color: Color(0xff3F3F3F), width: 1.5),
      constraints: const BoxConstraints(),
    ),
  };

  @override
  Color get iconColor => primaryColor;
}
