import 'package:example/src/core/views/widgets/divider.dart';
import 'package:example/src/features/home/views/widgets/app_bar.dart';
import 'package:example/src/features/home/views/widgets/customization_panel.dart';
import 'package:example/src/features/home/views/widgets/preview_panel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ToastAppBar()),
        ],
      ),
    );
  }
}

