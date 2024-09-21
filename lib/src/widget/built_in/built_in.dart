import 'package:flutter/material.dart';
import 'package:toastification/src/core/style/built_in_style.dart';


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
          const SizedBox(height: 6),
          DefaultTextStyle.merge(
            style: style.descriptionTextStyle(context)?.copyWith(
                  color: foregroundColor,
                ),
            child: description!,
          ),
        ],
        if (showProgressBar) ...[
          const SizedBox(height: 10),
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
