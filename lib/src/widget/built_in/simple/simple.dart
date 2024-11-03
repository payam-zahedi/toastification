import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/src/core/context_ext.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    this.title,
    this.showCloseButton = true,
    this.onCloseTap,
  });

  final Widget? title;

  final bool showCloseButton;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.toastTheme.direction,
      child: Center(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: buildContent(
            toastTheme: context.toastTheme,
          ),
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
            description: null,
            progressBarValue: null,
            progressBarWidget: null,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: ToastCloseButton(
            showCloseButton: showCloseButton,
            onCloseTap: onCloseTap,
          ),
        ),
      ],
    );

    body = Container(
      constraints: const BoxConstraints(
        minHeight: 65.0,
      ),
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
