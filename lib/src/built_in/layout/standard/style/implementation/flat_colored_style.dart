import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class FlatColoredToastStyle extends BaseToastStyle {
  FlatColoredToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => DefaultStyleValues(
        primaryColor: type.color.toMaterialColor,
        backgroundColor: type.color.toMaterialColor.shade50,
        foregroundColor: Colors.black,
      );

  @override
  Color get backgroundColor => primaryColor.shade50;
  // providedValues.primaryColor ?? primaryColor.shade50;

  @override
  Color get iconColor =>
      providedValues?.foregroundColor ?? defaults.foregroundColor;

  @override
  BorderSide get borderSide =>
      providedValues?.borderSide ??
      BorderSide(
        color: primaryColor,
        width: 1.5,
      );
}
