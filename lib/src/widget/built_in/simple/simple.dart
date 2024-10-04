import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    this.title,
  });

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.toastTheme.direction,
      child: Center(
        child: buildContent(context.toastTheme),
      ),
    );
  }

  Widget buildContent(ToastificationTheme toastTheme) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: toastTheme.decorationColor,
        border: toastTheme.decorationBorder,
        boxShadow: toastTheme.boxShadow,
        borderRadius: toastTheme.borderRadius,
      ),
      padding: toastTheme.padding,
      child: BuiltInContent(
        title: title,
        description: null,
        progressBarValue: null,
        progressBarWidget: null,
      ),
    );

    if (toastTheme.applyBlurEffect) {
      body = ClipRRect(
        borderRadius: toastTheme.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
