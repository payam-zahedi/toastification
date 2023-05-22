import 'package:flutter/material.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.yellow,
          width: 100,
          height: 200,
        );
      },
    );
  }
}
