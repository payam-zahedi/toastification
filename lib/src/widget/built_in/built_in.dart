import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';

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
    this.title,
    this.description,
    this.progressBarValue,
    this.progressBarWidget,
  });

  final Widget? title;
  final Widget? description;

  final double? progressBarValue;
  final Widget? progressBarWidget;

  @override
  Widget build(BuildContext context) {
    Widget content = DefaultTextStyle.merge(
      style: context.toastTheme.titleTextStyle,
      maxLines: 1,
      child: title ?? const SizedBox(),
    );

    final showColumn =
        description != null || context.toastTheme.showProgressBar == true;
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
            style: context.toastTheme.descriptionTextStyle,
            child: description!,
          ),
        ],
        if (context.toastTheme.showProgressBar) ...[
          if (title != null || description != null) const SizedBox(height: 10),
          ProgressIndicatorTheme(
            data: context.toastTheme.progressIndicatorTheme,
            child: progressBarWidget ??
                LinearProgressIndicator(value: progressBarValue),
          ),
        ],
      ],
    );
  }
}
