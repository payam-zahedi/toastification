import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

extension ContextExt on BuildContext {
  ToastificationThemeData get toastTheme => ToastificationTheme.of(this);
}
