import 'package:flutter/material.dart';

enum ToastificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,
}

enum ToastificationType {
  info,
  warning,
  success,
  failed,
}

mixin BuiltInToastWidget on Widget {
  ToastificationType get type;

  MaterialColor buildColor(BuildContext context);

  IconData buildIcon(BuildContext context);

  BorderRadiusGeometry buildBorderRadius(BuildContext context);
}
