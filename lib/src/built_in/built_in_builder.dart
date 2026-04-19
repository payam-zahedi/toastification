import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/widget/common/on_hover_builder.dart';
import 'package:toastification/toastification.dart';

const _defaultShowProgressBar = false;

class BuiltInBuilder extends StatelessWidget {
  const BuiltInBuilder({
    super.key,
    required this.item,
    this.type,
    this.style,
    this.direction,
    this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.showProgressBar,
    this.applyBlurEffect,
    this.progressBarTheme,
    required this.closeButton,
    this.closeOnClick,
    this.dragToClose,
    this.dismissDirection,
    this.pauseOnHover,
    this.showIcon,
    this.callbacks = const ToastificationCallbacks(),
    this.onHoverMouseCursor,
    this.constraints,
  });

  final ToastificationItem item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final bool? showProgressBar;

  final bool? applyBlurEffect;

  final bool? showIcon;

  final ProgressIndicatorThemeData? progressBarTheme;

  final ToastCloseButton closeButton;

  final bool? closeOnClick;

  final bool? dragToClose;

  final DismissDirection? dismissDirection;

  final bool? pauseOnHover;

  final ToastificationCallbacks callbacks;

  /// The mouse cursor to display when hovering over the toast.
  ///
  /// Use [SystemMouseCursors.click] to indicate the toast is tappable.
  /// If null, the default cursor is used.
  final MouseCursor? onHoverMouseCursor;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final showProgressBar = (this.showProgressBar ?? _defaultShowProgressBar);

    final closeOnClick = this.closeOnClick ?? false;
    final pauseOnHover = this.pauseOnHover ?? true;
    final dragToClose = this.dragToClose ?? true;

    final primaryColor = ColorUtils.convertToMaterialColor(this.primaryColor);
    final backgroundColor =
        ColorUtils.convertToMaterialColor(this.backgroundColor);

    return BuiltInContainer(
      item: item,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      dismissDirection: dismissDirection,
      pauseOnHover: pauseOnHover,
      callbacks: callbacks,
      onHoverMouseCursor: onHoverMouseCursor,
      child: BuiltInToastBuilder(
        item: item,
        type: type,
        style: style,
        direction: direction,
        title: title,
        description: description,
        primaryColor: primaryColor,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        icon: icon,
        showIcon: showIcon,
        brightness: brightness,
        padding: padding,
        borderRadius: borderRadius,
        borderSide: borderSide,
        boxShadow: boxShadow,
        onCloseTap: _onCloseButtonTap(),
        showProgressBar: showProgressBar,
        applyBlurEffect: applyBlurEffect,
        progressBarTheme: progressBarTheme,
        closeButton: closeButton,
        constraints: constraints,
      ),
    );
  }

  VoidCallback _onCloseButtonTap() {
    return () {
      callbacks.onCloseButtonTap != null
          ? callbacks.onCloseButtonTap?.call(item)
          : _defaultCloseButtonTap();
    };
  }

  void _defaultCloseButtonTap() {
    Toastification().dismiss(item);
  }
}

class BuiltInToastBuilder extends StatelessWidget {
  const BuiltInToastBuilder({
    super.key,
    this.item,
    required this.type,
    required this.style,
    required this.direction,
    this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.showIcon,
    required this.onCloseTap,
    required this.showProgressBar,
    this.applyBlurEffect,
    this.progressBarTheme,
    required this.closeButton,
    this.constraints,
  });

  final ToastificationItem? item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback onCloseTap;

  final bool showProgressBar;

  final bool? showIcon;

  final bool? applyBlurEffect;

  final ProgressIndicatorThemeData? progressBarTheme;

  final ToastCloseButton closeButton;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final flutterTheme = Theme.of(context);

    // TODO: in v4.0 we need to update ToastificationStyle property
    final effectiveStyle = (style ?? ToastificationStyle.flat).toStandard;

    final effectiveType = type ?? ToastificationType.success;

    final progressBarWidget = showProgressBar && item != null
        ? ToastTimerAnimationBuilder(
            item: item!,
            builder: (context, value, _) {
              return LinearProgressIndicator(value: value);
            },
          )
        : null;

    // TODO: Maybe we can use Abstract factory to have toast style and toast widget
    final toastificationThemeData = ToastificationThemeData(
      toastStyle: StandardToastStyleFactory.createStyle(
        style: effectiveStyle,
        type: effectiveType,
        providedValues: StandardStyleValues(
          primaryColor: primaryColor?.toMaterialColor,
          surfaceLight: backgroundColor,
          surfaceDark: foregroundColor,
          padding: padding,
          borderRadius: borderRadius,
          borderSide: borderSide,
          boxShadow: boxShadow,
          progressIndicatorStrokeWidth: progressBarTheme?.linearMinHeight,
          progressIndicatorTheme: progressBarTheme,
          constraints: constraints,
        ),
        flutterTheme: flutterTheme,
      ),
      flutterTheme: flutterTheme,
      direction: direction ?? Directionality.of(context),
      showProgressBar: showProgressBar,
      applyBlurEffect: applyBlurEffect ?? false,
      showIcon: showIcon ?? true,
    );

    return ToastificationTheme(
      themeData: toastificationThemeData,
      child: OnHoverShow(
        enabled: closeButton.showType == CloseButtonShowType.onHover,
        childBuilder: (context, showWidget) {
          final showCloseWidget = switch (closeButton.showType) {
            CloseButtonShowType.none => false,
            _ => showWidget,
          };

          return StandardToastWidgetFactory.createStandardToastWidget(
            style: effectiveStyle,
            title: title,
            description: description,
            icon: icon,
            showCloseButton: showCloseWidget,
            onCloseTap: onCloseTap,
            closeButton: closeButton,
            progressBarWidget: progressBarWidget,
          );
        },
      ),
    );
  }
}
