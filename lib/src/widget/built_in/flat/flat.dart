import 'dart:ui';

import 'package:flutter/material.dart';
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
    required this.styleParameters,
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
      textDirection: styleParameters.direction,
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: styleParameters.iconColor),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: styleParameters.decorationColor,
        borderRadius: styleParameters.borderRadius,
        border: styleParameters.decorationBorder,
        boxShadow: styleParameters.boxShadow,
      ),
      padding: styleParameters.padding,
      child: Row(
        children: [
          Offstage(
            offstage: !styleParameters.showIcon,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: icon ??
                  Icon(
                    styleParameters.icon,
                    size: 24,
                    color: styleParameters.iconColor,
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
