import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class BuiltInWidgetBuilder extends StatelessWidget {
  const BuiltInWidgetBuilder({
    super.key,
    required this.item,
    this.type,
    this.style,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.onCloseTap,
    this.showProgressBar,
    this.showCloseButton,
    this.closeOnClick,
    this.pauseOnHover,
  });

  final ToastificationItem item;

  final ToastificationType? type;

  final ToastificationStyle? style;

  final String title;
  final String? description;

  final Widget? icon;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final BorderRadiusGeometry? borderRadius;

  final double? elevation;

  final VoidCallback? onCloseTap;

  final bool? showProgressBar;

  final bool? showCloseButton;

  final bool? closeOnClick;

  final bool? pauseOnHover;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = (brightness ?? Brightness.light) == Brightness.light
        ? ThemeData.light()
        : ThemeData.dark();

    final style = this.style ?? ToastificationStyle.fillColored;

    final showProgressBar = (this.showProgressBar ?? true) &&
        style == ToastificationStyle.fillColored;

    final closeOnClick = this.closeOnClick ?? false;
    final pauseOnHover = this.pauseOnHover ?? true;

    final hasTimeout = item.hasTimer;

    var toastContent = buildToast(context);

    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;
    final background = toastContent.buildColor(context);

    Widget toast = Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ClipRRect(
        borderRadius: borderRadius ?? toastContent.buildBorderRadius(context),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            toastContent,
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
              ),
          ],
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

  BuiltInToastWidget buildToast(BuildContext context) {
    final type = this.type ?? ToastificationType.info;

    final style = this.style ?? ToastificationStyle.fillColored;

    final backgroundColor = buildMaterialColor(this.backgroundColor);

    final onCloseTap = buildOnCloseTap();

    switch (style) {
      case ToastificationStyle.fillColored:
        return FilledToastWidget(
          type: type,
          title: title,
          description: description,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          icon: icon,
          brightness: brightness,
          padding: padding,
          borderRadius: borderRadius,
          elevation: elevation,
          onCloseTap: onCloseTap,
          showCloseButton: showCloseButton,
        );
      case ToastificationStyle.flatColored:
        return FilledToastWidget(
          type: type,
          title: title,
          description: description,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          icon: icon,
          brightness: brightness,
          padding: padding,
          borderRadius: borderRadius,
          elevation: elevation,
          onCloseTap: onCloseTap,
          showCloseButton: showCloseButton,
        );
      case ToastificationStyle.flat:
        return FilledToastWidget(
          type: type,
          title: title,
          description: description,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          icon: icon,
          brightness: brightness,
          padding: padding,
          borderRadius: borderRadius,
          elevation: elevation,
          onCloseTap: onCloseTap,
          showCloseButton: showCloseButton,
        );
    }
  }

  VoidCallback buildOnCloseTap() {
    return onCloseTap ??
        () {
          Toastification().dismiss(item);
        };
  }

  MaterialColor? buildMaterialColor(Color? backgroundColor) {
    if (backgroundColor == null) return null;

    final findInMaterialColors = Colors.primaries
        .firstWhereOrNull((element) => element.shade500 == backgroundColor);

    return findInMaterialColors ??
        ToastHelper.createMaterialColor(backgroundColor);
  }
}
