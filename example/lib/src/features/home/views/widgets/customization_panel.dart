import 'package:example/src/core/views/widgets/expandable_section.dart';
import 'package:example/src/core/views/widgets/picker/alignment.dart';
import 'package:example/src/core/views/widgets/picker/border_radius.dart';
import 'package:example/src/core/views/widgets/picker/elevation.dart';
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
  AlignmentGeometry _selectedAlignment = Alignment.topRight;
  BorderRadiusGeometry _selectedBorderRadius = BorderRadius.zero;
  double _selectedElevation = 0;

  @override
  Widget build(BuildContext context) {
    return ExpandableSection(
      title: "Position",
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 10,
                child: SubSection(
                  title: 'PLACEMENT',
                  body: AlignmentPicker(
                    selectedAlignment: _selectedAlignment,
                    onChanged: (alignment) {
                      setState(() {
                        _selectedAlignment = alignment;
                      });
                    },
                  ),
                ),
              ),
              //  TODO(payam): make it responsive
              const Spacer(flex: 3),
              Expanded(
                flex: 7,
                child: SubSection(
                  title: 'BORDER',
                  body: BorderRadiusPicker(
                    selectedBorderRadius: _selectedBorderRadius,
                    onChanged: (borderRadius) {
                      setState(() {
                        _selectedBorderRadius = borderRadius;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          SubSection(
            title: 'BORDER',
            body: ElevationPicker(
              selectedElevation: _selectedElevation,
              onChanged: (elevation) {
                setState(() {
                  _selectedElevation = elevation;
                });
              },
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
