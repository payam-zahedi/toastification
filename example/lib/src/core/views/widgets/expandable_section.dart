import 'package:example/src/core/views/widgets/expandable_widget.dart';
import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  const ExpandableSection({
    super.key,
    required this.title,
    required this.body,
    this.isExpandedInitially = true,
  });

  final String title;

  final Widget body;

  final bool isExpandedInitially;

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _customTileExpanded;

  @override
  void initState() {
    super.initState();

    _customTileExpanded = widget.isExpandedInitially;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = Padding(
      padding: const EdgeInsetsDirectional.only(start: 2),
      child: Text(
        widget.title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return ExpandableWidget(
      headerBuilder: (context, isExpanded) {
        return header;
      },
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              VerticalDivider(
                color: theme.colorScheme.outline,
                thickness: 1,
                width: 42,
              ),
              Expanded(child: widget.body),
            ],
          ),
        ),
      ),
      isExpanded: _customTileExpanded,
      expansionCallback: (isExpanded) {
        setState(() {
          _customTileExpanded = !isExpanded;
        });
      },
    );
  }
}

class SubSection extends StatelessWidget {
  const SubSection({
    super.key,
    required this.title,
    required this.body,
    this.action,
  });

  final String title;
  final Widget body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget titleSection = Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.onSurface.withOpacity(.4),
      ),
    );

    if (action != null) {
      titleSection = Row(
        children: [
          Expanded(child: titleSection),
          action!,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: titleSection,
        ),
        body,
      ],
    );
  }
}
