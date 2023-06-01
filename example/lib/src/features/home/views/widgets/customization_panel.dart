import 'package:example/src/core/usecase/extension/responsive.dart';
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/count_tile.dart';
import 'package:example/src/core/views/widgets/drop_down.dart';
import 'package:example/src/core/views/widgets/expandable_section.dart';
import 'package:example/src/core/views/widgets/picker/alignment.dart';
import 'package:example/src/core/views/widgets/picker/border_radius.dart';
import 'package:example/src/core/views/widgets/picker/color.dart';
import 'package:example/src/core/views/widgets/picker/elevation.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/core/views/widgets/tab_bar.dart';
import 'package:example/src/core/views/widgets/toggle_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          const _PositionSection(),
          const _ContentAndStyleSection(),
          const _ControllersAndInteractions(),
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

class _PositionSection extends StatelessWidget {
  const _PositionSection();
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
                //  TODO(payam): make it responsive
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
    return SubSection(
      title: 'SHADOW',
      body: ElevationPicker(
        selectedElevation: ref.watch(toastDetailControllerProvider).elevation,
        onChanged: (elevation) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changeElevation(elevation);
        },
      ),
    );
  }
}

class _ContentAndStyleSection extends StatefulWidget {
  const _ContentAndStyleSection();

  @override
  State<_ContentAndStyleSection> createState() =>
      _ContentAndStyleSectionState();
}

class _ContentAndStyleSectionState extends State<_ContentAndStyleSection> {
  TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableSection(
        title: 'Content & Style',
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubSection(
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
                            BorderedContainer(
                              width: 48,
                              height: 48,
                              child: const Icon(Icons.info_outline_rounded),
                              onTap: () {},
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Type the title text here..',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          height: 106,
                          child: TextField(
                            expands: true,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: 'Type the body text here..',
                            ),
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
                            setState(() {
                              _textDirection = TextDirection.ltr;
                            });
                          },
                          active: _textDirection == TextDirection.ltr,
                          child: Row(
                            children: [
                              const Expanded(child: Text('LTR layout')),
                              Offstage(
                                offstage: _textDirection != TextDirection.ltr,
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
                            setState(() {
                              _textDirection = TextDirection.rtl;
                            });
                          },
                          active: _textDirection == TextDirection.rtl,
                          child: Row(
                            children: [
                              const Expanded(child: Text('RTL layout')),
                              Offstage(
                                offstage: _textDirection != TextDirection.rtl,
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
            ),
            SubSection(
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
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _ControllersAndInteractions extends StatefulWidget {
  const _ControllersAndInteractions();

  @override
  State<_ControllersAndInteractions> createState() =>
      _ControllersAndInteractionsState();
}

class _ControllersAndInteractionsState
    extends State<_ControllersAndInteractions> {
  String? _animationType;
  String? _closeType;

  bool _newOnTop = true;
  bool _closeOnClick = true;
  bool _dragToClose = false;
  bool _pauseOnHover = true;
  bool _showProgressBar = true;

  double _timeout = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableSection(
        title: 'Controllers & Interaction',
        body: Column(
          children: [
            SubSection(
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
                      value: _newOnTop,
                      onChanged: (value) {
                        setState(() {
                          _newOnTop = value!;
                        });
                      },
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.tight,
                    columnFit: FlexFit.loose,
                    child: BorderedDropDown<String>(
                      icon: const Icon(Icons.star_outline_rounded),
                      hint: 'Animation type',
                      value: _animationType,
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
                      onChanged: (value) {
                        setState(() {
                          _animationType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SubSection(
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
                      value: _closeOnClick,
                      onChanged: (value) {
                        setState(() {
                          _closeOnClick = value!;
                        });
                      },
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.tight,
                    columnFit: FlexFit.loose,
                    child: BorderedDropDown<String>(
                      icon: const Icon(Icons.close_rounded, size: 18),
                      hint: 'Choose close button type',
                      value: _closeType,
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
                      onChanged: (value) {
                        setState(() {
                          _closeType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SubSection(
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
                      value: _showProgressBar,
                      onChanged: (value) {
                        setState(() {
                          _showProgressBar = value!;
                        });
                      },
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.tight,
                    columnFit: FlexFit.loose,
                    child: CountTile(
                      title: 'Timeout',
                      icon: Icon(
                        Icons.timer_outlined,
                        color: theme.colorScheme.onSurface.withOpacity(.2),
                      ),
                      value: _timeout,
                      valueSuffix: 's',
                      onChanged: (value) {
                        setState(() {
                          _timeout = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ResponsiveRowColumn(
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
                  child: SubSection(
                    title: 'PAUSE',
                    body: ToggleTile(
                      title: 'Pause on hover',
                      value: _pauseOnHover,
                      onChanged: (value) {
                        setState(() {
                          _pauseOnHover = value!;
                        });
                      },
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFit: FlexFit.tight,
                  columnFit: FlexFit.loose,
                  child: SubSection(
                    title: 'DRAG',
                    body: ToggleTile(
                      title: 'Drag to close',
                      value: _dragToClose,
                      onChanged: (value) {
                        setState(() {
                          _dragToClose = value!;
                        });
                      },
                    ),
                  ),
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
