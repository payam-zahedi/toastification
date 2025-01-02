import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/expandable_section.dart';
import 'package:example/src/core/views/widgets/toggle_tile.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

class ToastStylePicker extends StatefulWidget {
  const ToastStylePicker({
    super.key,
    this.type,
    required this.initialStyle,
    required this.onStyleChanged,
  });

  final ToastificationType? type;
  final ToastificationStyle initialStyle;

  final ValueChanged<ToastificationStyle> onStyleChanged;

  @override
  State<StatefulWidget> createState() => ToastStylePickerState();
}

class ToastStylePickerState extends State<ToastStylePicker> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  Size? _currentSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4.0),
          child: Text(
            'Toast style',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 14),
        CompositedTransformTarget(
          link: _link,
          child: BorderedContainer(
            onTap: onTap,
            child: OverlayPortal(
              controller: _tooltipController,
              overlayChildBuilder: (BuildContext context) {
                return CompositedTransformFollower(
                  link: _link,
                  targetAnchor: Alignment.bottomLeft,
                  showWhenUnlinked: false,
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      width: _currentSize?.width ?? 200,
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.5,
                            color: theme.colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x11000000),
                            blurRadius: 32,
                            offset: Offset(0, 20),
                            spreadRadius: -8,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 4),
                            child: Text(
                              'STYLE',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: .4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _ItemHolder(
                                  style: ToastificationStyle.fillColored,
                                  onTap: () {
                                    widget.onStyleChanged(
                                      ToastificationStyle.fillColored,
                                    );
                                    _tooltipController.hide();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ItemHolder(
                                  style: ToastificationStyle.flat,
                                  onTap: () {
                                    widget.onStyleChanged(
                                      ToastificationStyle.flat,
                                    );
                                    _tooltipController.hide();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _ItemHolder(
                                  style: ToastificationStyle.flatColored,
                                  onTap: () {
                                    widget.onStyleChanged(
                                      ToastificationStyle.flatColored,
                                    );
                                    _tooltipController.hide();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ItemHolder(
                                  style: ToastificationStyle.minimal,
                                  onTap: () {
                                    widget.onStyleChanged(
                                      ToastificationStyle.minimal,
                                    );
                                    _tooltipController.hide();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _ItemHolder(
                                  isCenter: true,
                                  style: ToastificationStyle.simple,
                                  onTap: () {
                                    widget.onStyleChanged(
                                      ToastificationStyle.simple,
                                    );
                                    _tooltipController.hide();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Style'),
                    // drop down icon
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),
        ),
        const _ApplyBlurEffectSection(),
      ],
    );
  }

  void onTap() {
    _currentSize = context.size;

    _tooltipController.toggle();
  }
}

class _ApplyBlurEffectSection extends ConsumerWidget {
  const _ApplyBlurEffectSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubSection(
      title: 'BLUR',
      body: ToggleTile(
        title: 'Apply blur effect',
        value: ref.watch(toastDetailControllerProvider).applyBlurEffect,
        onChanged: (value) {
          ref
              .read(toastDetailControllerProvider.notifier)
              .changeApplyBlurEffect(value!);
        },
      ),
    );
  }
}

class _ItemHolder extends ConsumerWidget {
  const _ItemHolder({
    this.isCenter = false,
    required this.onTap,
    required this.style,
  });

  final bool isCenter;
  final VoidCallback onTap;
  final ToastificationStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final toastDetail = ref.watch(toastDetailControllerProvider);

    final toastWidget = StandardToastWidgetFactory.createStandardToastWidget(
      style: style.toStandard,
      title: const Text('The Provided Title'),
      description: const Text('The Provided Description'),
      onCloseTap: () {},
    );

    // TODO: check if we can make ToastificationTheme private
    Widget child = ToastificationTheme(
      themeData: ToastificationThemeData(
        toastStyle: StandardToastStyleFactory.createStyle(
          style: style.toStandard,
          type: toastDetail.type,
          flutterTheme: theme,
        ),
        flutterTheme: theme,
        direction: TextDirection.ltr,
      ),
      child: toastWidget,
    );

    if (isCenter) {
      child = Center(
        child: child,
      );
    } else {
      child = Positioned(
        top: 12,
        left: 30,
        right: -40,
        child: child,
      );
    }
    return SizedBox(
      height: 98,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: theme.colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child,
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
