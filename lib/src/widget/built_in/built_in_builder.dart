import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/src/widget/built_in/widget/on_hover_builder.dart';
import 'package:toastification/toastification.dart';

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
    this.closeButtonShowType,
    this.closeOnClick,
    this.dragToClose,
    this.dismissDirection,
    this.pauseOnHover,
    this.showIcon,
    this.actionButtons,
    this.callbacks = const ToastificationCallbacks(),
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

  final CloseButtonShowType? closeButtonShowType;

  final bool? closeOnClick;

  final bool? dragToClose;

  final DismissDirection? dismissDirection;

  final bool? pauseOnHover;

  final ToastificationCallbacks callbacks;  

  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    final showProgressBar = (this.showProgressBar ?? true);

    final closeOnClick = this.closeOnClick ?? false;
    final pauseOnHover = this.pauseOnHover ?? true;
    final dragToClose = this.dragToClose ?? true;

    final closeButtonShowType =
        this.closeButtonShowType ?? CloseButtonShowType.always;

    final primaryColor = ToastHelper.convertToMaterialColor(this.primaryColor);
    final backgroundColor =
        ToastHelper.convertToMaterialColor(this.backgroundColor);

    return _BuiltInContainer(
      item: item,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      dismissDirection: dismissDirection,
      pauseOnHover: pauseOnHover,
      callbacks: callbacks,
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
        closeButtonShowType: closeButtonShowType,
        actionButtons: actionButtons,
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
    this.showProgressBar,
    this.applyBlurEffect,
    this.progressBarTheme,
    this.closeButtonShowType,
    this.actionButtons
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

  final bool? showProgressBar;

  final bool? showIcon;

  final bool? applyBlurEffect;

  final ProgressIndicatorThemeData? progressBarTheme;

  final CloseButtonShowType? closeButtonShowType;

  final List<Widget>? actionButtons;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? ToastificationStyle.flat;

    final showProgressBar = (this.showProgressBar ?? false) && item != null;

    final progressBarWidget = showProgressBar
        ? ToastTimerAnimationBuilder(
            item: item!,
            builder: (context, value, _) {
              return LinearProgressIndicator(value: value);
            },
          )
        : null;

    return ToastificationThemeProvider(
      selectedStyle: StyleFactory.createStyle(
        style,
        type ?? ToastificationType.success,
        Theme.of(context),
      ),
      themeBuilder: (theme) {
        return theme.copyWith(
          backgroundColor: backgroundColor != null
              ? ToastHelper.createMaterialColor(backgroundColor!)
              : null,
          primaryColor: primaryColor != null
              ? ToastHelper.createMaterialColor(primaryColor!)
              : null,
          foregroundColor: foregroundColor != null
              ? ToastHelper.createMaterialColor(foregroundColor!)
              : null,
          padding: padding ?? theme.padding,
          borderRadius: borderRadius ?? theme.borderRadius,
          borderSide: borderSide ?? theme.borderSide,
          boxShadow: boxShadow ?? theme.boxShadow,
          direction: direction ?? Directionality.of(context),
          showProgressBar: this.showProgressBar == true,
          applyBlurEffect: applyBlurEffect ?? false,
          showIcon: showIcon ?? true,
          progressIndicatorTheme:
              progressBarTheme ?? theme.progressIndicatorTheme,
        );
      },
      textDirection: direction ?? Directionality.of(context),
      child: OnHoverShow(
        enabled: closeButtonShowType == CloseButtonShowType.onHover,
        childBuilder: (context, showWidget) {
          final showCloseWidget = switch (closeButtonShowType) {
            CloseButtonShowType.none => false,
            _ => showWidget,
          };

          return switch (style) {
            ToastificationStyle.flat => FlatToastWidget(
                title: title,
                description: description,
                icon: icon,
                showCloseButton: showCloseWidget,
                onCloseTap: onCloseTap,
                progressBarWidget: progressBarWidget,
                actionButtons: actionButtons,
              ),
            ToastificationStyle.flatColored => FlatColoredToastWidget(
                title: title,
                description: description,
                icon: icon,
                showCloseButton: showCloseWidget,
                onCloseTap: onCloseTap,
                progressBarWidget: progressBarWidget,       
                actionButtons: actionButtons,         
              ),
            ToastificationStyle.fillColored => FilledToastWidget(
                title: title,
                description: description,
                icon: icon,
                onCloseTap: onCloseTap,
                showCloseButton: showCloseWidget,
                progressBarWidget: progressBarWidget,
                actionButtons: actionButtons,
              ),
            ToastificationStyle.minimal => MinimalToastWidget(
                title: title,
                description: description,
                icon: icon,
                showCloseButton: showCloseWidget,
                onCloseTap: onCloseTap,
                progressBarWidget: progressBarWidget,
                actionButtons: actionButtons,
              ),
            ToastificationStyle.simple => SimpleToastWidget(
                title: title,
                showCloseButton: showCloseWidget,
                onCloseTap: onCloseTap,                
              ),
          };
        },
      ),
    );
  }
}

/// This widget help you to use the default behavior of the built-in
/// toastification Items
class _BuiltInContainer extends StatelessWidget {
  const _BuiltInContainer({
    required this.item,
    required this.margin,
    required this.showProgressBar,
    required this.closeOnClick,
    required this.pauseOnHover,
    required this.dragToClose,
    this.dismissDirection,
    required this.callbacks,
    required this.child,
  });

  final ToastificationItem item;

  final EdgeInsetsGeometry margin;

  final bool showProgressBar;

  final bool closeOnClick;

  final bool dragToClose;

  final DismissDirection? dismissDirection;

  final bool pauseOnHover;

  final ToastificationCallbacks callbacks;

  final Widget child;

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

    toast = GestureDetector(
      onTap: () {
        // if close on click is enabled dismiss the toast
        if (closeOnClick) toastification.dismiss(item);

        // call the onTap callback
        callbacks.onTap?.call(item);
      },
      child: toast,
    );

    if (dragToClose) {
      toast = _FadeDismissible(
        item: item,
        pauseOnHover: pauseOnHover,
        dismissDirection: dismissDirection,
        onDismissed: callbacks.onDismissed == null
            ? null
            : () {
                callbacks.onDismissed?.call(item);
              },
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
    this.onDismissed,
    this.dismissDirection,
    required this.child,
  });

  final ToastificationItem item;
  final bool pauseOnHover;
  final VoidCallback? onDismissed;
  final DismissDirection? dismissDirection;
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
        direction: widget.dismissDirection ?? DismissDirection.horizontal,
        behavior: HitTestBehavior.deferToChild,
        onDismissed: (direction) {
          // call the onDismissed callback
          widget.onDismissed?.call();

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
