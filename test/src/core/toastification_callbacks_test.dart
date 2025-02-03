// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('ToastificationCallbacks', () {
    test('should create an instance with all callbacks', () {
      final ValueChanged<ToastificationItem> onTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onCloseButtonTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onAutoCompleteCompleted =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onDismissed =
          (ToastificationItem item) {};

      final callbacks = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      expect(callbacks.onTap, equals(onTap));
      expect(callbacks.onCloseButtonTap, equals(onCloseButtonTap));
      expect(
          callbacks.onAutoCompleteCompleted, equals(onAutoCompleteCompleted));
      expect(callbacks.onDismissed, equals(onDismissed));
    });

    test('should create an instance with no callbacks', () {
      final callbacks = const ToastificationCallbacks();

      expect(callbacks.onTap, isNull);
      expect(callbacks.onCloseButtonTap, isNull);
      expect(callbacks.onAutoCompleteCompleted, isNull);
      expect(callbacks.onDismissed, isNull);
    });

    test('props should contain all callbacks', () {
      final ValueChanged<ToastificationItem> onTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onCloseButtonTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onAutoCompleteCompleted =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onDismissed =
          (ToastificationItem item) {};

      final callbacks = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      expect(callbacks.props, [
        onTap,
        onCloseButtonTap,
        onAutoCompleteCompleted,
        onDismissed,
      ]);
    });

    test('should be equal if all properties are equal', () {
      final ValueChanged<ToastificationItem> onTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onCloseButtonTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onAutoCompleteCompleted =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onDismissed =
          (ToastificationItem item) {};

      final callbacks1 = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      final callbacks2 = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      expect(callbacks1, equals(callbacks2));
    });

    test('should have the same hashcode if all properties are equal', () {
      final ValueChanged<ToastificationItem> onTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onCloseButtonTap =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onAutoCompleteCompleted =
          (ToastificationItem item) {};
      final ValueChanged<ToastificationItem> onDismissed =
          (ToastificationItem item) {};

      final callbacks1 = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      final callbacks2 = ToastificationCallbacks(
        onTap: onTap,
        onCloseButtonTap: onCloseButtonTap,
        onAutoCompleteCompleted: onAutoCompleteCompleted,
        onDismissed: onDismissed,
      );

      expect(callbacks1.hashCode, equals(callbacks2.hashCode));
    });
  });
}
