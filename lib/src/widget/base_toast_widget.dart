import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract class BaseToastWidget extends StatelessWidget {
  const BaseToastWidget({
    super.key,
    required this.type,
    this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.showIcon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.onCloseTap,
    this.showCloseButton,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
    this.applyBlurEffect = false,
  });

  final ToastificationType type;
  final Widget? title;
  final Widget? description;
  final Widget? icon;
  final bool? showIcon;
  final MaterialColor? primaryColor;
  final MaterialColor? backgroundColor;
  final Color? foregroundColor;
  final Brightness? brightness;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? borderSide;
  final List<BoxShadow>? boxShadow;
  final TextDirection? direction;
  final VoidCallback? onCloseTap;
  final bool? showCloseButton;
  final bool showProgressBar;
  final bool applyBlurEffect;
  final double? progressBarValue;
  final Widget? progressBarWidget;
  final ProgressIndicatorThemeData? progressIndicatorTheme;
  BuiltInStyle get defaultStyle;

  @override
  Widget build(BuildContext context) {
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);
    final showCloseButtonResolved = showCloseButton ?? true;
    final borderRadiusResolved =
        borderRadius ?? defaultStyle.borderRadius(context);
    final borderSideResolved =
        borderSide ?? defaultStyle.borderSide(context);
    final directionResolved = direction ?? Directionality.of(context);

    return Directionality(
      textDirection: directionResolved,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme.copyWith(color: iconColor),
        child: buildBody(
          context: context,
          background: background,
          borderRadius: borderRadiusResolved,
          borderSide: borderSideResolved,
          iconColor: iconColor,
          showCloseButton: showCloseButtonResolved,
          applyBlurEffect: applyBlurEffect,
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
  });
}
