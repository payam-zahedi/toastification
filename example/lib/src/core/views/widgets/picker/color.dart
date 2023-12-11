import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.title,
    required this.selectedColor,
    this.onChanged,
  });

  final String title;
  final Color selectedColor;
  final ValueChanged<Color>? onChanged;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  Size? _currentSize;

  void onTap() {
    _currentSize = context.size;

    _tooltipController.toggle();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CompositedTransformTarget(
      link: _link,
      child: BorderedContainer(
        height: null,
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
                    children: [
                      ColorPicker(
                        color: widget.selectedColor,
                        pickersEnabled: const <ColorPickerType, bool>{
                          ColorPickerType.both: false,
                          ColorPickerType.primary: false,
                          ColorPickerType.accent: false,
                          ColorPickerType.bw: false,
                          ColorPickerType.custom: false,
                          ColorPickerType.wheel: true,
                        },
                        wheelDiameter: 120,
                        wheelWidth: 10,
                        padding: EdgeInsets.zero,
                        colorCodeHasColor: true,
                        showColorCode: true,
                        onColorChanged: (Color value) {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: BorderedContainer(
            height: null,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.18,
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Material(
                                color: widget.selectedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: Colors.black.withOpacity(.05),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Text(
                                widget.selectedColor.hex,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension HexColor on Color {
  String get pureHex {
    return value.toRadixString(16).padLeft(8, '0').toUpperCase();
  }

  String get hexStr {
    final hexValue = pureHex;

    if (hexValue.startsWith('FF')) {
      return '#${hexValue.substring(2)}';
    }

    return hexValue;
  }
}
