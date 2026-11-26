/// Defines whether built-in toasts use their light or dark colors.
///
/// Set it with [ToastificationConfig.themeMode] on [ToastificationWrapper],
/// or on a [ToastificationConfigProvider] in `MaterialApp.builder`:
/// ```dart
/// ToastificationWrapper(
///   config: ToastificationConfig(
///     themeMode: ToastificationThemeMode.followAppTheme,
///   ),
///   child: MaterialApp(...),
/// );
/// ```
///
/// Colors you pass to `show()` are applied the same way in both modes.
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
