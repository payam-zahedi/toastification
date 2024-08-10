import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/core/toast_model.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';

import 'minimal_style.dart';

class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
    super.key,
    required this.toastModel,
  });

  final ToastModel toastModel;
  MinimalStyle get defaultStyle => MinimalStyle(toastModel.type);

  @override
  Widget build(BuildContext context) {
    final direction = toastModel.direction ?? Directionality.of(context);
    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: toastModel.iconColor(context)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Material(
            color: Colors.transparent,
            shape: LinearBorder.start(
              side: BorderSide(
                color: toastModel.primaryColor ??
                    defaultStyle.primaryColor(context),
                width: 3,
              ),
            ),
            child: buildBody(
              context: context,
              background: toastModel.background(context),
              borderRadius: (toastModel.borderRadius ??
                      defaultStyle.borderRadius(context))
                  .resolve(direction),
              borderSide:
                  toastModel.borderSide ?? defaultStyle.borderSide(context),
              iconColor: toastModel.iconColor(context),
              showCloseButton: toastModel.showCloseButton ?? true,
              applyBlurEffect: toastModel.applyBlurEffect,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody({
    required BuildContext context,
    required Color background,
    required BorderRadius borderRadius,
    required BorderSide borderSide,
    required Color iconColor,
    required bool showCloseButton,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
        border: Border.fromBorderSide(borderSide),
        boxShadow: toastModel.boxShadow ?? defaultStyle.boxShadow(context),
      ),
      padding: toastModel.padding ?? defaultStyle.padding(context),
      child: Row(
        children: [
          Offstage(
            offstage: !(toastModel.showIcon ?? true),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: toastModel.icon ??
                  Icon(
                    defaultStyle.icon(context),
                    size: 24,
                    color: iconColor,
                  ),
            ),
          ),
          Expanded(
            child: BuiltInContent(
                contentModel:
                    toastModel.getBuildInContentModel(style: defaultStyle)),
          ),
          const SizedBox(width: 8),
          ToastCloseButton(
            showCloseButton: showCloseButton,
            onCloseTap: toastModel.onCloseTap,
            icon: defaultStyle.closeIcon(context),
            iconColor: toastModel.foregroundColor?.withOpacity(.3) ??
                defaultStyle.closeIconColor(context),
          ),
        ],
      ),
    );

    if (applyBlurEffect) {
      body = body = ClipRRect(
        borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
