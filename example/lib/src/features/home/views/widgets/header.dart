import 'package:example/main.dart';
import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/core.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:example/src/features/home/views/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

final _bigStyleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class ToastHeader extends ConsumerWidget {
  const ToastHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRow = context.responsiveValue(
      desktop: true,
      tablet: false,
      mobile: false,
    );

    const imageWidget = Image(
      image: headerImage,
    );
    const informationWidget = _InformationWidget();

    if (isRow) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          24.0,
          context.responsiveValue(
            desktop: 84,
            tablet: 84,
            mobile: 48,
          ),
          0,
          24.0,
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const FractionallySizedBox(
                  widthFactor: .6,
                  child: informationWidget,
                ),
                Positioned.fill(
                  top: -165,
                  right: -context.fractionalSize(.05),
                  child: const FractionallySizedBox(
                    widthFactor: .5,
                    alignment: Alignment.topRight,
                    child: imageWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            informationWidget,
            Container(
              transform: Matrix4.translationValues(0.0, -60.0, 0.0),
              constraints: const BoxConstraints(maxWidth: 600),
              child: imageWidget,
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationWidget extends ConsumerWidget {
  const _InformationWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isBig = ref.watch(_bigStyleProvider);

    final bigTitle = context.responsiveValue(
      desktop: 52.0,
      tablet: 42.0,
      mobile: 28.0,
    );

    final mediumTitle = context.responsiveValue(
      desktop: 42.0,
      tablet: 36.0,
      mobile: 28.0,
    );

    final bigDescription = context.responsiveValue(
      desktop: 20.0,
      tablet: 18.0,
      mobile: 14.0,
    );

    final mediumDescription = context.responsiveValue(
      desktop: 17.0,
      tablet: 16.0,
      mobile: 14.0,
    );

    final isRow = context.responsiveValue(
      desktop: true,
      tablet: false,
      mobile: false,
    );

    final textAlign = isRow ? TextAlign.start : TextAlign.center;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 42),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isRow ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onDoubleTap: () {
              // ref.read(_bigStyleProvider.notifier).state = !isBig;
              ref.read(themeVariantProvider.notifier).state =
                  !ref.read(themeVariantProvider);
            },
            child: const ColoredTag(
              icon: FontAwesomeIcons.github,
              text: '150 Stars on Github',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Make your App Engaging\nwith our Customizable\nToast Notifications',
            textAlign: textAlign,
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: isBig ? bigTitle : mediumTitle,
              fontWeight: context.responsiveValue(
                desktop: FontWeight.w700,
                tablet: FontWeight.w700,
                mobile: FontWeight.w500,
              ),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'With Toastification, you can add and manage multiple toast messages\n simultaneously with ease. Additionally, we\'ve included some predefined toast\n widgets that can help you show the state of your application.',
            textAlign: textAlign,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(.4),
              fontSize: isBig ? bigDescription : mediumDescription,
              fontWeight: FontWeight.w300,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onPressed: () {
                  openGithubPullRequests(context);
                },
                icon: Icon(
                  Iconsax.programming_arrow_copy,
                  size: 18,
                  color: theme.colorScheme.onTertiary,
                ),
                label: const Text('Pull Requests'),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onPressed: () {
                  openGithub(context);
                },
                icon: const Icon(
                  Icons.star_rounded,
                  size: 18,
                ),
                label: const Text('Give a Star'),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
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
