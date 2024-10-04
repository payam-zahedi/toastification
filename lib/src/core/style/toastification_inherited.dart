import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';

class ToastificationThemeInherited extends InheritedWidget {
  final ToastificationTheme theme;

  const ToastificationThemeInherited({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  static ToastificationThemeInherited of(BuildContext context) {
    final ToastificationThemeInherited? result = context
        .dependOnInheritedWidgetOfExactType<ToastificationThemeInherited>();
    assert(result != null, 'No ToastificationThemeInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ToastificationThemeInherited oldWidget) {
    return theme != oldWidget.theme;
  }
}
