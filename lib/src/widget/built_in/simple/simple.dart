import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({super.key, required this.toastModel});
  final ToastModel toastModel;

  SimpleStyle get defaultStyle => SimpleStyle(toastModel.type);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: toastModel.direction ?? Directionality.of(context),
      child: Center(
        child: buildContent(
          context: context,
          background: toastModel.backgroundColor ??
              defaultStyle.backgroundColor(context),
          borderSide: toastModel.borderSide ?? defaultStyle.borderSide(context),
          borderRadius:
              toastModel.borderRadius ?? defaultStyle.borderRadius(context),
          applyBlurEffect: toastModel.applyBlurEffect,
        ),
      ),
    );
  }

  Widget buildContent({
    required BuildContext context,
    required Color background,
    required BorderSide borderSide,
    required BorderRadiusGeometry borderRadius,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        border: Border.fromBorderSide(borderSide),
        boxShadow: toastModel.boxShadow ?? defaultStyle.boxShadow(context),
        borderRadius: borderRadius,
      ),
      padding: toastModel.padding ?? defaultStyle.padding(context),
      child: BuiltInContent(
        contentModel: toastModel.getBuildInContentModel(style: defaultStyle),
      ),
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
