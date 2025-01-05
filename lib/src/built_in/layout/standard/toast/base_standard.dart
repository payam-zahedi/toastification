import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// TODO: maybe we can use adapter pattern here
// converting widget style model to widget

// TODO: for diffrent layouts of each type maybe we can use decorator pattern
abstract class StandardToastWidget extends Widget {
  const StandardToastWidget({super.key});

  // TODO: convert it to render method
  // add build context
  Widget buildBody(ToastificationThemeData toastificationTheme);
}
