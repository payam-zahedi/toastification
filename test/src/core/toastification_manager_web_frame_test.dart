import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/toastification.dart';

/// Regression: `dismiss` used to remove the overlay entry from a timer set to
/// `animationDuration + removeOverlayDelay`. `AnimatedListState.removeItem`
/// disposes the item's animation controller in a `.then` MICROTASK once the
/// exit animation completes, and the list's `State.dispose` disposes every
/// in-flight controller too. When the tick completing the animation and the
/// build removing the overlay land in the same frame — the rule as soon as
/// frames stall (background tab, rendering hiccup) — the microtask runs after
/// the dispose on the web, because the web engine does not flush microtasks
/// between `onBeginFrame` and `onDrawFrame` (see the comment above
/// `invokeOnDrawFrame` in `web_ui/lib/src/engine/frame_service.dart`), and
/// the controller is disposed twice.
///
/// The test binding flushes microtasks between the two phases like the mobile
/// engine does, so the faulty frame is driven by hand here: `handleBeginFrame`
/// then `handleDrawFrame` in one task, microtasks flushed afterwards.
void main() {
  late ToastificationManager manager;
  late OverlayState overlayState;

  setUp(() {
    manager = ToastificationManager(
      alignment: Alignment.topRight,
      config: const ToastificationConfig(),
    );
  });

  Future<void> createOverlay(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              overlayState = Overlay.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  testWidgets(
      'dismiss: exit animation completing in the frame that removes the overlay '
      'must not dispose the item controller twice (web frame order)',
      (WidgetTester tester) async {
    await createOverlay(tester);
    const animationDuration = Duration(milliseconds: 100);

    final item = manager.showCustom(
      overlayState: overlayState,
      scheduler: tester.binding,
      builder: (context, item) => const Text('Test Toast'),
      animationBuilder: null,
      animationDuration: animationDuration,
      callbacks: const ToastificationCallbacks(),
    );
    await tester.pumpAndSettle();
    expect(find.text('Test Toast'), findsOneWidget);

    manager.dismiss(item);
    // First tick of the exit animation: fixes its origin.
    await tester.pump();
    expect(find.text('Test Toast'), findsOneWidget);

    // Frames stall while timers keep running: the old teardown timer fires
    // and the exit animation is past its duration without a single tick.
    await tester.binding
        .delayed(animationDuration + manager.removeOverlayDelay);

    // One web frame: begin + draw in the same task, THEN the microtasks.
    final binding = tester.binding;
    binding.handleBeginFrame(
      Duration(microseconds: binding.clock.now().microsecondsSinceEpoch),
    );
    binding.handleDrawFrame();
    // Flushes the microtasks: the framework's `.then` runs here. Before the
    // fix: "AnimationController.dispose() called more than once".
    await tester.pump();

    await tester.pump();
    expect(find.text('Test Toast'), findsNothing);
    expect(manager.overlayEntry, isNull);
    expect(manager.exitAnimations, isEmpty);
  });

  testWidgets(
      'dismissAll: the overlay waits for the LAST exit animation, not the first',
      (WidgetTester tester) async {
    await createOverlay(tester);

    for (var i = 0; i < 2; i++) {
      manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => Text('Toast $i'),
        animationBuilder: null,
        animationDuration: const Duration(milliseconds: 100),
        callbacks: const ToastificationCallbacks(),
      );
    }
    await tester.pumpAndSettle();

    // `dismissAll` dismisses toast 1 now and toast 0 150 ms later, so the
    // first exit completes while the second is still in flight. An exit
    // animation is done once STRICTLY past its duration, counted from its
    // first tick.
    manager.dismissAll();
    await tester.pump(const Duration(milliseconds: 100)); // t=100: first tick of toast 1
    await tester.pump(const Duration(milliseconds: 100)); // t=200: toast 0 dismissed at 150, its first tick
    await tester.pump(const Duration(milliseconds: 1)); // t=201: toast 1 done, toast 0 still exiting
    expect(manager.overlayEntry, isNotNull);
    expect(manager.exitAnimations.length, 1);

    await tester.pump(const Duration(milliseconds: 100)); // t=301: toast 0 done
    expect(manager.overlayEntry, isNull);
    expect(manager.exitAnimations, isEmpty);
  });
}
