import 'package:example/src/core/usecase/extension/responsive.dart';
import 'package:example/src/core/views/widgets/core.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:example/src/features/home/views/widgets/customization_panel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
                    onPressed: () {
                      // TODO: add Make a Random Toast feature
                    },
                    child: const Text('Make a Random Toast'),
                  ),
                  const SizedBox(width: 24, height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                    ),
                    onPressed: () {
                      openGithub(context);
                    },
                    label: const Text('Give a Star'),
                    icon: const Icon(Iconsax.star_copy, size: 24),
                  ),
                  if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 85, bottom: 24),
                      child: CustomizeTitle(),
                    ),
                    const AnimatedArrow(),
                  ],
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedArrow extends StatefulWidget {
  const AnimatedArrow({super.key});

  @override
  AnimatedArrowState createState() => AnimatedArrowState();
}

class AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(0, 8 * _animation.value),
          child: child,
        );
      },
      child: const FaIcon(
        FontAwesomeIcons.arrowDown,
        size: 16,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
