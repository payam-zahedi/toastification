import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/toast_model.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';

class FlatColoredToastWidget extends StatelessWidget {
  const FlatColoredToastWidget({
    super.key,
    required this.toastModel,
  });

  final ToastModel toastModel;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: toastModel.direction ?? Directionality.of(context),
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: toastModel.iconColor(context)),
        child: buildBody(
          context: context,
          background: toastModel.background(context),
          borderRadius: toastModel.borderRadius ??
              toastModel.defaultStyle.borderRadius(context),
          borderSide: toastModel.borderSide ??
              toastModel.defaultStyle
                  .borderSide(context)
                  .copyWith(color: toastModel.primaryColor),
          iconColor: toastModel.iconColor(context),
          showCloseButton: toastModel.showCloseButton ?? true,
          applyBlurEffect: toastModel.applyBlurEffect,
        ),
      ),
    );
  }

  Widget buildBody({
    required BuildContext context,
    required Color background,
    required BorderRadiusGeometry borderRadius,
    required BorderSide borderSide,
    required Color iconColor,
    required bool showCloseButton,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        borderRadius: borderRadius,
        border: Border.fromBorderSide(borderSide),
        boxShadow:
            toastModel.boxShadow ?? toastModel.defaultStyle.boxShadow(context),
      ),
      padding: toastModel.padding ?? toastModel.defaultStyle.padding(context),
      child: Row(
        children: [
          Offstage(
            offstage: !(toastModel.showIcon ?? true),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: toastModel.icon ??
                  Icon(
                    toastModel.defaultStyle.icon(context),
                    size: 24,
                    color: iconColor,
                  ),
            ),
          ),
          Expanded(
            child: BuiltInContent(
              contentModel: toastModel.getBuildInContentModel(),
            ),
          ),
          const SizedBox(width: 8),
          ToastCloseButton(
            showCloseButton: toastModel.showCloseButton ?? true,
            onCloseTap: toastModel.onCloseTap,
            icon: toastModel.defaultStyle.closeIcon(context),
            iconColor: toastModel.foregroundColor?.withOpacity(.3) ??
                toastModel.defaultStyle.closeIconColor(context),
          ),
        ],
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
