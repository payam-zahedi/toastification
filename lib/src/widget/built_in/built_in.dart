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

class BuiltInContent extends StatelessWidget {
  const BuiltInContent({
    super.key,
    required this.style,
    required this.title,
    this.description,
    this.foregroundColor,
  });

  final BuiltInStyle style;

  final String title;

  final String? description;

  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      title,
      style: style.titleTextStyle(context)?.copyWith(
            color: foregroundColor,
          ),
    );

    if (description?.isNotEmpty ?? false) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          const SizedBox(height: 2),
          Text(
            description!,
            style: style.descriptionTextStyle(context)?.copyWith(
                  color: foregroundColor?.withOpacity(.7),
                ),
          ),
        ],
      );
    }

    return content;
  }
}
