import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/theme/toastification_theme_data.dart';

/// An inherited widget that defines the configuration for
/// toastification themes in this widget's subtree.
class ToastificationTheme extends InheritedTheme {
  /// Creates a toastification theme that controls the appearance of
  /// toastification widgets.
  const ToastificationTheme({
    super.key,
    required this.themeData,
    required super.child,
  });

  /// The data for the toastification theme.
  final ToastificationThemeData themeData;

  /// Returns the [ToastificationThemeData] from the closest
  /// [ToastificationTheme] ancestor.
  ///
  /// If there is no ancestor, it will assert in debug mode.
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
