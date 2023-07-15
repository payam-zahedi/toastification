// ignore_for_file: prefer_const_constructors

import 'package:example/src/core/usecase/extension/responsive.dart';
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/count_tile.dart';
import 'package:example/src/core/views/widgets/drop_down.dart';
import 'package:example/src/core/views/widgets/expandable_section.dart';
import 'package:example/src/core/views/widgets/picker/alignment.dart';
import 'package:example/src/core/views/widgets/picker/border_radius.dart';
import 'package:example/src/core/views/widgets/picker/color.dart';
import 'package:example/src/core/views/widgets/picker/elevation.dart';
import 'package:example/src/core/views/widgets/picker/toast_style.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/core/views/widgets/tab_bar.dart';
import 'package:example/src/core/views/widgets/toggle_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

class CustomizationPanel extends ConsumerWidget {
  const CustomizationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          if (!ResponsiveWrapper.of(context).isSmallerThan(MOBILE))
            const CustomizeTitle(),
          const SizedBox(height: 24),
          ToastTypeTabBar(
            onTypeChanged: (value) {
              ref
                  .read(toastDetailControllerProvider.notifier)
                  .changeType(value);
            },
          ),
          const SizedBox(height: 32),
          ToastStylePicker(
            type: ref.watch(toastDetailControllerProvider).type,
            initialStyle: ToastificationStyle.flat,
            onStyleChanged: (style) {
              ref
                  .read(toastDetailControllerProvider.notifier)
                  .changeStyle(style);
            },
          ),
          const _PositionHolder(),
          const _ContentAndStyleHolder(),
          const _ControllersAndInteractionsHolder(),
        ],
      ),
    );
  }
}

class CustomizeTitle extends StatelessWidget {
  const CustomizeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const titleColor = Color(0xff1C1B28);

    return Flex(
      direction: context.responsiveValue(
        desktop: Axis.horizontal,
        tablet: Axis.vertical,
        mobile: Axis.vertical,
      ),
      crossAxisAlignment: context.responsiveValue(
        desktop: CrossAxisAlignment.end,
        tablet: CrossAxisAlignment.center,
        mobile: CrossAxisAlignment.center,
      ),
      children: [
        Text(
          'Customize your toast!',
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: context.responsiveValue(
              desktop: 40,
              mobile: 20,
            ),
            fontWeight: FontWeight.w500,
            color: titleColor,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          ' Let’s make it easy!',
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: context.responsiveValue(
              desktop: 24,
              mobile: 14,
            ),
            fontWeight: FontWeight.w500,
            color: titleColor.withOpacity(.4),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _PositionHolder extends StatelessWidget {
  const _PositionHolder();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableSection(
        title: 'Position',
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 10,
                  child: _AlignmentSection(),
                ),
                Spacer(
                  flex: context.responsiveValue(
                    mobile: 1,
                    tablet: 1,
                    desktop: 3,
                  ),
                ),
                const Expanded(flex: 7, child: _BorderSection()),
              ],
            ),
            const SizedBox(height: 42),
            const _ElevationSection(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _ContentAndStyleHolder extends StatelessWidget {
  const _ContentAndStyleHolder();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 32),
      child: ExpandableSection(
        title: 'Content & Style',
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ContentSection(),
            SizedBox(height: 18),
            _StyleSection(),
          ],
        ),
      ),
    );
  }
}

class _ControllersAndInteractionsHolder extends StatelessWidget {
  const _ControllersAndInteractionsHolder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableSection(
        title: 'Controllers & Interaction',
        body: Column(
          children: [
            const _SystemSection(),
            const _CloseSection(),
            const _ProgressBarSection(),
            ResponsiveRowColumn(
              rowSpacing: 10,
              columnSpacing: 10,
              columnMainAxisSize: MainAxisSize.min,
              layout: context.responsiveValue(
                mobile: ResponsiveRowColumnType.COLUMN,
                tablet: ResponsiveRowColumnType.ROW,
                desktop: ResponsiveRowColumnType.ROW,
              ),
              children: const [
                ResponsiveRowColumnItem(
                  rowFit: FlexFit.tight,
                  columnFit: FlexFit.loose,
                  child: _PauseSection(),
                ),
                ResponsiveRowColumnItem(
                  rowFit: FlexFit.tight,
                  columnFit: FlexFit.loose,
                  child: _DragSection(),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _AlignmentSection extends ConsumerWidget {
  const _AlignmentSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'PLACEMENT',
      body: AlignmentPicker(
        selectedAlignment: ref.watch(toastDetailControllerProvider).alignment,
        onChanged: (alignment) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changeAlignment(alignment);
        },
      ),
    );
  }
}

class _BorderSection extends ConsumerWidget {
  const _BorderSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'BORDER',
      body: BorderRadiusPicker(
        selectedBorderRadius: ref
            .watch(toastDetailControllerProvider)
            .borderRadius
            ?.resolve(Directionality.of(context)),
        onChanged: (borderRadius) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changeBorderRadius(borderRadius);
        },
      ),
    );
  }
}

class _ElevationSection extends ConsumerWidget {
  const _ElevationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: SubSection(
        title: 'SHADOW',
        body: ShadowPicker(
          selectedShadow: ref.watch(toastDetailControllerProvider).shadow,
          onChanged: (shadow) {
            ref
                .read(toastDetailControllerProvider.notifier)
                .changeShadow(shadow);
          },
        ),
      ),
    );
  }
}

class _ContentSection extends ConsumerWidget {
  const _ContentSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textDirection = ref.watch(toastDetailControllerProvider).direction ??
        Directionality.of(context);

    return SubSection(
      title: 'CONTENT',
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: const [
                        BorderedContainer(
                          width: 48,
                          height: 48,
                          child: Icon(Iconsax.info_circle_copy),
                        ),
                        SoonWidget()
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type the title text here..',
                        ),
                        onChanged: (value) {
                          ref
                              .read(toastDetailControllerProvider.notifier)
                              .changeTitle(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 106,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Type the body text here..',
                    ),
                    onChanged: (value) {
                      ref
                          .read(toastDetailControllerProvider.notifier)
                          .changeDescription(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 164,
            child: Column(
              // three bordered containers
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(200, 56),
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add Section'),
                      // soon to be icon
                      SoonWidget(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BorderedContainer(
                  height: 48,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeDirection(TextDirection.ltr);
                  },
                  active: textDirection == TextDirection.ltr,
                  child: Row(
                    children: [
                      const Expanded(child: Text('LTR layout')),
                      Offstage(
                        offstage: textDirection != TextDirection.ltr,
                        child: const Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BorderedContainer(
                  height: 48,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeDirection(TextDirection.rtl);
                  },
                  active: textDirection == TextDirection.rtl,
                  child: Row(
                    children: [
                      const Expanded(child: Text('RTL layout')),
                      Offstage(
                        offstage: textDirection != TextDirection.rtl,
                        child: const Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StyleSection extends ConsumerWidget {
  const _StyleSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SubSection(
      title: 'STYLE',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveRowColumn(
            layout: context.responsiveValue(
              mobile: ResponsiveRowColumnType.COLUMN,
              tablet: ResponsiveRowColumnType.ROW,
              desktop: ResponsiveRowColumnType.ROW,
            ),
            rowSpacing: 10,
            columnSpacing: 10,
            columnMainAxisSize: MainAxisSize.min,
            children: [
              ResponsiveRowColumnItem(
                rowFit: FlexFit.tight,
                columnFit: FlexFit.loose,
                child: ColorPicker(
                  title: 'Background',
                  selectedColor: theme.colorScheme.surfaceVariant,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFit: FlexFit.tight,
                columnFit: FlexFit.loose,
                child: ColorPicker(
                  title: 'Icon',
                  selectedColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFit: FlexFit.tight,
                columnFit: FlexFit.loose,
                child: ColorPicker(
                  title: 'Text',
                  selectedColor: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const BorderedDropDown<String>(
            hint: 'Palette templates',
            available: false,
            items: [
              DropdownMenuItem(
                value: 'Roboto',
                child: Text('Roboto'),
              ),
              DropdownMenuItem(
                value: 'Open Sans',
                child: Text('Open Sans'),
              ),
              DropdownMenuItem(
                value: 'Lato',
                child: Text('Lato'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SystemSection extends ConsumerWidget {
  const _SystemSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'SYSTEM',
      body: ResponsiveRowColumn(
        rowSpacing: 10,
        columnSpacing: 10,
        columnMainAxisSize: MainAxisSize.min,
        layout: context.responsiveValue(
          mobile: ResponsiveRowColumnType.COLUMN,
          tablet: ResponsiveRowColumnType.ROW,
          desktop: ResponsiveRowColumnType.ROW,
        ),
        children: [
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: ToggleTile(
              title: 'Newest on top',
              value: ref.watch(toastDetailControllerProvider).newestOnTop,
              soon: true,
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeNewestOnTop(value!);
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: BorderedDropDown<String>(
              icon: const Icon(Iconsax.star_1_copy),
              hint: 'Animation type',
              items: const [
                DropdownMenuItem(
                  value: 'Default',
                  child: Text('Default'),
                ),
                DropdownMenuItem(
                  value: 'Fade',
                  child: Text('Fade'),
                ),
                DropdownMenuItem(
                  value: 'Slide',
                  child: Text('Slide'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseSection extends ConsumerWidget {
  const _CloseSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'CLOSE',
      body: ResponsiveRowColumn(
        rowSpacing: 10,
        columnSpacing: 10,
        columnMainAxisSize: MainAxisSize.min,
        layout: context.responsiveValue(
          mobile: ResponsiveRowColumnType.COLUMN,
          tablet: ResponsiveRowColumnType.ROW,
          desktop: ResponsiveRowColumnType.ROW,
        ),
        children: [
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: ToggleTile(
              title: 'Close on click',
              value: ref.watch(toastDetailControllerProvider).closeOnClick,
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeCloseOnClick(value!);
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: BorderedDropDown<String>(
              icon: const Icon(Icons.close_rounded, size: 18),
              hint: 'Choose close button type',
              items: const [
                DropdownMenuItem(
                  value: 'Icon',
                  child: Text('Icon'),
                ),
                DropdownMenuItem(
                  value: 'Text',
                  child: Text('Text'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBarSection extends ConsumerWidget {
  const _ProgressBarSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var timeoutValue = (ref
                .watch(toastDetailControllerProvider)
                .autoCloseDuration
                ?.inMilliseconds ??
            0) /
        1000;

    return SubSection(
      title: 'PROGRESS BAR',
      body: ResponsiveRowColumn(
        rowSpacing: 10,
        columnSpacing: 10,
        columnMainAxisSize: MainAxisSize.min,
        layout: context.responsiveValue(
          mobile: ResponsiveRowColumnType.COLUMN,
          tablet: ResponsiveRowColumnType.ROW,
          desktop: ResponsiveRowColumnType.ROW,
        ),
        children: [
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: ToggleTile(
              title: 'Show progress bar',
              value: ref.watch(toastDetailControllerProvider).showProgressBar,
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeShowProgressBar(value!);
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: CountTile(
              title: 'Timeout',
              icon: Icon(
                Iconsax.timer_1_copy,
                color: theme.colorScheme.onSurface.withOpacity(.2),
              ),
              value: timeoutValue,
              valueSuffix: 's',
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeAutoCloseDuration(
                        Duration(milliseconds: (value * 1000).toInt()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PauseSection extends ConsumerWidget {
  const _PauseSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'PAUSE',
      body: ToggleTile(
        title: 'Pause on hover',
        value: ref.watch(toastDetailControllerProvider).pauseOnHover,
        onChanged: (value) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changePauseOnHover(value!);
        },
      ),
    );
  }
}

class _DragSection extends ConsumerWidget {
  const _DragSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'DRAG',
      body: ToggleTile(
        title: 'Drag to close',
        value: ref.watch(toastDetailControllerProvider).dragToClose,
        onChanged: (value) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changeDragToClose(value!);
        },
      ),
    );
  }
}
