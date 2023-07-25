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

    if (icon == null) {
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onBackground,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 0,
          ),
        ),
        onPressed: onPressed,
        child: label,
      );
    }

    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.onBackground,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
      ),
      onPressed: onPressed,
      icon: icon!,
      label: label,
    );
  }
}
