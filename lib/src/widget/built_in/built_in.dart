import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in_style.dart';

enum ToastificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,
}

enum ToastificationType {
  info,
  warning,
  success,
  error,
}

enum CloseButtonShowType {
  always('Always'),
  onHover('On Hover'),
  none('None');

  const CloseButtonShowType(this.title);

  final String title;

  @override
  String toString() => title;

  String toValueString() => '$CloseButtonShowType.$name';
}

class BuiltInContent extends StatelessWidget {
  const BuiltInContent({
    super.key,
    required this.style,
    required this.title,
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

  final String title;

  final String? description;

  final Color? primaryColor;
  final Color? foregroundColor;
  final Color? backgroundColor;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  @override
  Widget build(BuildContext context) {
    final showColumn =
        description?.isNotEmpty == true || showProgressBar == true;

    if (showColumn) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(context),
          if (description?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: style.descriptionTextStyle(context),
            ),
          ],
          if (showProgressBar) ...[
            const SizedBox(height: 10),
            ProgressIndicatorTheme(
              data: progressIndicatorTheme ??
                  style.progressIndicatorTheme(context),
              child: progressBarWidget ??
                  LinearProgressIndicator(value: progressBarValue),
            ),
          ],
        ],
      );
    }

    return buildTitle(context);
  }

  Text buildTitle(BuildContext context) {
    return Text(
      title,
      style: style.titleTextStyle(context)?.copyWith(
            color: foregroundColor,
          ),
    );
  }
}
