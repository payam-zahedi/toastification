import 'package:flutter/material.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';
import 'package:toastification/toastification.dart';

/// Creates the toastification content - title, description, progress bar
///
/// This widget is used by the toastification widgets
class ToastContent extends StatelessWidget {
  const ToastContent({
    super.key,
    this.title,
    this.description,
    this.progressBarValue,
    this.progressBarWidget,
    this.parentShowProgressBar = true,
  });

  final Widget? title;
  final Widget? description;

  final bool parentShowProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = context.toastTheme;
    final toastStyle = defaultTheme.toastStyle!;
    final config = ToastificationConfigProvider.maybeOf(context)?.config;

    Widget content = DefaultTextStyle.merge(
      style: toastStyle.titleTextStyle,
      maxLines: config?.maxTitleLines ?? 2,
      overflow: TextOverflow.ellipsis,
      child: title ?? const SizedBox(),
    );

    final showColumn =
        description != null || defaultTheme.showProgressBar == true;
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
            style: toastStyle.descriptionTextStyle,
            maxLines: config?.maxDescriptionLines,
            child: description!,
          ),
        ],
        if (defaultTheme.showProgressBar && parentShowProgressBar) ...[
          if (title != null || description != null) const SizedBox(height: 10),
          ProgressIndicatorTheme(
            data: toastStyle.progressIndicatorTheme,
            child: progressBarWidget ??
                LinearProgressIndicator(value: progressBarValue),
          ),
        ],
      ],
    );
  }
}
