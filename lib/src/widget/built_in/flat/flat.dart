import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';
import 'package:toastification/src/core/style_parameter_builder.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';

class FlatToastWidget extends StatelessWidget {
  const FlatToastWidget({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.onCloseTap,
    this.progressBarValue,
    this.progressBarWidget,
  });

  final StyleParameters styleParameters;
  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final VoidCallback? onCloseTap;
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
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: context.toastTheme.decorationColor,
        borderRadius: context.toastTheme.borderRadius,
        border: context.toastTheme.decorationBorder,
        boxShadow: context.toastTheme.boxShadow,
      ),
      padding: context.toastTheme.padding,
      child: Row(
        children: [
          Offstage(
            offstage: !context.toastTheme.showIcon,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: icon ??
                  Icon(
                    context.toastTheme.icon,
                    size: 24,
                    color: context.toastTheme.iconColor,
                  ),
            ),
          ),
          Expanded(
            child: BuiltInContent(
              styleParameters: styleParameters,
              title: title,
              description: description,
              progressBarValue: progressBarValue,
              progressBarWidget: progressBarWidget,
            ),
          ),
          const SizedBox(width: 8),
          ToastCloseButton(
            styleParameters: styleParameters,
            onCloseTap: onCloseTap,
          ),
        ],
      ),
    );

    if (context.toastTheme.applyBlurEffect) {
      body = ClipRRect(
        borderRadius: context.toastTheme.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
