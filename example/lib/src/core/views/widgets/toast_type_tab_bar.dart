import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ToastTypeTabBar extends ConsumerWidget {
  const ToastTypeTabBar({
    super.key,
    this.initialType,
    this.onTypeChanged,
  });
  final ToastificationType? initialType;

  final ValueChanged<ToastificationType>? onTypeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final type = ref.watch(toastDetailControllerProvider).type;
    const itemHeight = 40.0;
    const itemSpacing = 5.0;
    const itemsLength = 5;

    final gridCrossAxisCount = context.isInMobileZone ? 2 : itemsLength;
    final gridMainAxisCount = (itemsLength / gridCrossAxisCount).ceil();
    final lastItemCountCell =
        (gridCrossAxisCount * gridMainAxisCount) - itemsLength + 1;

    final gridHeight =
        gridMainAxisCount * itemHeight + gridMainAxisCount + itemSpacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4.0),
          child: Text(
            'Toast Type',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: gridHeight,
          width: double.infinity,
          child: StaggeredGrid.count(
            crossAxisCount: gridCrossAxisCount,
            crossAxisSpacing: itemSpacing,
            mainAxisSpacing: itemSpacing,
            children: [
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: TabTypeItem(
                  selected: type == ToastificationType.success,
                  title: 'Success',
                  color: successColor,
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeType(ToastificationType.success);
                  },
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: TabTypeItem(
                  selected: type == ToastificationType.info,
                  title: 'Info',
                  color: infoColor,
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeType(ToastificationType.info);
                  },
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: TabTypeItem(
                  selected: type == ToastificationType.warning,
                  title: 'Warning',
                  color: warningColor,
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeType(ToastificationType.warning);
                  },
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: TabTypeItem(
                  selected: type == ToastificationType.error,
                  title: 'Error',
                  color: errorColor,
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeType(ToastificationType.error);
                  },
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: lastItemCountCell,
                child: const CustomTabItem(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabTypeItem extends StatelessWidget {
  const TabTypeItem({
    super.key,
    required this.selected,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      animationDuration: const Duration(milliseconds: 500),
      color: selected ? color.withOpacity(.1) : theme.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: selected ? color : theme.colorScheme.outline,
          width: 1.5,
        ),
      ),
      child: SizedBox(
        height: 40,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.0),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                height: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      height: 40,
      enabled: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Custom',
          ),
          SizedBox(width: 4),
          SoonWidget()
        ],
      ),
    );
  }
}
