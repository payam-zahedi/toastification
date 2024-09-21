import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in_style.dart';

/// enum to define the style of the built-in toastification
enum ToastificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,

  /// a simple toast message just show the given title without any icon or extra widget
  simple,
}

/// enum to define the type of the built-in toastification
enum ToastificationType {
  /// info toast to show some information - blue color - icon: info
  info,

  /// warning toast to show some warning - yellow color - icon: warning
  warning,

  /// error toast to show some error - red color - icon: error
  success,

  /// success toast to show some success - green color - icon: success
  error,
}

/// Using this enum you can define the behavior of the toast close button
enum CloseButtonShowType {
  /// [always] - show the close button always
  always._('Always'),

  /// [onHover] - show the close button only when the mouse is hovering the toast
  onHover._('On Hover'),

  /// [none] - do not show the close button
  none._('None');

  const CloseButtonShowType._(this.title);

  final String title;

  @override
  String toString() => title;

  String toValueString() => 'CloseButtonShowType.$name';
}

/// Creates the built-in toastification content - title, description, progress bar
///
/// This widget is used by the built-in toastification widgets
class BuiltInContent extends StatelessWidget {
  const BuiltInContent({
    super.key,
    required this.style,
    this.title,
    this.description,
    this.primaryColor,
    this.foregroundColor,
    this.backgroundColor,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
  });

  final BuiltInStyle style;

  final Widget? title;
  final Widget? description;

  final Color? primaryColor;
  final Color? foregroundColor;
  final Color? backgroundColor;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  @override
  Widget build(BuildContext context) {
    Widget content = DefaultTextStyle.merge(
      style: style.titleTextStyle(context)?.copyWith(
            color: foregroundColor,
          ),
      maxLines: 1,
      child: title ?? const SizedBox(),
    );

    final showColumn = description != null || showProgressBar == true;
    if (!showColumn) {
      return content;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content,
        if (description != null) ...[
          if (title != null) const SizedBox(height: 6),
          DefaultTextStyle.merge(
            style: style.descriptionTextStyle(context)?.copyWith(
                  color: foregroundColor,
                ),
            maxLines: 2,
            child: description!,
          ),
        ],
        if (showProgressBar) ...[
          if (title != null || description != null) const SizedBox(height: 10),
          ProgressIndicatorTheme(
            data:
                progressIndicatorTheme ?? style.progressIndicatorTheme(context),
            child: progressBarWidget ??
                LinearProgressIndicator(value: progressBarValue),
          ),
        ],
      ],
    );
  }
}
