import 'package:example/src/core/views/widgets/expandable_widget.dart';
import 'package:example/src/core/views/widgets/tab_bar.dart';
import 'package:flutter/material.dart';

class CustomizationPanel extends StatelessWidget {
  const CustomizationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const titleColor = Color(0xff1C1B28);

    return SizedBox(
      width: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Customize your toast!',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                  height: 1,
                ),
              ),
              Text(
                ' Let’s make it easy!',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: titleColor.withOpacity(.4),
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ToastTypeTabBar(),
          const PositionSection(),
        ],
      ),
    );
  }
}

class PositionSection extends StatefulWidget {
  const PositionSection({super.key});

  @override
  State<PositionSection> createState() => _PositionSectionState();
}

class _PositionSectionState extends State<PositionSection> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpandableWidget(
      headerBuilder: (context, isExpanded) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 2),
          child: Text(
            'Position',
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


