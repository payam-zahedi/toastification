import 'dart:math';

import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/core/views/widgets/bottom_navigation.dart';
import 'package:example/src/features/home/views/widgets/app_bar/app_bar.dart';
import 'package:example/src/features/home/views/widgets/customization_panel.dart';
import 'package:example/src/features/home/views/widgets/header.dart';
import 'package:example/src/features/home/views/widgets/image.dart';
import 'package:example/src/features/home/views/widgets/preview_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getImages() {
    precacheImage(headerImage, context);
    precacheImage(logoImage, context);
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationConfigProvider(
      config: ToastificationConfig(
        marginBuilder: (alignment) => const EdgeInsets.fromLTRB(0, 16, 0, 110),
      ),
      child: const Scrollbar(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNavigationView(),
          body: CustomScrollView(
            primary: true,
            slivers: [
              ToastAppBar(),
              SliverToBoxAdapter(child: ToastHeader()),
              CustomizationSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomizationSection extends StatelessWidget {
  const CustomizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isInDesktopZone) {
      return const _HorizontalSection();
    }

    return const _VerticalSection();
  }
}

class _HorizontalSection extends StatelessWidget {
  const _HorizontalSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sideHeaderWidth = context.isUltra ? 430.0 : 380.0;
    const previewPanelPadding = 16.0;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        previewPanelPadding,
        64,
        previewPanelPadding,
        96,
      ),
      sliver: SliverStickyHeader(
        overlapsContent: true,
        header: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: sideHeaderWidth,
            height: MediaQuery.sizeOf(context).height - 64,
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 16, 0, 16),
              child: PreviewPanel(expanded: true),
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

class _VerticalSection extends StatelessWidget {
  const _VerticalSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const widgetMaxSize = 600;
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: max((screenWidth - widgetMaxSize) / 2, 8),
      ),
      sliver: SliverStickyHeader(
        header: const PreviewPanel(),
        sliver: const SliverPadding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 8),
          sliver: CustomizationPanel(),
        ),
      ),
    );
  }
}
