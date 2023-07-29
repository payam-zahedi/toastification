import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:example/src/features/home/controllers/toast_detail.dart';
import 'package:example/src/features/home/views/ui_states/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationViewState();
}

class _BottomNavigationViewState extends ConsumerState<BottomNavigationView>
    with SingleTickerProviderStateMixin {
  ScrollNotificationObserverState? _scrollNotificationObserver;

  late final AnimationController controller;
  late final Animation<Offset> animation;
  bool show = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }

    controller.dispose();
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    /// depth 0 is for root scroll child
    if (notification is ScrollUpdateNotification && notification.depth < 1) {
      final ScrollMetrics metrics = notification.metrics;

      const threshold = 64.0;
      bool slideIn = show;

      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          slideIn = metrics.extentAfter > threshold;
        case AxisDirection.down:
          slideIn = metrics.extentBefore > threshold;
        case AxisDirection.right:
        case AxisDirection.left:
          break;
      }

      if (slideIn != show) {
        show = slideIn;
        if (show) {
          controller.forward();
        } else {
          controller.reverse();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const size = Size.square(48);

    final edgeInsets = context.responsiveValue(
      desktop: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      tablet: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );

    final containerPadding = context.responsiveValue(
      desktop: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      tablet: const EdgeInsets.all(12),
      mobile: const EdgeInsets.all(12),
    );

    final previewButton = context.responsiveValue(
      desktop: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: edgeInsets,
          minimumSize: size,
        ),
        onPressed: () {
          final toastDetail = ref.read(toastDetailControllerProvider);

          showCurrentToast(context, toastDetail);
        },
        icon: const Icon(Iconsax.monitor_copy, size: 20),
        label: const Text('Preview on Screen'),
      ),
      tablet: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: size,
        ),
        onPressed: () {
          final toastDetail = ref.read(toastDetailControllerProvider);

          showCurrentToast(context, toastDetail);
        },
        child: const Icon(Iconsax.mobile_copy, size: 20),
      ),
    );

    final saveToastButton = context.responsiveValue(
      desktop: TextButton.icon(
        style: TextButton.styleFrom(
          padding: edgeInsets,
          minimumSize: size,
        ),
        onPressed: () {},
        label: const Text('Save My Toast'),
        icon: const Icon(Iconsax.save_add_copy, size: 20),
      ),
      tablet: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: size,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
        ),
        onPressed: () {},
        child: const Icon(Iconsax.save_add_copy, size: 20),
      ),
    );

    final copyCodeButton = context.responsiveValue(
      desktop: FilledButton.icon(
        style: FilledButton.styleFrom(
          padding: edgeInsets,
          minimumSize: size,
        ),
        onPressed: () {
          copyCode(context, ref.read(toastDetailControllerProvider));
        },
        label: const Text('Copy Code'),
        icon: const Icon(Iconsax.document_copy_copy, size: 20),
      ),
      tablet: FilledButton(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: size,
        ),
        onPressed: () {
          copyCode(context, ref.read(toastDetailControllerProvider));
        },
        child: const Icon(Iconsax.document_copy_copy, size: 20),
      ),
    );

    return SlideTransition(
      position: animation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 32),
          padding: containerPadding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(.15)),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withOpacity(.1),
                blurRadius: 48,
                offset: const Offset(0, 24),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              previewButton,
              const SizedBox(width: 16),
              saveToastButton,
              const SizedBox(width: 16),
              copyCodeButton,
            ],
          ),
        ),
      ),
    );
  }
}
