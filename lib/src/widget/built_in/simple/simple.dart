import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    required this.styleParameters,
    this.title,
  });

  final StyleParameters styleParameters;

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: styleParameters.direction,
      child: Center(
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    Widget body = Container(
      decoration: BoxDecoration(
        color: styleParameters.decorationColor,
        border: styleParameters.decorationBorder,
        boxShadow: styleParameters.boxShadow,
        borderRadius: styleParameters.borderRadius,
      ),
      padding: styleParameters.padding,
      child: BuiltInContent(
        styleParameters: styleParameters,
        title: title,
        description: null,
        progressBarValue: null,
        progressBarWidget: null,
      ),
    );

    if (styleParameters.applyBlurEffect) {
      body = ClipRRect(
        borderRadius: styleParameters.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
