import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class MinimalToastWidget extends StatelessWidget with BuiltInToastWidget {
  const MinimalToastWidget({
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
    final color = switch (type) {
      ToastificationType.info => const Color(0xff84C4FF),
      ToastificationType.warning => const Color(0xffFFCE84),
      ToastificationType.success => const Color(0xff59C83E),
      ToastificationType.failed => const Color(0xffFF8484),
    };

    return ToastHelper.createMaterialColor(color);
  }

  @override
  IconData buildIcon(BuildContext context) {
    switch (type) {
      case ToastificationType.info:
        return Icons.question_mark_rounded;
      case ToastificationType.warning:
        return Icons.warning_amber_rounded;
      case ToastificationType.success:
        return Icons.done;
      case ToastificationType.failed:
        return Icons.priority_high_rounded;
    }
  }

  @override
  BorderRadiusGeometry buildBorderRadius(BuildContext context) {
    return borderRadius ?? BorderRadius.circular(16);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = (brightness == Brightness.dark)
        ? ThemeData.dark(useMaterial3: false)
        : ThemeData.light(useMaterial3: false);

    final tintColor = buildColor(context);

    final foreground = foregroundColor ?? defaultTheme.colorScheme.onSurface;
    final background = backgroundColor ?? defaultTheme.colorScheme.surface;

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius = buildBorderRadius(context);

    return IconTheme(
      data: defaultTheme.primaryIconTheme,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: const BorderSide(
            color: Color(0xffEBEBEB),
            width: 2,
          ),
        ),
        color: background,
        elevation: elevation ?? 0.0,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              icon ??
                  _IconHolder(
                    color: tintColor,
                    icon: Icon(
                      buildIcon(context),
                      size: 20,
                      color: background,
                    ),
                  ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildContent(defaultTheme, foreground),
              ),
              const SizedBox(width: 4),
              Offstage(
                offstage: !showCloseButton,
                child: InkWell(
                  onTap: onCloseTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.close,
                      color: foreground.withOpacity(.3),
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

  Widget _buildContent(ThemeData defaultTheme, Color foreground) {
    Widget content = Text(
      title,
      style: defaultTheme.textTheme.titleLarge?.copyWith(
        color: foreground,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );

    if (description?.isNotEmpty ?? false) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          Text(
            description!,
            style: defaultTheme.textTheme.displayLarge?.copyWith(
              color: foreground,
              fontSize: 12,
              height: 1.3,
            ),
          )
        ],
      );
    }

    return content;
  }
}

class _IconHolder extends StatelessWidget {
  const _IconHolder({super.key, required this.color, required this.icon});
  final Color color;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Material(
        color: color.withOpacity(.3),
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(3.33),
          child: Material(
            color: color,
            shape: const CircleBorder(),
            child: icon,
          ),
        ),
      ),
    );
  }
}
