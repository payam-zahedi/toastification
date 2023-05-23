import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

class BorderRadiusPicker extends StatelessWidget {
  const BorderRadiusPicker({
    super.key,
    required this.selectedBorderRadius,
    this.onChanged,
  });

  final BorderRadiusGeometry selectedBorderRadius;
  final ValueChanged<BorderRadiusGeometry>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BorderedContainer(
          active: selectedBorderRadius == BorderRadius.zero,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () {
            onChanged?.call(BorderRadius.zero);
          },
          child: const Row(
            children: [
              Expanded(
                child: Text('Sharp'),
              ),
              Icon(Icons.check),
            ],
          ),
        ),
        BorderedContainer(
          active: selectedBorderRadius == BorderRadius.circular(10),
          height: 48,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () {
            onChanged?.call(BorderRadius.circular(10));
          },
          child: const Row(
            children: [
              Expanded(
                child: Text('Curved'),
              ),
              Icon(Icons.roundabout_left),
            ],
          ),
        ),
        BorderedContainer(
          active: selectedBorderRadius == BorderRadius.circular(25),
          height: 48,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () {
            onChanged?.call(BorderRadius.circular(25));
          },
          child: const Row(
            children: [
              Expanded(
                child: Text('Round'),
              ),
              Icon(Icons.circle_outlined),
            ],
          ),
        ),
      ],
    );
  }
}
