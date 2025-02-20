import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/toastification.dart';

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

  group('showCustom', () {
    testWidgets('should show overlay entry in the screen',
        (WidgetTester tester) async {
      await createOverlay(tester);

      manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      // Wait for overlay creation delay
      await tester.pumpAndSettle();

      // Find the Text widget in the overlay
      expect(find.text('Test Toast'), findsOneWidget);
      // Verify the overlay is in the widget tree
      expect(find.byType(Overlay), findsOneWidget);
    });

    testWidgets('should create overlay entry for first notification',
        (WidgetTester tester) async {
      await createOverlay(tester);

      expect(manager.overlayEntry, isNull);
      expect(manager.notifications, isEmpty);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      // Wait for overlay creation delay
      await tester.pumpAndSettle();

      expect(manager.overlayEntry, isNotNull);
      expect(manager.notifications, hasLength(1));
      expect(manager.notifications.first, equals(item));
    });

    testWidgets('should provide same parameters to the item',
        (WidgetTester tester) async {
      await createOverlay(tester);

      customBuilder(context, item) {
        return const Text('Test Toast');
      }

      customAnimationBuilder(
        BuildContext context,
        Animation<double> animation,
        Alignment alignment,
        Widget child,
      ) {
        return child;
      }

      const customAnimationDuration = Duration(milliseconds: 300);
      const customAutoCloseDuration = Duration(seconds: 5);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: customBuilder,
        animationBuilder: customAnimationBuilder,
        animationDuration: customAnimationDuration,
        autoCloseDuration: customAutoCloseDuration,
        callbacks: const ToastificationCallbacks(),
      );

      // Wait for overlay creation delay
      await tester.pumpAndSettle();

      expect(item.builder, equals(customBuilder));
      expect(item.animationBuilder, equals(customAnimationBuilder));
      expect(item.animationDuration, equals(customAnimationDuration));
      expect(item.autoCloseDuration, equals(customAutoCloseDuration));

      item.stop();

      // Wait for item to dismiss
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets(
      'should add item after delay we have to create the overlay',
      (WidgetTester tester) async {
        await createOverlay(tester);

        final firstItem = manager.showCustom(
          overlayState: overlayState,
          scheduler: tester.binding,
          builder: (context, item) => const Text('First Toast'),
          animationBuilder: null,
          animationDuration: null,
          callbacks: const ToastificationCallbacks(),
        );
        // Overlay is not created yet
        expect(manager.notifications.contains(firstItem), isFalse);

        // Wait for overlay creation delay
        await tester.pumpAndSettle();
        expect(manager.notifications.contains(firstItem), isTrue);
      },
    );

    testWidgets('should create overlay entry only once',
        (WidgetTester tester) async {
      await createOverlay(tester);

      manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      // Wait for overlay creation delay
      await tester.pumpAndSettle();

      final overlayEntry = manager.overlayEntry;

      manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      // Wait for overlay creation delay
      await tester.pumpAndSettle();

      expect(manager.overlayEntry, equals(overlayEntry));
    });

    testWidgets('should respect maxToastLimit from config',
        (WidgetTester tester) async {
      await createOverlay(tester);

      manager = ToastificationManager(
        alignment: Alignment.topRight,
        config: const ToastificationConfig(maxToastLimit: 2),
      );

      // Show 5 notifications
      for (var i = 0; i < 5; i++) {
        manager.showCustom(
          overlayState: overlayState,
          scheduler: tester.binding,
          builder: (context, item) => Text('Toast $i'),
          animationBuilder: null,
          animationDuration: null,
          callbacks: const ToastificationCallbacks(),
        );
      }

      // Wait for all animations
      await tester.pumpAndSettle();

      expect(manager.notifications, hasLength(2));
    });
    testWidgets('testing frames', (tester) async {
      final w = Container();
      int framesCount = 0;

      tester.binding.addPersistentFrameCallback((timeStamp) {
        framesCount++;
      });

      await tester.pumpWidget(w);
      expect(framesCount, equals(1));

      // pumpWidget calls [scheduleFrame]
      await tester.pumpWidget(w);
      expect(framesCount, equals(2));

      await tester.pump();
      // no frame was scheduled, so framesCount is still 2
      expect(framesCount, equals(2));

      tester.binding.scheduleFrame(); // --
      await tester.pump(); //   |
      expect(framesCount, equals(3)); // <-

      // pumpWidget calls [scheduleFrame]
      await tester.pumpWidget(w);
      expect(framesCount, equals(4));
    });

    testWidgets('should insert new notifications at the beginning',
        (WidgetTester tester) async {
      await createOverlay(tester);

      expect(manager.notifications.length, equals(0));

      final firstItem = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('First Toast'),
        animationBuilder: null,
        animationDuration: Duration(milliseconds: 100),
        callbacks: const ToastificationCallbacks(),
      );

      /// To schedule a frame (and force postFrameCallback to be called) in flutter test environment
      /// you need to call tester.binding.scheduleFrame() before tester.pump().
      tester.binding.scheduleFrame();

      // Wait for the first post-frame callback
      await tester.pumpAndSettle();

      expect(manager.notifications.length, equals(1));
      expect(manager.notifications[0], equals(firstItem));

      final secondItem = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Second Toast'),
        animationBuilder: null,
        animationDuration: Duration(milliseconds: 100),
        callbacks: const ToastificationCallbacks(),
      );

      /// Force postFrameCallback to be called
      tester.binding.scheduleFrame();

      await tester.pumpAndSettle();

      expect(manager.notifications.length, equals(2));
      expect(manager.notifications[0], equals(secondItem));
      expect(manager.notifications[1], equals(firstItem));

      final thirdItem = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Third Toast'),
        animationBuilder: null,
        animationDuration: Duration(milliseconds: 300),
        callbacks: const ToastificationCallbacks(),
      );

      /// Force postFrameCallback to be called
      tester.binding.scheduleFrame();

      // Start the animation
      await tester.pump();

      await tester.pumpAndSettle();

      expect(manager.notifications.length, equals(3));
      expect(manager.notifications[0], equals(thirdItem));
      expect(manager.notifications[1], equals(secondItem));
      expect(manager.notifications[2], equals(firstItem));
    });

    testWidgets('should use provided animation duration',
        (WidgetTester tester) async {
      await createOverlay(tester);

      const customDuration = Duration(milliseconds: 300);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: customDuration,
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();

      expect(item.animationDuration, equals(customDuration));
    });
  });

  group('findToastificationItem', () {
    testWidgets('should return null when no notifications exist',
        (WidgetTester tester) async {
      await createOverlay(tester);
      expect(manager.findToastificationItem('non-existent-id'), isNull);
    });

    testWidgets('should find notification by id when it exists',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();

      final foundItem = manager.findToastificationItem(item.id);

      expect(foundItem, isNotNull);
      expect(foundItem!.id, equals(item.id));
      expect(foundItem, equals(item));
    });
  });

  group('dismiss', () {
    testWidgets('should remove notification from the list',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();
      expect(manager.notifications, contains(item));

      manager.dismiss(item);
      await tester.pumpAndSettle();

      expect(manager.notifications, isEmpty);
    });

    testWidgets('should stop running timer when dismissing',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: null,
        autoCloseDuration: const Duration(seconds: 2),
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();
      expect(item.isRunning, isTrue);

      manager.dismiss(item);
      await tester.pumpAndSettle();

      expect(item.isRunning, isFalse);
    });

    testWidgets(
        'should remove overlay entry when last notification is dismissed',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: const Duration(milliseconds: 100),
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();
      expect(manager.overlayEntry, isNotNull);

      manager.dismiss(item);
      // Wait for animation and removal delay
      await tester.pump(const Duration(milliseconds: 100)); // animation
      await tester.pump(manager.removeOverlayDelay); // removal delay

      expect(manager.overlayEntry, isNull);
    });

    testWidgets(
        'should keep overlay entry when dismissing notification but others exist',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final firstItem = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('First Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      final secondItem = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Second Toast'),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pumpAndSettle();
      final overlayEntry = manager.overlayEntry;

      manager.dismiss(firstItem);
      await tester.pumpAndSettle();

      expect(manager.overlayEntry, equals(overlayEntry));
      expect(manager.notifications, contains(secondItem));
    });

    testWidgets(
        'should not trigger animation when showRemoveAnimation is false',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const Text('Test Toast'),
        animationBuilder: null,
        animationDuration: const Duration(seconds: 1),
        callbacks: const ToastificationCallbacks(),
      );

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Test Toast'), findsOneWidget);

      manager.dismiss(item, showRemoveAnimation: false);
      // If there was no animation, the item should be gone immediately
      await tester.pump(Duration(milliseconds: 50));

      expect(find.text('Test Toast'), findsNothing);

      // Wait to ensure OverlayEntry is removed after animation delay
      // we need to this because we used Future.delayed in the dismiss method
      await tester.pump(Duration(seconds: 1));
      await tester.pumpAndSettle();
    });

    testWidgets('should do nothing when dismissing non-existent notification',
        (WidgetTester tester) async {
      await createOverlay(tester);

      final item = ToastificationItem(
        builder: (context, item) => const Text('Test Toast'),
        alignment: Alignment.topRight,
      );

      // Should not throw
      manager.dismiss(item);
      await tester.pumpAndSettle();

      expect(manager.notifications, isEmpty);
    });
  });

  group('dismissAll', () {
    testWidgets('should remove all notifications from the list',
        (WidgetTester tester) async {
      await createOverlay(tester);

      // Add multiple notifications
      for (var i = 0; i < 3; i++) {
        manager.showCustom(
          overlayState: overlayState,
          scheduler: tester.binding,
          builder: (context, item) => Text('Toast $i'),
          animationBuilder: null,
          animationDuration: null,
          callbacks: const ToastificationCallbacks(),
        );
      }

      await tester.pumpAndSettle();
      expect(manager.notifications.length, equals(3));

      manager.dismissAll(delayForAnimation: false);
      await tester.pumpAndSettle();

      expect(manager.notifications, isEmpty);
    });

    testWidgets(
        'should remove overlay entry after all notifications are removed',
        (WidgetTester tester) async {
      await createOverlay(tester);

      // Add multiple notifications
      for (var i = 0; i < 3; i++) {
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
      expect(manager.overlayEntry, isNotNull);

      manager.dismissAll(delayForAnimation: false);

      // Wait for animation and removal delay
      await tester.pump(const Duration(milliseconds: 100)); // animation
      await tester.pump(manager.removeOverlayDelay); // removal delay

      expect(manager.overlayEntry, isNull);
    });

    testWidgets('should respect animation delay when delayForAnimation is true',
        (WidgetTester tester) async {
      await createOverlay(tester);

      // Add multiple notifications
      List<String> toastTexts = ['First', 'Second', 'Third'];
      for (var text in toastTexts) {
        manager.showCustom(
          overlayState: overlayState,
          scheduler: tester.binding,
          builder: (context, item) => Text(text),
          animationBuilder: null,
          animationDuration: const Duration(milliseconds: 300),
          callbacks: const ToastificationCallbacks(),
        );
      }

      await tester.pumpAndSettle();

      manager.dismissAll(delayForAnimation: true);

      // First pump to start animations
      await tester.pump();

      // After first pump, all toasts should still be visible
      for (var text in toastTexts) {
        expect(find.text(text), findsOneWidget);
      }

      // Pump half the animation delay duration
      await tester.pump(const Duration(milliseconds: 75));

      // After animation completes
      await tester.pumpAndSettle();

      // All toasts should be gone
      for (var text in toastTexts) {
        expect(find.text(text), findsNothing);
      }
    });

    testWidgets('should do nothing when no notifications exist',
        (WidgetTester tester) async {
      await createOverlay(tester);

      expect(manager.notifications, isEmpty);

      // Should not throw
      manager.dismissAll();
      await tester.pumpAndSettle();

      expect(manager.notifications, isEmpty);
      expect(manager.overlayEntry, isNull);
    });
  });
}
