import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/toastification_theme.dart';
import 'package:toastification/toastification.dart';

extension ContextExt on BuildContext {
  ToastificationTheme get toastTheme =>
      ToastificationThemeInherited.of(this).theme;
}
