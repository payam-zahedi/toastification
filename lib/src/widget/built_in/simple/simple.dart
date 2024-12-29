import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    this.title,
    this.showCloseButton = true,
    required this.onCloseTap,
    this.closeButton = const ToastCloseButton(),
  });

  final Widget? title;

  final bool showCloseButton;
  final VoidCallback onCloseTap;
  final ToastCloseButton closeButton;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.toastTheme.direction,
      child: Center(
        child: buildContent(
          toastTheme: context.toastTheme,
        ),
      ),
    );
  }

  Widget buildContent({
    required ToastificationTheme toastTheme,
  }) {
    Widget body;

    body = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: BuiltInContent(
            title: title ?? const SizedBox(),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: ToastCloseButtonHolder(
            showCloseButton: showCloseButton,
            onCloseTap: onCloseTap,
            toastCloseButton: closeButton,
          ),
        ),
      ],
    );

    body = Container(
      decoration: BoxDecoration(
        color: toastTheme.decorationColor,
        border: toastTheme.decorationBorder,
        boxShadow: toastTheme.boxShadow,
        borderRadius: toastTheme.borderRadius,
      ),
      padding: toastTheme.padding,
      child: body,
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
