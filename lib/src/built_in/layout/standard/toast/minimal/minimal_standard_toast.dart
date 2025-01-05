import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/toast/base_standard.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';
import 'package:toastification/src/built_in/theme/toastification_theme_data.dart';
import 'package:toastification/src/built_in/widget/common/toast_content.dart';
import 'package:toastification/src/built_in/widget/common/close_button.dart';

class MinimalStandardToastWidget extends StatelessWidget
    implements StandardToastWidget {
  const MinimalStandardToastWidget({
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
    final toastStyle = context.toastTheme.toastStyle!;

    return Directionality(
      textDirection: context.toastTheme.direction,
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: toastStyle.iconColor),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Material(
            color: Colors.transparent,
            shape: LinearBorder.start(
              side: BorderSide(
                color: toastStyle.primaryColor,
                width: 3,
              ),
            ),
            child: buildBody(context.toastTheme),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildBody(ToastificationThemeData toastTheme) {
    final toastStyle = toastTheme.toastStyle!;

    Widget body = Container(
      decoration: BoxDecoration(
        color: toastStyle.blurredBackgroundColor(
          toastTheme.applyBlurEffect,
          toastStyle.backgroundColor,
        ),
        borderRadius: effectiveBorderRadius(
          toastStyle.borderRadius.resolve(toastTheme.direction),
        ),
        border: Border.fromBorderSide(toastStyle.borderSide),
        boxShadow: toastStyle.boxShadow,
      ),
      padding: toastStyle.padding,
      child: Row(
        children: [
          Offstage(
            offstage: !toastTheme.showIcon,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: icon ??
                  Icon(
                    toastStyle.icon,
                    size: 24,
                    color: toastStyle.iconColor,
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
        borderRadius: effectiveBorderRadius(
          toastStyle.borderRadius.resolve(toastTheme.direction),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }

  BorderRadiusGeometry effectiveBorderRadius(BorderRadius borderRadius) =>
      BorderRadiusDirectional.only(
        topEnd: borderRadius.topRight.clamp(
          minimum: const Radius.circular(0),
          maximum: const Radius.circular(30),
        ),
        bottomEnd: borderRadius.bottomRight.clamp(
          minimum: const Radius.circular(0),
          maximum: const Radius.circular(30),
        ),
      );
}
