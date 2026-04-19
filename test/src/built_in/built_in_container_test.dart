import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/built_in/widget/built_in_container.dart';
import 'package:toastification/toastification.dart';

/// Creates a [ToastificationItem] for testing purposes (no timer).
ToastificationItem createTestSampleItem() {
  return ToastificationItem(
    builder: (context, item) => const SizedBox(),
    alignment: Alignment.topRight,
  );
}

/// Creates a [ToastificationItem] with a timer for testing pause/start.
ToastificationItem createTestItemWithTimer() {
  return ToastificationItem(
    builder: (context, item) => const SizedBox(),
    alignment: Alignment.topRight,
    autoCloseDuration: const Duration(seconds: 10),
  );
}

const _childKey = Key('test-child');

/// Wraps a [BuiltInContainer] directly in a minimal widget tree for testing.
/// Uses a [ColoredBox] child so the widget is hit-testable.
Widget buildContainerTestApp({
  required ToastificationItem item,
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  bool closeOnClick = false,
  bool pauseOnHover = false,
  bool dragToClose = false,
  DismissDirection? dismissDirection,
  ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  MouseCursor? onHoverMouseCursor,
}) {
  return MaterialApp(
    home: Scaffold(
      body: BuiltInContainer(
        item: item,
        margin: margin,
        closeOnClick: closeOnClick,
        pauseOnHover: pauseOnHover,
        dragToClose: dragToClose,
        dismissDirection: dismissDirection,
        callbacks: callbacks,
        onHoverMouseCursor: onHoverMouseCursor,
        child: const ColoredBox(
          key: _childKey,
          color: Colors.blue,
          child: SizedBox(width: 200, height: 50),
        ),
      ),
    ),
  );
}

void main() {
  group('BuiltInContainer - margin', () {
    testWidgets('wraps child in Padding with the provided margin',
        (tester) async {
      final item = createTestSampleItem();
      const margin = EdgeInsets.all(16);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        margin: margin,
      ));

      final paddingFinder = find.ancestor(
        of: find.byKey(_childKey),
        matching: find.byType(Padding),
      );
      expect(paddingFinder, findsOneWidget);

      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, margin);
    });
  });

  group('BuiltInContainer - pauseOnHover', () {
    testWidgets(
        'adds MouseRegion that pauses/starts timer when pauseOnHover is true and item has timer',
        (tester) async {
      final item = createTestItemWithTimer();

      expect(item.hasTimer, isTrue);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        pauseOnHover: true,
      ));

      // Find the MouseRegion used for pause-on-hover (not the one with
      // BuiltInContainerKeys.mouseRegion key — that's the cursor one).
      // The pause-on-hover MouseRegion wraps the Padding.
      final mouseRegions = tester.widgetList<MouseRegion>(
        find.ancestor(
          of: find.byType(Padding),
          matching: find.byType(MouseRegion),
        ),
      );
      expect(mouseRegions, isNotEmpty);

      // Verify the item is currently started (timer auto-starts)
      expect(item.timeStatus, ToastTimeStatus.started);

      // Simulate mouse enter
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.byKey(_childKey)));
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.paused);

      // Simulate mouse exit
      await gesture.moveTo(const Offset(-100, -100));
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.started);

      // PausableTimer holds a real Timer internally — must stop it
      // before the test ends to avoid the pending timer assertion.
      item.stop();
    });

    testWidgets(
        'does not add pause-on-hover MouseRegion when pauseOnHover is true but item has no timer',
        (tester) async {
      final item = createTestSampleItem();
      expect(item.hasTimer, isFalse);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        pauseOnHover: true,
      ));

      // Only the GestureDetector should wrap the Padding -- no extra
      // MouseRegion for pause-on-hover since there's no timer.
      final mouseRegionFinder = find.ancestor(
        of: find.byType(Padding),
        matching: find.byType(MouseRegion),
      );
      expect(mouseRegionFinder, findsNothing);
    });

    testWidgets(
        'does not add pause-on-hover MouseRegion when pauseOnHover is false',
        (tester) async {
      final item = createTestItemWithTimer();
      expect(item.hasTimer, isTrue);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        pauseOnHover: false,
      ));

      // No MouseRegion for pause-on-hover when disabled.
      final mouseRegionFinder = find.ancestor(
        of: find.byType(Padding),
        matching: find.byType(MouseRegion),
      );
      expect(mouseRegionFinder, findsNothing);

      // PausableTimer holds a real Timer internally — must stop it
      // before the test ends to avoid the pending timer assertion.
      item.stop();
    });
  });

  group('BuiltInContainer - GestureDetector / onTap', () {
    testWidgets('tapping calls callbacks.onTap with the correct item',
        (tester) async {
      final item = createTestSampleItem();
      ToastificationItem? tappedItem;

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        callbacks: ToastificationCallbacks(
          onTap: (i) => tappedItem = i,
        ),
      ));

      await tester.tap(find.byKey(_childKey));
      await tester.pump();

      expect(tappedItem, item);
    });

    testWidgets(
        'does not add GestureDetector when closeOnClick is false and onTap is null',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(item: item));

      final gestureDetectorFinder = find.ancestor(
        of: find.byKey(_childKey),
        matching: find.byType(GestureDetector),
      );
      expect(gestureDetectorFinder, findsNothing);
    });

    testWidgets('adds GestureDetector when closeOnClick is true',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        closeOnClick: true,
      ));

      final gestureDetectorFinder = find.ancestor(
        of: find.byKey(_childKey),
        matching: find.byType(GestureDetector),
      );
      expect(gestureDetectorFinder, findsOneWidget);
    });
  });

  group('BuiltInContainer - onHoverMouseCursor', () {
    testWidgets(
        'does not add keyed MouseRegion when onHoverMouseCursor is null',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(item: item));

      expect(find.byKey(BuiltInContainerKeys.mouseRegion), findsNothing);
    });

    testWidgets(
        'adds MouseRegion with correct cursor when onHoverMouseCursor is provided',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        onHoverMouseCursor: SystemMouseCursors.click,
      ));

      final mouseRegionFinder = find.byKey(BuiltInContainerKeys.mouseRegion);
      expect(mouseRegionFinder, findsOneWidget);

      final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder);
      expect(mouseRegion.cursor, SystemMouseCursors.click);
    });

    testWidgets('supports custom mouse cursors', (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        onHoverMouseCursor: SystemMouseCursors.grab,
      ));

      final mouseRegionFinder = find.byKey(BuiltInContainerKeys.mouseRegion);
      expect(mouseRegionFinder, findsOneWidget);

      final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder);
      expect(mouseRegion.cursor, SystemMouseCursors.grab);
    });
  });

  group('BuiltInContainer - dragToClose', () {
    testWidgets('adds Dismissible when dragToClose is true', (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
      ));

      expect(find.byType(Dismissible), findsOneWidget);
    });

    testWidgets('does not add Dismissible when dragToClose is false',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: false,
      ));

      expect(find.byType(Dismissible), findsNothing);
    });

    testWidgets('uses horizontal dismiss direction by default', (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
      ));

      final dismissible = tester.widget<Dismissible>(
        find.byType(Dismissible),
      );
      expect(dismissible.direction, DismissDirection.horizontal);
    });

    testWidgets('uses custom dismissDirection when provided', (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
        dismissDirection: DismissDirection.vertical,
      ));

      final dismissible = tester.widget<Dismissible>(
        find.byType(Dismissible),
      );
      expect(dismissible.direction, DismissDirection.vertical);
    });

    testWidgets('calls onDismissed callback when swiped away', (tester) async {
      final item = createTestSampleItem();
      bool wasDismissed = false;

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
        callbacks: ToastificationCallbacks(
          onDismissed: (i) => wasDismissed = true,
        ),
      ));

      // Swipe the widget to the right to dismiss
      await tester.drag(find.byKey(_childKey), const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(wasDismissed, isTrue);
    });

    testWidgets('drag dismiss works without error when onDismissed is null',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
      ));

      // Should not throw
      await tester.drag(find.byKey(_childKey), const Offset(500, 0));
      await tester.pumpAndSettle();
    });

    testWidgets(
        'pointer down pauses timer and pointer up resumes when pauseOnHover is false',
        (tester) async {
      final item = createTestItemWithTimer();
      expect(item.hasTimer, isTrue);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
        pauseOnHover: false,
      ));

      expect(item.timeStatus, ToastTimeStatus.started);

      // Use a touch pointer (not mouse) since pauseOnHover is false
      final gesture = await tester.startGesture(
        tester.getCenter(find.byKey(_childKey)),
        kind: PointerDeviceKind.touch,
      );
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.paused);

      await gesture.up();
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.started);

      // PausableTimer holds a real Timer internally — must stop it
      // before the test ends to avoid the pending timer assertion.
      item.stop();
    });

    testWidgets('touch pointer pauses timer even when pauseOnHover is true',
        (tester) async {
      final item = createTestItemWithTimer();
      expect(item.hasTimer, isTrue);

      await tester.pumpWidget(buildContainerTestApp(
        item: item,
        dragToClose: true,
        pauseOnHover: true,
      ));

      item.start();
      expect(item.timeStatus, ToastTimeStatus.started);

      // Touch pointer should still pause via _handleDragUpdate
      // (only mouse is skipped when pauseOnHover is true)
      final gesture = await tester.startGesture(
        tester.getCenter(find.byKey(_childKey)),
        kind: PointerDeviceKind.touch,
      );
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.paused);

      await gesture.up();
      await tester.pump();

      expect(item.timeStatus, ToastTimeStatus.started);

      item.stop();
    });
  });
}
