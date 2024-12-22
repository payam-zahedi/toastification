import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';
import 'package:toastification/src/core/style/toastification_theme.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';

class FlatToastWidget extends StatelessWidget {
  const FlatToastWidget({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.onCloseTap,
    this.showCloseButton = true,
    this.progressBarValue,
    this.progressBarWidget,
    this.actionButtons
  });

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final VoidCallback? onCloseTap;
  final bool showCloseButton;

  final double? progressBarValue;
  final Widget? progressBarWidget;
  final List<Widget>? actionButtons;

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
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: toastTheme.decorationColor,
        borderRadius: toastTheme.borderRadius,
        border: toastTheme.decorationBorder,
        boxShadow: toastTheme.boxShadow,
      ),
      padding: toastTheme.padding,
      child: Column(
        children: [
          Row(
            children: [
              Offstage(
                offstage: !toastTheme.showIcon,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: icon ??
                      Icon(
                        toastTheme.icon,
                        size: 24,
                        color: toastTheme.primary ?? toastTheme.iconColor,
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
              ToastCloseButton(
                onCloseTap: onCloseTap,
                showCloseButton: showCloseButton,
              ),          
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: actionButtons ?? [],
          )
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
