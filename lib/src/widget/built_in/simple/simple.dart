import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatelessWidget {
  const SimpleToastWidget({
    super.key,
    required this.type,
    this.title,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.applyBlurEffect = false,
    this.showCloseButton = true,
    this.onCloseTap,
  });

  final ToastificationType type;

  final Widget? title;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final bool applyBlurEffect;

  final bool showCloseButton;
  final VoidCallback? onCloseTap;

  SimpleStyle get defaultStyle => SimpleStyle(type);

  @override
  Widget build(BuildContext context) {
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);
    final direction = this.direction ?? Directionality.of(context);
    final borderRadius =
        (this.borderRadius ?? defaultStyle.borderRadius(context))
            .resolve(direction);
    final borderSide = this.borderSide ?? defaultStyle.borderSide(context);

    return Directionality(
      textDirection: direction,
      child: Center(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: buildContent(
            context: context,
            background: background,
            borderSide: borderSide,
            borderRadius: borderRadius,
            applyBlurEffect: applyBlurEffect,
            showCloseButton: showCloseButton,
          ),
        ),
      ),
    );
  }

  Widget buildContent({
    required BuildContext context,
    required Color background,
    required BorderSide borderSide,
    required BorderRadiusGeometry borderRadius,
    required bool applyBlurEffect,
    required bool showCloseButton,
  }) {
    Widget body;

    body = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: title ?? const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: ToastCloseButton(
            showCloseButton: showCloseButton,
            onCloseTap: onCloseTap,
            icon: defaultStyle.closeIcon(context),
            iconColor: foregroundColor?.withOpacity(.3) ??
                defaultStyle.closeIconColor(context),
          ),
        ),
      ],
    );

    body = Container(
      constraints: const BoxConstraints(
        minHeight: 65.0,
      ),
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        border: Border.fromBorderSide(borderSide),
        boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
        borderRadius: borderRadius,
      ),
      padding: padding ?? defaultStyle.padding(context),
      child: body,
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: defaultStyle.borderRadius(context),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
