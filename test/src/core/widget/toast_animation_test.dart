import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('ToastTimerAnimationBuilder', () {
    late ToastificationItem mockItem;

    setUp(() {
      mockItem = ToastificationItem(
        builder: (_, __) => const SizedBox(),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
      );
    });

    testWidgets('should initialize with proper timer status',
        (WidgetTester tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: ToastTimerAnimationBuilder(
            item: mockItem,
            builder: (context, value, child) {
              capturedValue = value;
              return Container();
            },
          ),
        ),
      );

      expect(mockItem.timeStatus, equals(ToastTimeStatus.started));

      /// since the timer is started, the captured value should not be 0.0
      expect(capturedValue, isNot(equals(0.0)));
    });

    testWidgets('should respond to toast status changes',
        (WidgetTester tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: ToastTimerAnimationBuilder(
            item: mockItem,
            builder: (context, value, child) {
              capturedValue = value;
              return Container();
            },
          ),
        ),
      );

      mockItem.pause();
      await tester.pump();
      expect(mockItem.timeStatus, equals(ToastTimeStatus.paused));
      final pausedValue = capturedValue;

      mockItem.start();
      await tester.pump();
      expect(mockItem.timeStatus, equals(ToastTimeStatus.started));

      mockItem.stop();
      await tester.pump();
      expect(mockItem.timeStatus, equals(ToastTimeStatus.stopped));
      expect(capturedValue, equals(pausedValue));
    });

    testWidgets('should handle timer elapsedDuration properly',
        (WidgetTester tester) async {
      double? capturedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: ToastTimerAnimationBuilder(
            item: mockItem,
            builder: (context, value, child) {
              capturedValue = value;
              return Container();
            },
          ),
        ),
      );

      // Initial state check
      expect(mockItem.elapsedDuration?.inSeconds, equals(0));

      // Advance timer
      await tester.pump(const Duration(seconds: 1));
      expect(capturedValue, closeTo(0.33, 0.05));

      mockItem.pause();
      final elapsedAtPause = mockItem.elapsedDuration;
      await tester.pump(const Duration(seconds: 1));
      expect(mockItem.elapsedDuration, equals(elapsedAtPause));
    });

    testWidgets('should cleanup timer listeners on dispose',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToastTimerAnimationBuilder(
            item: mockItem,
            builder: (_, __, ___) => Container(),
          ),
        ),
      );

      // Verify initial state
      expect(mockItem.isStarted, isTrue);

      // Trigger disposal
      await tester.pumpWidget(const SizedBox());

      // Should still maintain its state after builder disposal
      expect(mockItem.hasTimer, isTrue);
      expect(mockItem.isStarted, isTrue);
    });
  });
}
