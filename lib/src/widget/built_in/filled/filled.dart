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
    required this.textDirection,
    this.onCloseTap,
    this.showCloseButton,
  });

  @override
  final ToastificationType type;

  final String title;
  final String? description;

  final Widget? icon;

  final TextDirection textDirection;

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
        return Icons.warning_rounded;
      case ToastificationType.success:
        return Icons.check_rounded;

      case ToastificationType.failed:
        return Icons.error;
    }
  }

  @override
  BorderRadiusGeometry buildBorderRadius(BuildContext context) {
    return borderRadius ?? BorderRadius.circular(8);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = Theme.of(context);

    //final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;
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
          child: IntrinsicHeight(
            child: Directionality(
              textDirection: textDirection,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Offstage(
                    offstage: !showCloseButton,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent, // Button color
                          child: InkWell(
                            onTap: onCloseTap,
                            child: const SizedBox(
                              width: 28,
                              height: 28,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(Icons.close,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCloseButton,
                    child: const Padding(
                      padding: EdgeInsetsDirectional.only(end: 16.0),
                      child: VerticalDivider(
                          color: Colors.white70, width: 2.0, thickness: 2.0),
                    ),
                  ),
                  Expanded(child: _buildContent(defaultTheme)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData defaultTheme) {
    final foreground = foregroundColor ?? defaultTheme.primaryIconTheme.color;

    Widget content = Text(
      title,
      textAlign: TextAlign.end,
      style: defaultTheme.textTheme.displayLarge?.copyWith(
        color: foreground,
        fontSize: 18,
      ),
    );

    if (description?.isNotEmpty ?? false) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
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
