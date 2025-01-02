import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class FilledToastStyle extends BaseToastStyle {
  FilledToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => DefaultStyleValues(
        primaryColor: type.color.toMaterialColor,
        backgroundColor: type.color.toMaterialColor,
        foregroundColor: Colors.white,
      );

  @override
  Color get backgroundColor => primaryColor;

  @override
  Color blurredBackgroundColor(bool applyBlur, Color color) =>
      applyBlur ? color.withValues(alpha: 0.8) : color;

  @override
  Color get iconColor =>
      providedValues?.foregroundColor ?? defaults.foregroundColor;

  @override
  ProgressIndicatorThemeData get defaultProgressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: foregroundColor.withValues(alpha: .30),
        linearMinHeight: progressIndicatorStrokeWidth,
        linearTrackColor: foregroundColor.withValues(alpha: .15),
        refreshBackgroundColor: foregroundColor.withValues(alpha: .15),
      );
}
