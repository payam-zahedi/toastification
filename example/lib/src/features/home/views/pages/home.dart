import 'package:example/src/core/views/widgets/divider.dart';
import 'package:example/src/features/home/views/widgets/app_bar.dart';
import 'package:example/src/features/home/views/widgets/customization_panel.dart';
import 'package:example/src/features/home/views/widgets/header.dart';
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
          SliverPadding(
            padding: EdgeInsets.only(top: 100),
            sliver: SliverToBoxAdapter(child: ToastHeader()),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 64, bottom: 64),
            sliver: SliverToBoxAdapter(child: ToastCustomizationSection()),
          ),
        ],
      ),
    );
  }
}

class ToastCustomizationSection extends StatelessWidget {
  const ToastCustomizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    const customizationPanel = CustomizationPanel();
    const previewPanel = PreviewPanel();

    return LayoutBuilder(
      builder: (context, constraints) {
        final axis =
            constraints.maxWidth > 1300 ? Axis.horizontal : Axis.vertical;

        final isHorizontal = axis == Axis.horizontal;
        final flex = isHorizontal ? FlexFit.tight : FlexFit.loose;

        final padding = constraints.maxWidth / 12;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Flex(
            direction: axis,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: isHorizontal
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                fit: flex,
                child: customizationPanel,
              ),
              const SizedBox(width: 65, height: 16),
              FlexDivider(axis: axis),
              const SizedBox(width: 30, height: 16),
              Flexible(
                flex: 5,
                fit: flex,
                child: previewPanel,
              ),
            ],
          ),
        );
      },
    );
  }
}
