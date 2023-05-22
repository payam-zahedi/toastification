import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastAppBar extends StatelessWidget {
  const ToastAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(145, 54, 145, 0),
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
              backgroundColor: Colors.black12,
              foregroundColor: colorScheme.onBackground,
            ),
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.github),
            label: const Text('Check the code'),
          ),
        ],
      ),
    );
  }
}
