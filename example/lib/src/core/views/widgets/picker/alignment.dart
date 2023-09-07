import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

class AlignmentPicker extends StatelessWidget {
  const AlignmentPicker(
      {super.key, required this.selectedAlignment, this.onChanged});

  final AlignmentGeometry selectedAlignment;
  final ValueChanged<Alignment>? onChanged;

  @override
  Widget build(BuildContext context) {
    final selectedAlignment =
        this.selectedAlignment.resolve(Directionality.of(context));

    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  active: selectedAlignment == Alignment.topLeft,
                  onTap: () {
                    onChanged?.call(Alignment.topLeft);
                  },
                  child: selectedAlignment == Alignment.topLeft
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.topCenter,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.topCenter);
                  },
                  child: selectedAlignment == Alignment.topCenter
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.topRight,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.topRight);
                  },
                  child: selectedAlignment == Alignment.topRight
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.centerLeft);
                  },
                  child: selectedAlignment == Alignment.centerLeft
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.center);
                  },
                  child: selectedAlignment == Alignment.center
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.centerRight);
                  },
                  child: selectedAlignment == Alignment.centerRight
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.bottomLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.bottomLeft);
                  },
                  child: selectedAlignment == Alignment.bottomLeft
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.bottomCenter,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.bottomCenter);
                  },
                  child: selectedAlignment == Alignment.bottomCenter
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
              TableCell(
                child: BorderedContainer(
                  height: 41,
                  width: 100,
                  active: selectedAlignment == Alignment.bottomRight,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 4,
                  ),
                  onTap: () {
                    onChanged?.call(Alignment.bottomRight);
                  },
                  child: selectedAlignment == Alignment.bottomRight
                      ? const Icon(Icons.check)
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
