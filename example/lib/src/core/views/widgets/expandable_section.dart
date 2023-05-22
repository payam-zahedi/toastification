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

    return ExpandableWidget(
      headerBuilder: (context, isExpanded) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 2),
          child: Text(
            widget.title,
            style: theme.textTheme.titleMedium,
          ),
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              VerticalDivider(
                color: theme.colorScheme.onBackground.withOpacity(.06),
                thickness: 1,
                width: 42,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.black12,
                ),
              ),
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
