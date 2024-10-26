import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/factory/base_style.dart';
import 'package:toastification/toastification.dart';

class FlatColoredStyle extends BaseStyle {
  FlatColoredStyle(ToastificationType type, ThemeData theme)
      : super(type, theme);

  @override
  Color get backgroundColor => primaryColor.shade50;

  @override
  BorderSide get borderSide => BorderSide(
        color: primaryColor,
        width: 1.5,
      );

  @override
  double get elevation => 0.0;

  @override
  Color get foregroundColor => Colors.black;

  @override
  Color get iconColor => foregroundColor;
}
