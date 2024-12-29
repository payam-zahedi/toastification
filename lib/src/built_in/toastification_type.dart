import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/src/utils/constants_values.dart';

class ToastificationType {
  final String name;
  final Color color;
  final IconData icon;
  const ToastificationType._(this.name, this.color, this.icon);

  // Built-in types
  static const info =
      ToastificationType._('info', infoColor, Iconsax.info_circle_copy);
  static const success =
      ToastificationType._('success', successColor, Iconsax.tick_circle_copy);
  static const warning =
      ToastificationType._('warning', warningColor, Iconsax.danger_copy);
  static const error =
      ToastificationType._('error', errorColor, Iconsax.close_circle_copy);

  // Factory for custom types
  static ToastificationType custom(String name, Color color, IconData icon) {
    return ToastificationType._(name, color, icon);
  }

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
