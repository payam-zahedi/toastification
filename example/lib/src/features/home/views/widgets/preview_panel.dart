import 'package:example/src/core/views/widgets/bordered_container.dart';
import 'package:flutter/material.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BorderedContainer(
          active: true,
          height: 200,
          child: Text('Toast Preview'),
        ),
        SizedBox(height: 16),
        BorderedContainer(
          height: 500,
          child: Text('Code Preview'),
        ),
      ],
    );
  }
}
