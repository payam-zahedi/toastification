import 'package:flutter/material.dart';

typedef OnHoverBuilder = Widget Function(BuildContext context, bool showWidget);

class OnHoverShow extends StatefulWidget {
  const OnHoverShow({
    super.key,
    this.enabled = true,
    required this.childBuilder,
  });

  final bool enabled;

  final OnHoverBuilder childBuilder;

  @override
  State<OnHoverShow> createState() => _OnHoverShowState();
}

class _OnHoverShowState extends State<OnHoverShow> {
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.childBuilder(context, true);
    }

    return MouseRegion(
      onEnter: (event) {
        setState(() {
          showWidget = true;
        });
      },
      onExit: (event) {
        setState(() {
          showWidget = false;
        });
      },
      child: widget.childBuilder(context, showWidget),
    );
  }
}
