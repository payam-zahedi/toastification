import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/toastification_inherited.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/toastification.dart';

class ToastificationThemeProvider extends StatelessWidget {
  final BuiltInStyle defaultStyle;
  final Widget child;
  final ToastificationTheme Function(ToastificationTheme)? themeBuilder;

  const ToastificationThemeProvider({
    Key? key,
    required this.defaultStyle,
    required this.child,
    this.themeBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastificationTheme theme = ToastificationTheme(
      defaultStyle: defaultStyle,
      context: context,
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
