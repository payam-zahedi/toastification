import 'package:flutter/material.dart';

class AppBarTextButton extends StatelessWidget {
  final Widget? icon;
  final Widget label;
  final void Function()? onPressed;

  const AppBarTextButton({
    super.key,
    this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonStyle = TextButton.styleFrom(
      foregroundColor: colorScheme.onSurface,
      backgroundColor: colorScheme.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 0,
      ),
    );

    if (icon == null) {
      return TextButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: label,
      );
    }

    return TextButton.icon(
      style: buttonStyle,
      onPressed: onPressed,
      icon: IconTheme(
        data: const IconThemeData(
          size: 20,
        ),
        child: icon!,
      ),
      label: label,
    );
  }
}
