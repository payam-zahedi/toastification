import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';
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
                return GestureDetector(
                  onTap: _tooltipController.hide,
                  child: Container(
                    color: Colors.white10,
                    child: CompositedTransformFollower(
                      link: _link,
                      targetAnchor: Alignment.bottomLeft,
                      showWhenUnlinked: false,
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          width: 800,
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: theme.colorScheme.background,
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
                                padding:
                                    const EdgeInsetsDirectional.only(start: 4),
                                child: Text(
                                  'STYLE',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(.4),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ItemHolder(
                                      toast: FilledToastWidget(
                                        type: widget.type ??
                                            ToastificationType.info,
                                        title: 'The Title',
                                        description: 'The Description',
                                        closeIcon: Icons.run_circle,
                                      ),
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
                                      toast: FlatToastWidget(
                                        type: widget.type ??
                                            ToastificationType.info,
                                        title: 'The Title',
                                        closeIcon: Icons.run_circle,
                                        description: 'The Description',
                                      ),
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
                                      toast: FlatColoredToastWidget(
                                        type: widget.type ??
                                            ToastificationType.info,
                                        title: 'The Title',
                                        closeIcon: Icons.run_circle,
                                        description: 'The Description',
                                      ),
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
                                      toast: MinimalToastWidget(
                                        type: widget.type ??
                                            ToastificationType.info,
                                        title: 'The Title',
                                        closeIcon: Icons.run_circle,
                                        description: 'The Description',
                                      ),
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
                            ],
                          ),
                        ),
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
      ],
    );
  }

  void onTap() {
    _currentSize = context.size;

    _tooltipController.toggle();
  }
}

class _ItemHolder extends StatelessWidget {
  const _ItemHolder({
    required this.toast,
    required this.onTap,
  });

  final VoidCallback onTap;
  final Widget toast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 98,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: theme.colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 30,
            right: -40,
            child: toast,
          ),
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
