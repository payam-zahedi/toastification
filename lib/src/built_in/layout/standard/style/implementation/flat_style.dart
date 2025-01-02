import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class FlatStandardToastStyle extends BaseStandardToastStyle {
  FlatStandardToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => DefaultStyleValues(
        primaryColor: type.color.toMaterialColor,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
        borderSide: const BorderSide(
          color: Color(0xffEBEBEB),
          width: 1.5,
        ),
      );

  @override
  Color get iconColor => providedValues?.primaryColor ?? defaults.primaryColor;
}
