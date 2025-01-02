import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class StandardToastWidget extends Widget {
  const StandardToastWidget({super.key});

  Widget buildBody(ToastificationThemeData toastificationTheme);
}
