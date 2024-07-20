import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
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
    ref.read(toastDetailControllerProvider.notifier).changeIcon(
          IconModel(
            name: widget.item.key,
            iconData: widget.item.value,
          ),
        );
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
            iconTheme: const IconThemeData(
              opacity: 1,
            ),
          ),
          child: Icon(
            widget.item.value,
            color: hovered
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
