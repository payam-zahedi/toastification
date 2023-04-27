import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';

class FlatToastWidget extends StatelessWidget with BuiltInToastWidget {
  const FlatToastWidget({
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
        return Icons.info_outline;
      case ToastificationType.warning:
        return Icons.warning_amber_rounded;
      case ToastificationType.success:
        return Icons.check_rounded;
      case ToastificationType.failed:
        return Icons.error_outline_rounded;
    }
  }

  @override
  BorderRadiusGeometry buildBorderRadius(BuildContext context) {
    return borderRadius ?? BorderRadius.circular(12);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = (brightness == Brightness.dark)
        ? ThemeData.dark(useMaterial3: false)
        : ThemeData.light(useMaterial3: false);

    final foreground = foregroundColor ?? defaultTheme.colorScheme.outline;
    final background = backgroundColor ?? buildColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius = buildBorderRadius(context);

    return IconTheme(
      data: defaultTheme.primaryIconTheme,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: background.shade200, width: 2),
        ),
        color: defaultTheme.colorScheme.surface,
        elevation: elevation ?? 0.0,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Row(
            children: [
              icon ??
                  Material(
                    color: background.shade400,
                    borderRadius: borderRadius / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        buildIcon(context),
                        size: 22,
                        color: foreground,
                      ),
                    ),
                  ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildContent(defaultTheme),
              ),
              const SizedBox(width: 16),
              Offstage(
                offstage: !showCloseButton,
                child: InkWell(
                  onTap: onCloseTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.close,
                      color: background.shade300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData defaultTheme) {
    final foreground = defaultTheme.colorScheme.onSurface;

    Widget content = Text(
      title,
      style: defaultTheme.textTheme.titleLarge?.copyWith(
        color: foreground,
        fontSize: 14,
        fontWeight: FontWeight.bold,
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
            style: defaultTheme.textTheme.displayLarge?.copyWith(
              color: foreground,
              fontSize: 12,
            ),
          )
        ],
      );
    }

    return content;
  }
}
