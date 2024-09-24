import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/factory/base_style.dart';
import 'package:toastification/toastification.dart';

class MinimalStyle extends BaseStyle {
  MinimalStyle(ToastificationType type, ThemeData theme) : super(type, theme);

  @override
  Color get backgroundColor => theme.brightness == Brightness.light
      ? const Color(0xffFfffff)
      : const Color(0xff2B2B2B);

  @override
  BorderSide get borderSide => const BorderSide(
        color: Color(0xffEBEBEB),
        width: 1.5,
      );

  @override
  Color get foregroundColor =>
      theme.brightness == Brightness.light ? Colors.black : Colors.white;

  @override
  Color get iconColor => primaryColor;

}
