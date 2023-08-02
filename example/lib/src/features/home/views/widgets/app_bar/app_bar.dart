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

const _height = 72.0;
const _topMargin = 6.0;
const _totalHeight = _height + _topMargin;

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  const AppBarDelegate();

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
        height: _height,
        topMargin: _topMargin,
        isElevated: shrinkPercentage >= 0.8,
        child: Row(
          children: [
            const AppBarLogo(),
            const SizedBox(width: 46),
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

    return Container(
      color: Theme.of(context).colorScheme.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBarContainer(
        isElevated: false,
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
      ),
    );
  }

  @override
  double get maxExtent => _totalHeight;

  @override
  double get minExtent => _totalHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
