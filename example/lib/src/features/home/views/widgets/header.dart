import 'package:example/src/core/usecase/extension/responsive.dart';
import 'package:example/src/core/views/widgets/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastHeader extends StatelessWidget {
  const ToastHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24.0,
        context.responsiveValue(
          desktop: 84,
          tablet: 84,
          mobile: 48,
        ),
        24.0,
        24.0,
      ),
      child: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              const ColoredTag(
                text: 'FLUTTER TOAST NOTIFICATIONS',
              ),
              const SizedBox(height: 8),
              Text(
                'Nostrum sequi beatae\nsed excepturi voly.',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: context.responsiveValue(
                    desktop: 56,
                    tablet: 48,
                    mobile: 32,
                  ),
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              Text(
                'Ullam possimus vitae eos maiores enim y.A sunt ducimus consequuntur ducimus qut.In cum esse beatae id laborum dolores l.Commodi at qui reiciendis. Eos sunt eot.Maiores sed sequi nulla quas asperiorex.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: context.responsiveValue(
                    desktop: 18,
                    tablet: 16,
                    mobile: 14,
                  ),
                  fontWeight: FontWeight.w100,
                  color: theme.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.responsiveValue(
                  desktop: 65,
                  tablet: 65,
                  mobile: 42,
                ),
              ),
              Flex(
                direction: context.responsiveValue(
                  desktop: Axis.horizontal,
                  tablet: Axis.horizontal,
                  mobile: Axis.vertical,
                ),
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                    ),
                    onPressed: () {},
                    child: const Text('Make a Random Toast'),
                  ),
                  const SizedBox(width: 24, height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                    ),
                    onPressed: () {},
                    label: const Text('Give a Star'),
                    icon: const FaIcon(FontAwesomeIcons.star),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
