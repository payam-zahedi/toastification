import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/toastification_inherited.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/toastification.dart';

class ToastificationThemeProvider extends StatelessWidget {
  final BuiltInStyle selectedStyle;
  final TextDirection textDirection;
  final Widget child;

  final ToastificationTheme Function(ToastificationTheme)? themeBuilder;

  const ToastificationThemeProvider({
    Key? key,
    required this.selectedStyle,
    required this.child,
    required this.textDirection,
    this.themeBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastificationTheme theme = ToastificationTheme(
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
