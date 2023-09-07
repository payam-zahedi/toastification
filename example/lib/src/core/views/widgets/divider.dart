import 'package:flutter/material.dart';

class FlexDivider extends StatelessWidget {
  const FlexDivider({
    super.key,
    required this.axis,
    this.thickness = 5,
  });

  final Axis axis;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEBEBEE),
        borderRadius: BorderRadius.circular(5),
      ),
      width: axis == Axis.horizontal ? thickness : 200,
      height: axis == Axis.horizontal ? 200 : thickness,
    );
  }
}
