// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

class ToastificationIcons {
  const ToastificationIcons._();

  static const _kFontFam = 'Toastification_icons';
  static const String _kFontPkg = 'toastification';

  static const IconData info_circle =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData close_circle =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData tick_circle =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData warning_circle =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
