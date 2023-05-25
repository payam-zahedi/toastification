
import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/toggle.dart';
import 'package:flutter/material.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;

  final bool value;

  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    /// a bordered container with a switch
    return BorderedContainer(
      active: value,
      onTap: () {
        onChanged(!value);
      },
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          RoundToggle(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}