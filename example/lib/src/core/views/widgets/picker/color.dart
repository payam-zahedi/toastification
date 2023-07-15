import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.title,
    required this.selectedColor,
    this.onChanged,
  });

  final String title;
  final Color selectedColor;
  final ValueChanged<Color>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BorderedContainer(
      height: null,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      onTap: () {
        // TODO(payam): add dialog picker
      },
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
                          title,
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
                          color: selectedColor,
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
                          selectedColor.hex,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.18,
                          ),
                        ),
                      ),
                      const SoonWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension HexColor on Color {
  String get pureHex {
    return value.toRadixString(16).padLeft(8, '0').toUpperCase();
  }

  String get hex {
    final hexValue = pureHex;

    if (hexValue.startsWith('FF')) {
      return '#${hexValue.substring(2)}';
    }

    return hexValue;
  }
}
