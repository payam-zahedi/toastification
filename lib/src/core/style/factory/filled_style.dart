import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/factory/base_style.dart';

class FilledStyle extends BaseStyle {
  FilledStyle(super.type, super.theme);

  @override
  Color get backgroundColor => primaryColor;

  @override
  Color get iconColor => foregroundColor;

  @override
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: foregroundColor.withOpacity(.30),
        linearMinHeight: progressIndicatorStrokeWidth,
        linearTrackColor: foregroundColor.withOpacity(.15),
        refreshBackgroundColor: foregroundColor.withOpacity(.15),
      );
}
