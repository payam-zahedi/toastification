import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/toastification_theme_data.dart';
import 'package:toastification/toastification.dart';

extension ContextExt on BuildContext {
  ToastificationThemeData get toastTheme =>
      ToastificationThemeInherited.of(this).theme;
}
