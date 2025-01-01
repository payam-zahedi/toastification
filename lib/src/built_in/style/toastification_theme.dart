import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/toastification_theme_data.dart';

class ToastificationTheme extends InheritedTheme {
  const ToastificationTheme({
    super.key,
    required this.themeData,
    required super.child,
  });

  final ToastificationThemeData themeData;

  static ToastificationThemeData of(BuildContext context) {
    final ToastificationTheme? result =
        context.dependOnInheritedWidgetOfExactType<ToastificationTheme>();
    assert(result != null, 'No ToastificationTheme Widget found in context');
    return result!.themeData;
  }

  @override
  bool updateShouldNotify(covariant ToastificationTheme oldWidget) {
    return oldWidget.themeData != themeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ToastificationTheme(
      themeData: themeData,
      child: child,
    );
  }
}
