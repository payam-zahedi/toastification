import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_container.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_logo.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_text_button.dart';
import 'package:flutter/material.dart';

class ToastAppBar extends StatelessWidget {
  final bool isWithBorder;
  const ToastAppBar({
    super.key,
    required this.isWithBorder,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isInDesktopZone) {
      return AppBarContainer(
        isWithBorder: isWithBorder,
        child: Row(
          children: [
            const AppBarLogo(),
            const SizedBox(width: 12),
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.abc),
              label: const Text('Github Source'),
            ),
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.face),
              label: const Text('Report an Issue'),
            ),
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.ac_unit_rounded),
              label: const Text('Pull Request'),
            ),
            AppBarTextButton(
              onPressed: () {},
              label: const Text('About Us'),
            ),
            const Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(),
              onPressed: () {},
              child: const Text('Give us a Star'),
            )
          ],
        ),
      );
    }
    return AppBarContainer(
      isWithBorder: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppBarLogo(),
          FilledButton(
            style: FilledButton.styleFrom(),
            onPressed: () {},
            child: const Text('Give us a Star'),
          ),
        ],
      ),
    );
  }
}
