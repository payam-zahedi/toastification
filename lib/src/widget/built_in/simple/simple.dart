import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/close_button.dart';
import 'package:toastification/toastification.dart';

class SimpleToastWidget extends StatefulWidget {
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

  final bool? showCloseButton;
  final VoidCallback? onCloseTap;

  SimpleStyle get defaultStyle => SimpleStyle(type);

  @override
  _SimpleToastWidgetState createState() => _SimpleToastWidgetState();
}

class _SimpleToastWidgetState extends State<SimpleToastWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final background =
        widget.backgroundColor ?? widget.defaultStyle.backgroundColor(context);
    final showCloseButton = widget.showCloseButton ?? true;
    final borderRadius =
        widget.borderRadius ?? widget.defaultStyle.borderRadius(context);
    final borderSide =
        widget.borderSide ?? widget.defaultStyle.borderSide(context);
    final direction = widget.direction ?? Directionality.of(context);

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
            applyBlurEffect: widget.applyBlurEffect,
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

    if (showCloseButton) {
      body = Row(
        children: [
          Expanded(
            child: widget.title ?? const SizedBox(),
          ),
          ToastCloseButton(
            showCloseButton: showCloseButton,
            onCloseTap: widget.onCloseTap,
            icon: widget.defaultStyle.closeIcon(context),
            iconColor: widget.foregroundColor?.withOpacity(.3) ??
                widget.defaultStyle.closeIconColor(context),
          ),
        ],
      );
    } else {
      body = widget.title ?? const SizedBox();
    }

    body = Container(
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        border: Border.fromBorderSide(borderSide),
        boxShadow: widget.boxShadow ?? widget.defaultStyle.boxShadow(context),
        borderRadius: borderRadius,
      ),
      padding: widget.padding ?? widget.defaultStyle.padding(context),
      child: body,
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: widget.defaultStyle.borderRadius(context),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
