// ignore_for_file: prefer_const_constructors

import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/border_holder.dart';
import 'package:example/src/core/views/widgets/count_tile.dart';
import 'package:example/src/core/views/widgets/drop_down.dart';
import 'package:example/src/core/views/widgets/expandable_section.dart';
import 'package:example/src/core/views/widgets/picker/alignment.dart';
import 'package:example/src/core/views/widgets/picker/border_radius.dart';
import 'package:example/src/core/views/widgets/picker/color.dart';
import 'package:example/src/core/views/widgets/picker/elevation.dart';
import 'package:example/src/core/views/widgets/picker/toast_style.dart';
import 'package:example/src/core/views/widgets/toast_type_tab_bar.dart';
import 'package:example/src/core/views/widgets/toggle_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/widgets/content.dart';
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
          SizedBox(height: 24),
          TopBorderHolder(
            child: ToastTypeTabBar(
              onTypeChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeType(value);
              },
            ),
          ),
          MiddleBorderHolder(
            child: ToastStylePicker(
              type: ref.watch(toastDetailControllerProvider).type,
              initialStyle: ToastificationStyle.flat,
              onStyleChanged: (style) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeStyle(style);
              },
            ),
          ),
          const MiddleBorderHolder(child: _PositionHolder()),
          const MiddleBorderHolder(child: _ContentAndStyleHolder()),
          const BottomBorderHolder(
            child: _ControllersAndInteractionsHolder(),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class TitledSection extends StatelessWidget {
  const TitledSection({
    super.key,
    required this.title,
    required this.children,
  });

  TitledSection.single({
    super.key,
    required this.title,
    required Widget child,
  }) : children = [child];

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
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
    return TitledSection(
      title: 'Position',
      children: [
        ResponsiveRowColumn(
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          layout: context.responsiveValue(
            mobile: ResponsiveRowColumnType.COLUMN,
            tablet: ResponsiveRowColumnType.ROW,
            desktop: ResponsiveRowColumnType.ROW,
          ),
          children: [
            const ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              rowFlex: 10,
              child: _AlignmentSection(),
            ),
            ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              rowFlex: context.responsiveValue(
                tablet: 1,
                desktop: 3,
              ),
              child: SizedBox(height: 24),
            ),
            const ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              rowFlex: 7,
              child: _BorderSection(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _ElevationSection(),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _ContentAndStyleHolder extends StatelessWidget {
  const _ContentAndStyleHolder();
  @override
  Widget build(BuildContext context) {
    return const TitledSection(
      title: 'Content & Style',
      children: [
        _ContentSection(),
        SizedBox(height: 20),
        _StyleSection(),
      ],
    );
  }
}

class _ControllersAndInteractionsHolder extends StatelessWidget {
  const _ControllersAndInteractionsHolder();

  @override
  Widget build(BuildContext context) {
    return TitledSection(
      title: 'Controllers & Interaction',
      children: [
        const _SystemSection(),
        const SizedBox(height: 20),
        const _CloseSection(),
        const SizedBox(height: 20),
        const _ProgressBarSection(),
        const SizedBox(height: 20),
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
      ],
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

class _ContentSection extends StatelessWidget {
  const _ContentSection();

  @override
  Widget build(BuildContext context) {
    return SubSection(
      title: 'CONTENT',
      body: ContentWidget(),
    );
  }
}

class _StyleSection extends ConsumerWidget {
  const _StyleSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(
      toastDetailControllerProvider.select((value) => value.type),
    );
    final style = ref.watch(
      toastDetailControllerProvider.select((value) => value.style),
    );

    final builtInStyle = BuiltInStyle.fromToastificationStyle(style, type);

    Color primaryColor = ref.watch(toastDetailControllerProvider
            .select((value) => value.primaryColor)) ??
        builtInStyle.primaryColor(context);
    Color backgroundColor = ref.watch(toastDetailControllerProvider
            .select((value) => value.backgroundColor)) ??
        builtInStyle.backgroundColor(context);
    Color foregroundColor = ref.watch(toastDetailControllerProvider
            .select((value) => value.foregroundColor)) ??
        builtInStyle.foregroundColor(context);

    return SubSection(
      title: 'STYLE',
      action: _ResetButton(),
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
                child: CustomColorPicker(
                  title: 'Primary',
                  selectedColor: primaryColor,
                  onChanged: (value) {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changePrimary(value);
                  },
                ),
              ),
              ResponsiveRowColumnItem(
                rowFit: FlexFit.tight,
                columnFit: FlexFit.loose,
                child: CustomColorPicker(
                  title: 'Background',
                  selectedColor: backgroundColor,
                  onChanged: (value) {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeBackgroundColor(value);
                  },
                ),
              ),
              ResponsiveRowColumnItem(
                rowFit: FlexFit.tight,
                columnFit: FlexFit.loose,
                child: CustomColorPicker(
                  title: 'Foreground',
                  selectedColor: foregroundColor,
                  onChanged: (value) {
                    ref
                        .read(toastDetailControllerProvider.notifier)
                        .changeForegroundColor(value);
                  },
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

class _ResetButton extends ConsumerWidget {
  const _ResetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = ref.watch(
        toastDetailControllerProvider.select((value) => value.primaryColor));
    final backgroundColor = ref.watch(
        toastDetailControllerProvider.select((value) => value.backgroundColor));
    final foregroundColor = ref.watch(
        toastDetailControllerProvider.select((value) => value.foregroundColor));
    final isThereAnyColorSelected = primaryColor != null ||
        backgroundColor != null ||
        foregroundColor != null;

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      alignment: Alignment.centerRight,
      crossFadeState: isThereAnyColorSelected
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: OutlinedButton.icon(
        key: const ValueKey('reset'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: const Size.square(42),
        ),
        onPressed: () {
          ref.read(toastDetailControllerProvider.notifier).resetColors();
        },
        icon: const Icon(Iconsax.refresh_copy, size: 20),
        label: const Text('Reset'),
      ),
      secondChild: const SizedBox(key: ValueKey('reset-space')),
    );
  }
}

class _SystemSection extends ConsumerWidget {
  const _SystemSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final animationType = ref.watch(
      toastDetailControllerProvider.select((value) => value.animationType),
    );

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
              title: 'Use BuildContext - Recommended',
              value: ref.watch(toastDetailControllerProvider).useContext,
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeUseContext(value!);
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            columnFit: FlexFit.loose,
            child: BorderedDropDown<AnimationType?>(
              value: animationType,
              icon: const Icon(Iconsax.star_1_copy),
              hint: 'Animation type',
              items: AnimationType.types.map(
                (item) {
                  final isSelected = item == animationType;
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.1,
                              color: isSelected
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onPrimaryContainer,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: theme.colorScheme.primary,
                          ),
                      ],
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeAnimationType(value!);
              },
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
    final theme = Theme.of(context);

    final closeButtonShowType = ref.watch(
      toastDetailControllerProvider.select(
        (value) => value.closeButtonShowType,
      ),
    );

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
            child: BorderedDropDown<CloseButtonShowType>(
              value: closeButtonShowType,
              icon: const Icon(Icons.close_rounded, size: 18),
              hint: 'Close Button',
              items: CloseButtonShowType.values.map(
                (item) {
                  final isSelected = item == closeButtonShowType;
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.1,
                              color: isSelected
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onPrimaryContainer,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: theme.colorScheme.primary,
                          ),
                      ],
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                ref
                    .read(toastDetailControllerProvider.notifier)
                    .changeCloseButtonShowType(value!);
              },
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
