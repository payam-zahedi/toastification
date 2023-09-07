import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:example/src/core/views/widgets/soon.dart';
import 'package:example/src/core/views/widgets/toggle.dart';
import 'package:flutter/material.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({
    super.key,
    required this.title,
    required this.value,
    this.soon = false,
    required this.onChanged,
  });

  final String title;

  final bool value;

  final bool soon;

  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    /// a bordered container with a switch
    return BorderedContainer(
      active: value,
      onTap: !soon
          ? () {
              onChanged(!value);
            }
          : null,
      enabled: !soon,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      child: Row(
        children: [
          Text(title),
          if (soon)
            const Padding(
              padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: SoonWidget(),
            ),
          const Spacer(),
          RoundToggle(
            value: value,
            onChanged: !soon ? onChanged : null,
          ),
        ],
      ),
    );
  }
}
