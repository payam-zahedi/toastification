import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_container.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_logo.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ToastAppBar extends StatelessWidget {
  const ToastAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: _AppBar(),
    );
  }
}

class PinnedToastAppBar extends StatelessWidget {
  const PinnedToastAppBar({super.key});

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

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final shrinkPercentage = shrinkOffset / maxExtent;
    return _AppBar(isElevated: shrinkPercentage >= 0.8);
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

const _height = 72.0;
const _topMargin = 6.0;
const _totalHeight = _height + _topMargin;

class _AppBar extends StatelessWidget {
  const _AppBar({this.isElevated = false});

  final bool isElevated;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(width: 8.0);

    if (context.isInDesktopZone) {
      return AppBarContainer(
        height: _height,
        topMargin: _topMargin,
        isElevated: isElevated,
        child: Row(
          children: [
            const AppBarLogo(),
            const SizedBox(width: 46),
            AppBarTextButton(
              onPressed: () {
                openGithub(context);
              },
              icon: const Icon(FontAwesomeIcons.github),
              label: const Text('Github Source'),
            ),
            gap,
            AppBarTextButton(
              onPressed: () {
                openGithubIssues(context);
              },
              icon: const Icon(
                Iconsax.cd_copy,
              ),
              label: const Text('Report an Issue'),
            ),
            gap,
            AppBarTextButton(
              onPressed: () {
                openGithubPullRequests(context);
              },
              icon: const Icon(
                Iconsax.programming_arrow_copy,
              ),
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
              onPressed: () {
                openGithub(context);
              },
              child: const Text('Give us a Star'),
            )
          ],
        ),
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
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
              onPressed: () {
                openGithub(context);
              },
              child: const Text('Give us a Star'),
            ),
          ],
        ),
      ),
    );
  }
}
