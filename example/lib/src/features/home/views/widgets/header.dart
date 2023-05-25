import 'package:example/src/core/views/widgets/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastHeader extends StatelessWidget {
  const ToastHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const ColoredTag(
          text: 'FLUTTER TOAST NOTIFICATIONS',
        ),
        const SizedBox(height: 8),
        Text(
          'Nostrum sequi beatae\nsed excepturi voly.',
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: 56,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          'Ullam possimus vitae eos maiores enim y.A sunt ducimus consequuntur\n ducimus qut.In cum esse beatae id laborum dolores l.Commodi at qui\n reiciendis. Eos sunt eot.Maiores sed sequi nulla quas asperiorex.',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w100,
            color: theme.colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 65),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40),
              ),
              onPressed: () {},
              child: const Text('Make a Random Toast'),
            ),
            const SizedBox(width: 24),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
              ),
              onPressed: () {},
              label: const Text('Give a Star'),
              icon: const FaIcon(FontAwesomeIcons.star),
            )
          ],
        )
      ],
    );
  }
}
