import 'package:flutter/material.dart';

class SoonWidget extends StatelessWidget {
  const SoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.error,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 3,
        ),
        child: Text(
          'SOON',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onError,
            fontSize: 9,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ),
    );
  }
}
