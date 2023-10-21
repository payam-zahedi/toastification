import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ColoredTag extends StatelessWidget {
  const ColoredTag({
    super.key,
    required this.text,
    this.icon,
    this.background,
    this.foreground,
  });

  final String text;
  final IconData? icon;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        fontSize: context.responsiveValue(
          desktop: 12,
          tablet: 11,
          mobile: 10,
        ),
        fontWeight: FontWeight.bold,
        color: foreground ?? theme.colorScheme.onTertiary,
        height: 1.8,
        letterSpacing: 1.09,
      ),
    );

    if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: context.responsiveValue(
              desktop: 24,
              tablet: 18,
              mobile: 16,
            ),
            color: foreground ?? theme.colorScheme.onTertiary,
          ),
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return TagContainer(child: child);
  }
}

class TagContainer extends StatelessWidget {
  const TagContainer({
    super.key,
    required this.child,
    this.background,
    this.foreground,
  });

  final Widget child;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
      decoration: BoxDecoration(
        color: background ?? theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
