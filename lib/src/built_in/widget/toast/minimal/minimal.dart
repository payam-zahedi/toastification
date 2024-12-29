import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';
import 'package:toastification/src/built_in/style/toastification_theme.dart';
import 'package:toastification/src/built_in/widget/common/toast_content.dart';
import 'package:toastification/src/built_in/widget/common/close_button.dart';

//todo we should set resolve
class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Material(
            color: Colors.transparent,
            shape: LinearBorder.start(
              side: BorderSide(
                color: context.toastTheme.primaryColor,
                width: 3,
              ),
            ),
            child: buildBody(context.toastTheme),
          ),
        ),
      ),
    );
  }

  Widget buildBody(ToastificationTheme toastTheme) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: toastTheme.decorationColor,
        borderRadius: toastTheme.effectiveBorderRadius(
          toastTheme.borderRadius.resolve(toastTheme.direction),
        ),
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
                    color: toastTheme.primary ?? toastTheme.iconColor,
                  ),
            ),
          ),
          Expanded(
            child: ToastContent(
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
      body = body = ClipRRect(
        borderRadius: toastTheme.effectiveBorderRadius(
          toastTheme.borderRadius.resolve(toastTheme.direction),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
