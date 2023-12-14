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
  final GlobalKey _menuKey = GlobalKey();

  void openPopup() {
    dynamic state = _menuKey.currentState;
    state.showButtonMenu();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton(
      key: _menuKey,
      tooltip: "",
      clipBehavior: Clip.hardEdge,
      position: PopupMenuPosition.under,
      elevation: 0,
      padding: EdgeInsets.zero,
      enabled: true,
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1.5,
        ),
      ),
      child: BorderedContainer(
        height: null,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        onTap: openPopup,
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
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: null,
          enabled: false,
          padding: EdgeInsets.zero,
          child: Center(
            child: ColorPicker(
              color: widget.selectedColor,
              hasBorder: true,
              width: 25,
              height: 25,
              heading: Text("Select the ${widget.title} Color"),
              showColorName: true,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: true,
              },
              wheelDiameter: 150,
              wheelWidth: 10,
              wheelSquarePadding: 20,
              padding: const EdgeInsets.all(20),
              colorCodeHasColor: true,
              showColorCode: true,
              onColorChanged: widget.onChanged ?? (value) {},
            ),
          ),
        )
      ],
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
