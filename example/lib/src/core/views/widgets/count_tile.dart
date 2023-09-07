import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

class CountTile extends StatelessWidget {
  const CountTile({
    super.key,
    this.icon,
    required this.title,
    this.value,
    this.valueSuffix,
    this.minValue = 0.0,
    this.maxValue = 10.0,
    this.step = 0.5,
    this.onChanged,
  });

  final Widget? icon;
  final String title;
  final String? valueSuffix;

  final double? value;
  final double maxValue;
  final double minValue;

  /// value that will add to the current value when user clicks on plus button
  final double step;

  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    final value = this.value ?? minValue;

    final theme = Theme.of(context);
    return BorderedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            const SizedBox(width: 8),
            icon!,
          ],
          const SizedBox(width: 10),
          Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),

          /// a rich text that shows 0.15 s
          Text.rich(
            textAlign: TextAlign.end,
            maxLines: 1,
            TextSpan(
              children: [
                TextSpan(
                  text: value.toStringAsFixed(2),
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (valueSuffix != null)
                  TextSpan(
                    text: ' $valueSuffix',
                    style: DefaultTextStyle.of(context).style.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 19),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size.square(40),
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
            onPressed: () {
              if (value - step >= minValue) {
                onChanged?.call(value - step);
              }
            },
            child: const Icon(Icons.remove, size: 20),
          ),

          const SizedBox(width: 12),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(0),
              minimumSize: const Size.square(40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
            onPressed: () {
              if (value + step <= maxValue) {
                onChanged?.call(value + step);
              }
            },
            child: const Icon(Icons.add_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}
