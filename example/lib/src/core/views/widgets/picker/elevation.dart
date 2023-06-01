import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

class ElevationPicker extends StatelessWidget {
  const ElevationPicker({
    super.key,
    required this.selectedElevation,
    this.onChanged,
  });

  final double selectedElevation;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    /// Three elevation levels are supported: 0, 5, and 10.
    return Row(
      children: [
        Expanded(
          child: BorderedContainer(
            height: 48,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              onChanged?.call(0);
            },
            active: selectedElevation == 0,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sharp',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Offstage(
                  offstage: selectedElevation != 0,
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BorderedContainer(
            height: 48,
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              onChanged?.call(5);
            },
            active: selectedElevation == 5,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Low mode shadow',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Offstage(
                  offstage: selectedElevation != 5,
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BorderedContainer(
            height: 48,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              onChanged?.call(10);
            },
            active: selectedElevation == 10,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'High mode shadow',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Offstage(
                  offstage: selectedElevation != 10,
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
