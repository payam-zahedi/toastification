import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class SimpleToastStyle extends BaseToastStyle {
  SimpleToastStyle({
    required super.type,
    required super.providedValues,
    required super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => DefaultStyleValues(
        primaryColor: type.color.toMaterialColor,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        borderSide: const BorderSide(
          color: Color(0xffEBEBEB),
          width: 1.5,
        ),
      );

  @override
  Color get iconColor => primaryColor;
}
