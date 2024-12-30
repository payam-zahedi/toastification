import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/toastification_theme_data.dart';
import 'package:toastification/toastification.dart';

class ToastificationThemeProvider extends StatelessWidget {
  final BuiltInStyle selectedStyle;
  final TextDirection textDirection;
  final Widget child;

  final ToastificationThemeData Function(ToastificationThemeData)? themeBuilder;

  const ToastificationThemeProvider({
    super.key,
    required this.selectedStyle,
    required this.child,
    required this.textDirection,
    this.themeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    ToastificationThemeData theme = ToastificationThemeData(
      selectedStyle: selectedStyle,
      themeData: Theme.of(context),
      direction: textDirection,
    );
    if (themeBuilder != null) {
      theme = themeBuilder!(theme);
    }

    return ToastificationThemeInherited(
      theme: theme,
      child: child,
    );
  }
}

// TODO: make this class private
class ToastificationThemeInherited extends InheritedWidget {
  final ToastificationThemeData theme;

  const ToastificationThemeInherited({
    super.key,
    required this.theme,
    required super.child,
  });

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
