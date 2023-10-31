import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// A set of callbacks that you can provide to a [Toastification] widget.
/// Used to listen for various events in the lifecycle of the [Toastification].
/// All of the callbacks are optional.
///
class ToastificationCallbacks {
  /// Creates a set of callbacks that you can provide to a [Toastification] widget.
  const ToastificationCallbacks({
    this.onTap,
    this.onCloseButtonTap,
    this.onAutoCompleteCompleted,
    this.onDismissed,
  });

  /// Called when the toast is tapped by a user.
  final ValueChanged<ToastificationItem>? onTap;

  /// Called when the toast close button is tapped by a user.
  ///
  /// the default behavior is to close the toast with [Toastification.dismiss] method
  /// so if you are overriding this method you should handle it by your self.
  final ValueChanged<ToastificationItem>? onCloseButtonTap;

  /// Called when the toast close by timer.
  final ValueChanged<ToastificationItem>? onAutoCompleteCompleted;

  /// Called when the toast is dismissed by a user gesture (e.g. a swipe).
  final ValueChanged<ToastificationItem>? onDismissed;
}
