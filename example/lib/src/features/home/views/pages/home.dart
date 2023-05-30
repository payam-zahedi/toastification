import 'package:example/src/features/home/views/widgets/app_bar.dart';
import 'package:example/src/features/home/views/widgets/customization_panel.dart';
import 'package:example/src/features/home/views/widgets/header.dart';
import 'package:example/src/features/home/views/widgets/preview_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final showHorizontalCustomizationSection = screenWidth > 1020;

    return DefaultStickyHeaderController(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: ToastAppBar()),
            const SliverPadding(
              padding: EdgeInsets.only(top: 100),
              sliver: SliverToBoxAdapter(child: ToastHeader()),
            ),
            if (showHorizontalCustomizationSection)
              const _HorizontalSection()
            else ...[
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 24),
                sliver: CustomizationPanel(),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 24),
                sliver: SliverToBoxAdapter(child: PreviewPanel()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HorizontalSection extends StatelessWidget {
  const _HorizontalSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final sideHeaderWidth = screenWidth * 0.36;
    final previewPanelPadding = screenWidth * 0.04;
    return SliverPadding(
      padding:
          EdgeInsets.symmetric(horizontal: previewPanelPadding, vertical: 64),
      sliver: SliverStickyHeader(
        overlapsContent: true,
        header: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: sideHeaderWidth,
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 16, 0, 16),
              child: PreviewPanel(),
            ),
          ),
        ),
        sliver: SliverPadding(
          padding: EdgeInsetsDirectional.only(end: sideHeaderWidth),
          sliver: const CustomizationPanel(),
        ),
      ),
    );
  }
}
