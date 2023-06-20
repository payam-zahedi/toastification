import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

final borderRadiusValues = {
  'Sharp': BorderRadius.circular(4),
  'Curved': BorderRadius.circular(12),
  'Round': BorderRadius.circular(100),
};

class BorderRadiusPicker extends StatelessWidget {
  const BorderRadiusPicker({
    super.key,
    this.selectedBorderRadius,
    this.onChanged,
  });

  final BorderRadiusGeometry? selectedBorderRadius;
  final ValueChanged<BorderRadiusGeometry>? onChanged;

  @override
  Widget build(BuildContext context) {
    final selectedBorderRadius =
        this.selectedBorderRadius ?? BorderRadius.circular(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: borderRadiusValues.entries.map((e) {
        final name = e.key;
        final value = e.value;

        final topPadding = name == borderRadiusValues.keys.first ? 0.0 : 10.0;

        return BorderedContainer(
          active: selectedBorderRadius == value,
          height: 48,
          margin: EdgeInsets.only(top: topPadding),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () {
            onChanged?.call(value);
          },
          child: Row(
            children: [
              Expanded(
                child: Text(name),
              ),
              if (selectedBorderRadius == value) const Icon(Icons.check),
            ],
          ),
        );
      }).toList(),
    );
  }
}
