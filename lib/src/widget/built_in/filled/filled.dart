import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';

class FilledToastWidget extends StatelessWidget with BuiltInToastWidget {
  const FilledToastWidget({
    super.key,
    required this.type,
    required this.title,
    this.description,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.onCloseTap,
    this.showCloseButton,
  });

  @override
  final ToastificationType type;

  final String title;
  final String? description;

  final Widget? icon;

  final MaterialColor? backgroundColor;
  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final double? elevation;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  @override
  MaterialColor buildColor(BuildContext context) {
    switch (type) {
      case ToastificationType.info:
        return Colors.blue;
      case ToastificationType.warning:
        return Colors.amber;
      case ToastificationType.success:
        return Colors.green;
      case ToastificationType.failed:
        return Colors.red;
    }
  }

  @override
  IconData buildIcon(BuildContext context) {
    switch (type) {
      case ToastificationType.info:
        return Icons.info;
      case ToastificationType.warning:
        return Icons.warning;
      case ToastificationType.success:
        return Icons.check;
      case ToastificationType.failed:
        return Icons.warning_rounded;
    }
  }

  @override
  BorderRadiusGeometry buildBorderRadius(BuildContext context) {
    return borderRadius ?? BorderRadius.circular(8);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = (brightness ?? Brightness.light) == Brightness.light
        ? ThemeData.light()
        : ThemeData.dark();

    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;
    final background = backgroundColor ?? buildColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    return IconTheme(
      data: defaultTheme.primaryIconTheme,
      child: Material(
        borderRadius: buildBorderRadius(context),
        color: background,
        elevation: elevation ?? 4.0,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Row(
            children: [
              icon ??
                  Icon(
                    buildIcon(context),
                    size: 28,
                    color: foreground,
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
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: onCloseTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData defaultTheme) {
    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;

    Widget content = Text(
      title,
      style: defaultTheme.textTheme.displayLarge?.copyWith(
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
            style: defaultTheme.textTheme.displayLarge?.copyWith(
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
