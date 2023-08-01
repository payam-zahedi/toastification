import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_container.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_logo.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_text_button.dart';
import 'package:flutter/material.dart';

class ToastAppBar extends StatelessWidget {
  const ToastAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      delegate: AppBarDelegate(),
      pinned: true,
    );
  }
}

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  const AppBarDelegate();
  final maxHeight = 72.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final shrinkPercentage = shrinkOffset / maxExtent;
    const gap = SizedBox(width: 8.0);

    if (context.isInDesktopZone) {
      return AppBarContainer(
        topMargin: 6,
        shrinkPercentage: shrinkPercentage,
        child: Row(
          children: [
            const AppBarLogo(),
            const SizedBox(width: 12),
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.abc),
              label: const Text('Github Source'),
            ),
            gap,
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.face),
              label: const Text('Report an Issue'),
            ),
            gap,
            AppBarTextButton(
              onPressed: () {},
              icon: const Icon(Icons.ac_unit_rounded),
              label: const Text('Pull Request'),
            ),
            gap,
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
      shrinkPercentage: 0,
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

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
