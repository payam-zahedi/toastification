import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastAppBar extends StatelessWidget {
  const ToastAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final sidePaddings = context.responsiveValue(
      desktop: 58.0,
      tablet: 32.0,
    );

    if (!context.isInMobileZone) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          sidePaddings,
          54,
          sidePaddings,
          0,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 14),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SvgPicture.asset(
                'img/logo-text.svg',
                height: 35,
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                openGithub(context);
              },
              icon: const FaIcon(FontAwesomeIcons.github),
              label: const Text('Check the code'),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        24,
        56,
        24,
        0,
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/img/logo.png',
            height: 82,
            width: 82,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: SvgPicture.asset(
              'img/logo-text.svg',
              height: 35,
            ),
          ),
        ],
      ),
    );
  }
}
