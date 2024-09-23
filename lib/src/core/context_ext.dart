import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/toastification_inherited.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';

extension ContextExt on BuildContext {
 ToastificationTheme get toastTheme =>  ToastificationThemeInherited.of(this).theme;
}
