import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';

class FilledToastWidget extends StatelessWidget {
  const FilledToastWidget({
    super.key,
    this.title,
    this.description,
    this.icon,
    required this.onCloseTap,
    this.showCloseButton = true,
    this.closeButton = const ToastCloseButton(),
    this.progressBarValue,
    this.progressBarWidget,
  });

  final Widget? title;
  final Widget? description;
  final Widget? icon;

  final VoidCallback onCloseTap;
  final bool showCloseButton;
  final ToastCloseButton closeButton;

  final double? progressBarValue;
  final Widget? progressBarWidget;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.toastTheme.direction,
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: context.toastTheme.iconColor),
        child: buildBody(context.toastTheme),
      ),
    );
  }

  Widget buildBody(ToastificationTheme toastTheme) {
    final backgroundColor = toastTheme.primaryColor;

    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: toastTheme.applyBlurEffect
            ? backgroundColor.withOpacity(0.8)
            : backgroundColor,
        borderRadius: toastTheme.borderRadius,
        border: toastTheme.decorationBorder,
        boxShadow: toastTheme.boxShadow,
      ),
      padding: toastTheme.padding,
      child: Row(
        children: [
          Offstage(
            offstage: !toastTheme.showIcon,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: icon ??
                  Icon(
                    toastTheme.icon,
                    size: 24,
                    color: toastTheme.foreground ?? toastTheme.iconColor,
                  ),
            ),
          ),
          Expanded(
            child: BuiltInContent(
              title: title,
              description: description,
              progressBarValue: progressBarValue,
              progressBarWidget: progressBarWidget,
            ),
          ),
          const SizedBox(width: 8),
          ToastCloseButtonHolder(
            onCloseTap: onCloseTap,
            showCloseButton: showCloseButton,
            toastCloseButton: closeButton,
          ),
        ],
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
