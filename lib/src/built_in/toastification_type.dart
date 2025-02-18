import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/src/utils/constants_values.dart';

/// Defines the visual and behavioral characteristics of built-in toast notifications.
/// This class is used by the [BuiltInBuilder] to style and render different types
/// of notifications with consistent appearance.
///
/// Each type comes with predefined:
/// - A unique name identifier
/// - A theme color that affects the toast's appearance
/// - An icon that represents the notification type
///
/// The package provides four built-in types:
/// - [info] - For general information messages (blue)
/// - [success] - For successful operations (green)
/// - [warning] - For warning messages (yellow/orange)
/// - [error] - For error messages (red)
///
/// Usage example with [Toastification.show]:
/// ```dart
/// toastification.show(
///   type: ToastificationType.success,
///   title: Text('Operation Successful'),
///   description: Text('Your changes have been saved'),
/// );
/// ```
///
/// You can also create custom types:
/// ```dart
/// final customType = ToastificationType.custom(
///   'custom',
///   Colors.purple,
///   Icons.star,
/// );
/// ```
class ToastificationType {
  /// The unique identifier name for this toast type
  final String name;

  /// The color associated with this toast type
  final Color color;

  /// The icon to be displayed with this toast type
  final IconData icon;

  const ToastificationType._(this.name, this.color, this.icon);

  /// Predefined information toast type with blue color scheme and info icon
  static const info =
      ToastificationType._('info', infoColor, Iconsax.info_circle_copy);

  /// Predefined success toast type with green color scheme and checkmark icon
  static const success =
      ToastificationType._('success', successColor, Iconsax.tick_circle_copy);

  /// Predefined warning toast type with yellow/orange color scheme and warning icon
  static const warning =
      ToastificationType._('warning', warningColor, Iconsax.danger_copy);

  /// Predefined error toast type with red color scheme and close icon
  static const error =
      ToastificationType._('error', errorColor, Iconsax.close_circle_copy);

  /// Creates a custom toast type with specified name, color and icon.
  ///
  /// Use this constructor when the predefined toast types don't meet your needs.
  ///
  /// Parameters:
  ///   [name] - Unique identifier for the custom toast type
  ///   [color] - Custom color for the toast
  ///   [icon] - Custom icon to be displayed
  const factory ToastificationType.custom(
      String name, Color color, IconData icon) = ToastificationType._;

  /// Returns a list of all predefined toast types
  static List<ToastificationType> get defaultValues =>
      [info, success, warning, error];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToastificationType &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'ToastificationType.$name';
  }
}
