/// Defines whether built-in toasts use their light or dark colors.
///
/// Set it once with [ToastificationConfig.themeMode]:
/// ```dart
/// ToastificationWrapper(
///   config: ToastificationConfig(
///     themeMode: ToastificationThemeMode.followAppTheme,
///   ),
///   child: MaterialApp(...),
/// );
/// ```
///
/// Colors you pass to `show()`, like `backgroundColor`, always win over the
/// light or dark defaults.
enum ToastificationThemeMode {
  /// Always use the light colors. This is the default.
  light,

  /// Always use the dark colors.
  dark,

  /// Use the dark colors when `Theme.of(context).brightness` is
  /// [Brightness.dark], so toasts follow the app's `theme`, `darkTheme` and
  /// `themeMode`.
  followAppTheme,
}
