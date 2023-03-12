import 'package:flutter/material.dart';
import 'package:toastification/src/core/toastification_item.dart';
import 'package:toastification/src/core/toastification.dart';
import 'package:toastification/src/widget/toast_animation.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    super.key,
    required this.item,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 4.0,
    this.onCloseTap,
    this.showProgressBar = true,
    this.showCloseButton = true,
    this.closeOnClick = false,
    this.pauseOnHover = true,
  });

  final ToastificationItem item;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness brightness;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry? borderRadius;

  final double elevation;

  final VoidCallback? onCloseTap;

  final bool showProgressBar;

  final bool showCloseButton;

  final bool closeOnClick;

  final bool pauseOnHover;

  @override
  Widget build(BuildContext context) {
    final defaultTheme =
        brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();

    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;
    final background = backgroundColor ?? const Color(0xff1976d2);

    final hasTimeout = item.hasTimer;

    Widget toast = IconTheme(
      data: defaultTheme.primaryIconTheme,
      child: Padding(
        padding: margin,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Material(
                color: background,
                elevation: elevation,
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      icon ??
                          const Icon(
                            Icons.info,
                            size: 28,
                          ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildContent(defaultTheme),
                      ),
                      const SizedBox(width: 16),
                      Offstage(
                        offstage: !showCloseButton,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          splashRadius: 24,
                          color: foreground,
                          tooltip: MaterialLocalizations.of(context)
                              .closeButtonTooltip,
                          onPressed: onCloseTap ??
                              () {
                                Toastification().dismiss(item);
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showProgressBar && hasTimeout)
                ToastTimerAnimationBuilder(
                  item: item,
                  builder: (context, value, child) {
                    return Directionality(
                      textDirection:
                          Directionality.of(context) == TextDirection.ltr
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: foreground?.withOpacity(.8),
                        color: background,
                        minHeight: 6,
                      ),
                    );
                  },
                )
            ],
          ),
        ),
      ),
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
        onTap: () {
          toastification.dismiss(item);
        },
        child: toast,
      );
    }

    return toast;
  }

  Widget _buildContent(ThemeData defaultTheme) {
    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;

    Widget content = Text(
      title,
      style: defaultTheme.textTheme.headline1?.copyWith(
        color: foreground,
        fontSize: 18,
      ),
    );

    if (description?.isNotEmpty ?? false) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          const SizedBox(height: 4),
          Text(
            description!,
            style: defaultTheme.textTheme.headline1?.copyWith(
              color: foreground,
              fontSize: 14,
            ),
          )
        ],
      );
    }

    return content;
  }
}

class InfoToastWidget extends StatelessWidget {
  const InfoToastWidget({
    super.key,
    required this.item,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 4.0,
    this.onCloseTap,
    this.showProgressBar = true,
    this.showCloseButton = true,
    this.closeOnClick = false,
    this.pauseOnHover = true,
  });

  final ToastificationItem item;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness brightness;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry? borderRadius;

  final double elevation;

  final VoidCallback? onCloseTap;

  final bool showProgressBar;

  final bool showCloseButton;

  final bool closeOnClick;

  final bool pauseOnHover;

  @override
  Widget build(BuildContext context) {
    return ToastWidget(
      item: item,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? Colors.blue,
      foregroundColor: foregroundColor,
      icon: icon,
      brightness: brightness,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      elevation: elevation,
      onCloseTap: onCloseTap,
      showProgressBar: showProgressBar,
      showCloseButton: showCloseButton,
      closeOnClick: closeOnClick,
      pauseOnHover: pauseOnHover,
    );
  }
}

class WarningToastWidget extends StatelessWidget {
  const WarningToastWidget({
    super.key,
    required this.item,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 3.0,
    this.onCloseTap,
    this.showProgressBar = true,
    this.showCloseButton = true,
    this.closeOnClick = false,
    this.pauseOnHover = true,
  });

  final ToastificationItem item;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness brightness;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry? borderRadius;

  final double elevation;

  final VoidCallback? onCloseTap;

  final bool showProgressBar;

  final bool showCloseButton;

  final bool closeOnClick;

  final bool pauseOnHover;

  @override
  Widget build(BuildContext context) {
    return ToastWidget(
      item: item,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? const Color(0xffffc107),
      foregroundColor: foregroundColor,
      icon: icon,
      brightness: brightness,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      elevation: elevation,
      onCloseTap: onCloseTap,
      showProgressBar: showProgressBar,
      showCloseButton: showCloseButton,
      closeOnClick: closeOnClick,
      pauseOnHover: pauseOnHover,
    );
  }
}

class SuccessToastWidget extends StatelessWidget {
  const SuccessToastWidget({
    super.key,
    required this.item,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 4.0,
    this.onCloseTap,
    this.showProgressBar = true,
    this.showCloseButton = true,
    this.closeOnClick = false,
    this.pauseOnHover = true,
  });

  final ToastificationItem item;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness brightness;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry? borderRadius;

  final double elevation;

  final VoidCallback? onCloseTap;

  final bool showProgressBar;

  final bool showCloseButton;

  final bool closeOnClick;

  final bool pauseOnHover;

  @override
  Widget build(BuildContext context) {
    return ToastWidget(
      item: item,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? Colors.green,
      foregroundColor: foregroundColor,
      icon: icon ??
          const Icon(
            Icons.check,
            size: 28,
          ),
      brightness: brightness,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      elevation: elevation,
      onCloseTap: onCloseTap,
      showProgressBar: showProgressBar,
      showCloseButton: showCloseButton,
      closeOnClick: closeOnClick,
      pauseOnHover: pauseOnHover,
    );
  }
}

class ErrorToastWidget extends StatelessWidget {
  const ErrorToastWidget({
    super.key,
    required this.item,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 4.0,
    this.onCloseTap,
    this.showProgressBar = true,
    this.showCloseButton = true,
    this.closeOnClick = false,
    this.pauseOnHover = true,
  });

  final ToastificationItem item;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness brightness;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final BorderRadiusGeometry? borderRadius;

  final double elevation;

  final VoidCallback? onCloseTap;

  final bool showProgressBar;

  final bool showCloseButton;

  final bool closeOnClick;

  final bool pauseOnHover;

  @override
  Widget build(BuildContext context) {
    return ToastWidget(
      item: item,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? Colors.red,
      foregroundColor: foregroundColor,
      icon: icon ??
          const Icon(
            Icons.warning_rounded,
            size: 28,
          ),
      brightness: brightness,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      elevation: elevation,
      onCloseTap: onCloseTap,
      showProgressBar: showProgressBar,
      showCloseButton: showCloseButton,
      closeOnClick: closeOnClick,
      pauseOnHover: pauseOnHover,
    );
  }
}
