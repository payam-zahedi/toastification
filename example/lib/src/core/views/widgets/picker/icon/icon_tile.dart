import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconTile extends ConsumerStatefulWidget {
  const IconTile({super.key, required this.item});
  final MapEntry<String, IconData> item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IconTileState();
}

class _IconTileState extends ConsumerState<IconTile> {
  bool hovered = false;

  void chooseIcon() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (event) => setState(() {
        hovered = true;
      }),
      onExit: (event) => setState(() {
        hovered = false;
      }),
      child: GestureDetector(
        onTap: chooseIcon,
        child: Theme(
          data: ThemeData(
            iconTheme: IconThemeData(
              opacity: hovered ? 1 : .5,
            ),
          ),
          child: Icon(
            widget.item.value,
            color: hovered
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
