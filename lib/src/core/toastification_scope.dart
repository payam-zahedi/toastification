import 'package:flutter/widgets.dart';

/// Decides which toasts are shown together.
///
/// set it with [ToastificationConfig.scope].
enum ToastificationScope {
  /// all the toasts of the app with the same alignment are shown in one list,
  /// in the overlay of the first one.
  ///
  /// This is the default value.
  app,

  /// each [Overlay] shows its own toasts.
  ///
  /// use it when the app has more than one overlay and each one should show
  /// the toasts that were requested for it, for example:
  /// - a desktop app with several windows
  /// - nested navigators, like a bottom navigation bar where each tab has
  ///   its own [Navigator], or a `ShellRoute` of go_router
  ///
  /// two overlays that cover the same area, like a nested navigator and its
  /// parent, draw their toasts on top of each other.
  overlay,
}
