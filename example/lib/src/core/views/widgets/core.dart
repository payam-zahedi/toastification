import 'package:example/src/core/usecase/extension/responsive.dart';
import 'package:flutter/material.dart';

class ColoredTag extends StatelessWidget {
  const ColoredTag({
    super.key,
    required this.text,
    this.background,
    this.foreground,
  });

  final String text;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: background ?? theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontSize: context.responsiveValue(
            desktop: 14,
            tablet: 12,
            mobile: 11,
          ),
          fontWeight: FontWeight.bold,
          color: foreground ?? theme.colorScheme.onTertiary,
          letterSpacing: 1.09,
        ),
      ),
    );
  }
}
