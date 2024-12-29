import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/style/factory/base_style.dart';

class SimpleStyle extends BaseStyle {
  SimpleStyle(super.type, super.theme);

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
