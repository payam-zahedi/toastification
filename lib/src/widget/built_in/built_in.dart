import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/model/build_in_content_model.dart';

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
    required this.contentModel,
  });

  final BuildInContentModel contentModel;
  @override
  Widget build(BuildContext context) {
    Widget content = DefaultTextStyle.merge(
      style:contentModel.style.titleTextStyle(context)?.copyWith(
            color: contentModel.foregroundColor,
          ),
      child: contentModel.title ?? const SizedBox(),
    );

    final showColumn = contentModel.description != null || contentModel.showProgressBar == true;
    if (!showColumn) {
      return content;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content,
        if (contentModel.description != null) ...[
          const SizedBox(height: 6),
          DefaultTextStyle.merge(
            style: contentModel.style.descriptionTextStyle(context)?.copyWith(
                  color: contentModel.foregroundColor,
                ),
            child: contentModel.description!,
          ),
        ],
        if (contentModel.showProgressBar) ...[
          const SizedBox(height: 10),
          ProgressIndicatorTheme(
            data:
                contentModel.progressIndicatorTheme ?? contentModel.style.progressIndicatorTheme(context),
            child: contentModel.progressBarWidget ??
                LinearProgressIndicator(value: contentModel.progressBarValue),
          ),
        ],
      ],
    );
  }
}
