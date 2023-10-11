import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/on_hover_builder.dart';
import 'package:toastification/toastification.dart';

class BuiltInBuilder extends StatelessWidget {
  const BuiltInBuilder({
    super.key,
    required this.item,
    this.type,
    this.style,
    this.direction,
    required this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.onCloseTap,
    this.showProgressBar,
    this.progressBarTheme,
    this.closeButtonShowType,
    this.closeOnClick,
    this.dragToClose,
    this.pauseOnHover,
    required this.showCloseButton,
    this.loaderBackgroundColor,
    this.loaderColor,
    required this.closeIcon,
  });

  final ToastificationItem item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? loaderBackgroundColor;
  final Color? loaderColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback? onCloseTap;

  final bool? showProgressBar;

  final ProgressIndicatorThemeData? progressBarTheme;

  final CloseButtonShowType? closeButtonShowType;

  final bool? closeOnClick;

  final bool? dragToClose;

  final bool? pauseOnHover;
  final bool showCloseButton;

  final IconData closeIcon;

  @override
  Widget build(BuildContext context) {
    final showProgressBar = (this.showProgressBar ?? true);

    final closeOnClick = this.closeOnClick ?? false;
    final pauseOnHover = this.pauseOnHover ?? true;
    final dragToClose = this.dragToClose ?? true;

    final defaultStyle = toastDefaultStyle();

    final foreground = foregroundColor ?? defaultStyle.foregroundColor(context);
    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    return BuiltInContainer(
      item: item,
      background: background,
      foreground: foreground,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: borderRadius ?? defaultStyle.borderRadius(context),
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      pauseOnHover: pauseOnHover,
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
        brightness: brightness,
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        onCloseTap: buildOnCloseTap(),
        showProgressBar: showProgressBar,
        progressBarTheme: progressBarTheme,
        closeButtonShowType: closeButtonShowType,
        closeIcon: closeIcon,
        showCloseButton: showCloseButton,
        loaderBackgroundColor: loaderBackgroundColor,
        loaderColor: loaderColor,
      ),
    );
  }

  BuiltInStyle toastDefaultStyle() {
    final type = this.type ?? ToastificationType.info;

    final style = this.style ?? ToastificationStyle.fillColored;

    return switch (style) {
      ToastificationStyle.minimal => MinimalStyle(type),
      ToastificationStyle.fillColored => FilledStyle(type),
      ToastificationStyle.flatColored => FlatColoredStyle(type),
      ToastificationStyle.flat => FlatStyle(type),
    };
  }

  VoidCallback buildOnCloseTap() {
    return onCloseTap ??
        () {
          Toastification().dismiss(item);
        };
  }
}

class BuiltInToastBuilder extends StatelessWidget {
  const BuiltInToastBuilder({
    super.key,
    this.item,
    required this.type,
    required this.style,
    required this.direction,
    required this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    required this.onCloseTap,
    this.showProgressBar,
    this.progressBarTheme,
    this.closeButtonShowType,
    required this.showCloseButton,
    required this.closeIcon,
    this.loaderBackgroundColor,
    this.loaderColor,
  });

  final ToastificationItem? item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? loaderBackgroundColor;
  final Color? loaderColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback onCloseTap;

  final bool? showProgressBar;
  final bool showCloseButton;

  final ProgressIndicatorThemeData? progressBarTheme;

  final CloseButtonShowType? closeButtonShowType;

  final IconData closeIcon;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? ToastificationStyle.flat;

    final type = this.type ?? ToastificationType.info;

    final closeButtonType = closeButtonShowType ?? CloseButtonShowType.always;

    final primaryColor = buildMaterialColor(this.primaryColor);
    final backgroundColor = buildMaterialColor(this.backgroundColor);

    final showProgressBar = (this.showProgressBar ?? false) && item != null;

    final progressBarWidget = showProgressBar
        ? ToastTimerAnimationBuilder(
            item: item!,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                color: loaderColor ?? Colors.grey,
                backgroundColor: loaderBackgroundColor ?? Colors.white,
                minHeight: 5,
              );
            },
          )
        : null;

    return OnHoverShow(
      enabled: closeButtonType == CloseButtonShowType.onHover,
      childBuilder: (context, showWidget) {
        // final showCloseButton =
        //     (closeButtonType != CloseButtonShowType.none) && showWidget;

        return switch (style) {
          ToastificationStyle.flat => FlatToastWidget(
              type: type,
              item: item,
              title: title,
              description: description,
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              icon: icon,
              brightness: brightness,
              padding: padding,
              borderRadius: borderRadius,
              boxShadow: boxShadow,
              direction: direction,
              onCloseTap: onCloseTap,
              showCloseButton: showCloseButton,
              showProgressBar: this.showProgressBar == true,
              progressIndicatorTheme: progressBarTheme,
              progressBarWidget: progressBarWidget,
              closeIcon: closeIcon,
            ),
          ToastificationStyle.flatColored => FlatColoredToastWidget(
              type: type,
              title: title,
              item: item,
              description: description,
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              icon: icon,
              brightness: brightness,
              padding: padding,
              borderRadius: borderRadius,
              boxShadow: boxShadow,
              direction: direction,
              onCloseTap: onCloseTap,
              showCloseButton: showCloseButton,
              showProgressBar: this.showProgressBar == true,
              progressIndicatorTheme: progressBarTheme,
              progressBarWidget: progressBarWidget,
              closeIcon: closeIcon,
            ),
          ToastificationStyle.fillColored => FilledToastWidget(
              type: type,
              title: title,
              item: item,
              description: description,
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              icon: icon,
              brightness: brightness,
              padding: padding,
              borderRadius: borderRadius,
              boxShadow: boxShadow,
              direction: direction,
              onCloseTap: onCloseTap,
              showCloseButton: showCloseButton,
              showProgressBar: this.showProgressBar == true,
              progressIndicatorTheme: progressBarTheme,
              progressBarWidget: progressBarWidget,
              closeIcon: closeIcon,
            ),
          ToastificationStyle.minimal => MinimalToastWidget(
              type: type,
              title: title,
              item: item,
              description: description,
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              icon: icon,
              brightness: brightness,
              padding: padding,
              borderRadius: borderRadius,
              boxShadow: boxShadow,
              direction: direction,
              onCloseTap: onCloseTap,
              showCloseButton: showCloseButton,
              showProgressBar: this.showProgressBar == true,
              progressIndicatorTheme: progressBarTheme,
              progressBarWidget: progressBarWidget,
              closeIcon: closeIcon,
            ),
        };
      },
    );
  }

  MaterialColor? buildMaterialColor(Color? color) {
    if (color == null) return null;

    if (color is MaterialColor) return color;

    final findInMaterialColors = Colors.primaries
        .firstWhereOrNull((element) => element.shade500 == color);

    return findInMaterialColors ?? ToastHelper.createMaterialColor(color);
  }
}

/// This widget help you to use the default behavior of the built-in
/// toastification Items
class BuiltInContainer extends StatelessWidget {
  const BuiltInContainer({
    super.key,
    required this.item,
    this.background,
    this.foreground,
    required this.margin,
    required this.borderRadius,
    required this.showProgressBar,
    required this.closeOnClick,
    required this.pauseOnHover,
    required this.dragToClose,
    required this.child,
  });

  final ToastificationItem item;

  final Widget child;

  final Color? background;
  final Color? foreground;

  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry borderRadius;

  final bool showProgressBar;

  final bool closeOnClick;

  final bool dragToClose;

  final bool pauseOnHover;
  @override
  Widget build(BuildContext context) {
    final hasTimeout = item.hasTimer;

    Widget toast = Padding(
      padding: margin,
      child: child,
    );

    if (pauseOnHover && hasTimeout) {
      toast = MouseRegion(
        onEnter: (event) {
          item.pause();
        },
        onExit: (event) {
          item.start();
        },
        child: toast,
      );
    }

    if (closeOnClick) {
      toast = GestureDetector(
        onTap: closeOnClick
            ? () {
                toastification.dismiss(item);
              }
            : null,
        child: toast,
      );
    }

    if (dragToClose) {
      toast = _FadeDismissible(
        item: item,
        pauseOnHover: pauseOnHover,
        child: toast,
      );
    }

    return toast;
  }
}

class _FadeDismissible extends StatefulWidget {
  const _FadeDismissible({
    required this.item,
    required this.pauseOnHover,
    required this.child,
  });

  final ToastificationItem item;
  final bool pauseOnHover;
  final Widget child;

  @override
  State<_FadeDismissible> createState() => _FadeDismissibleState();
}

class _FadeDismissibleState extends State<_FadeDismissible> {
  double currentOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _handleDragUpdate(true, event.kind);
      },
      onPointerUp: (event) {
        _handleDragUpdate(false, event.kind);
      },
      child: Dismissible(
        key: ValueKey('dismiss-${widget.item.id}'),
        onUpdate: (details) {
          setState(() {
            currentOpacity = details.progress;
          });
        },
        behavior: HitTestBehavior.deferToChild,
        onDismissed: (direction) {
          toastification.dismiss(widget.item, showRemoveAnimation: false);
        },
        child: Opacity(
          opacity: 1 - currentOpacity,
          child: widget.child,
        ),
      ),
    );
  }

  void _handleDragUpdate(bool startDrag, PointerDeviceKind pointerKind) {
    if (widget.pauseOnHover && pointerKind == PointerDeviceKind.mouse) return;

    if (widget.item.hasTimer && startDrag) {
      widget.item.pause();
    } else {
      widget.item.start();
    }
  }
}
