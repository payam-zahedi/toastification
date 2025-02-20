import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/built_in/built_in_builder.dart';
import 'package:toastification/toastification.dart';

/// Helper function to clean up any remaining toasts after each test
///
/// This ensures that toasts from one test don't interfere with another test.
/// The function:
/// 1. Dismisses all active toasts
/// 2. Waits for dismissal animations
/// 3. Ensures widget tree is stable
Future<void> cleanUpToasts(WidgetTester tester) async {
  toastification.dismissAll(delayForAnimation: false);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pumpAndSettle();
}

void main() {
  /// Tests for the basic [show] method functionality
  /// These tests verify the core features of displaying built-in toasts
  group('Toastification - show()', () {
    /// Verifies that a basic toast appears with correct title and description
    /// This is the most fundamental test case for the show() method
    testWidgets(
        'should display toast with title and description when show is called',
        (tester) async {
      const kShowBasicToastButton = Key('show_basic_toast');
      const kBasicTitle = 'Basic Title';
      const kBasicDescription = 'Basic Description';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      key: kShowBasicToastButton,
                      onPressed: () {
                        toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          title: const Text(kBasicTitle),
                          description: const Text(kBasicDescription),
                          animationDuration: const Duration(milliseconds: 100),
                        );
                      },
                      child: const Text('Show Basic Toast'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Verify that the toast is not displayed initially
      expect(find.text(kBasicTitle), findsNothing);

      // Tap the button to show the toast
      await tester.tap(find.byKey(kShowBasicToastButton));

      // Using pump to rebuild and start animations we have
      await tester.pump();

      // Using pumpAndSettle to wait for the animation to complete
      await tester.pumpAndSettle();

      // Verify that the toast is displayed with the correct title and description
      expect(find.text(kBasicTitle), findsOneWidget);
      expect(find.text(kBasicDescription), findsOneWidget);

      // Clean up the toast after the test
      await cleanUpToasts(tester);
    });

    /// Verifies that toast cleanup works correctly
    /// This ensures toasts can be properly removed from the widget tree
    testWidgets('should remove toast from widget tree when dismissed',
        (tester) async {
      const kShowBasicToastButton = Key('show_basic_toast');
      const kBasicTitle = 'Basic Title';
      const kBasicDescription = 'Basic Description';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      key: kShowBasicToastButton,
                      onPressed: () {
                        toastification.show(
                          context: context,
                          style: ToastificationStyle.flat,
                          title: const Text(kBasicTitle),
                          description: const Text(kBasicDescription),
                          type: ToastificationType.success,
                          animationDuration: const Duration(milliseconds: 100),
                        );
                      },
                      child: const Text('Show Basic Toast'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text(kBasicTitle), findsNothing);

      await tester.tap(find.byKey(kShowBasicToastButton));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(BuiltInBuilder), findsOneWidget);

      await cleanUpToasts(tester);

      expect(find.byType(BuiltInBuilder), findsNothing);
    });

    /// Verifies automatic closure functionality
    /// Tests that toasts respect their autoCloseDuration parameter
    testWidgets(
        'should automatically remove toast from widget tree after autoCloseDuration',
        (tester) async {
      const kAutoCloseTitle = 'AutoClose Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  key: const Key('show_auto_close'),
                  onPressed: () {
                    toastification.show(
                      context: context,
                      title: const Text(kAutoCloseTitle),
                      showProgressBar: false,
                      autoCloseDuration: const Duration(milliseconds: 1000),
                      animationDuration: const Duration(milliseconds: 200),
                    );
                  },
                  child: const Text('Show AutoClose Toast'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('show_auto_close')));

      await tester.pump();
      await tester.pumpAndSettle();

      // Verify that the toast is displayed
      expect(find.text(kAutoCloseTitle), findsOneWidget);

      // Wait for the autoCloseDuration to pass and start close animation
      await tester.pump(const Duration(milliseconds: 1200));

      // Wait for the close animation to complete
      await tester.pumpAndSettle();

      // Verify that the toast is removed from the widget tree
      expect(find.text(kAutoCloseTitle), findsNothing);
    });

    /// Verifies progress bar functionality
    /// Tests that the progress indicator appears when requested
    testWidgets('should display progress bar when showProgressBar is true',
        (tester) async {
      const kShowProgressBarButton = Key('show_progress_bar');
      const kProgressBarTitle = 'Progress Bar Toast';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  key: kShowProgressBarButton,
                  onPressed: () {
                    toastification.show(
                      context: context,
                      showProgressBar: true,
                      title: const Text(kProgressBarTitle),
                    );
                  },
                  child: const Text('Show Progress Toast'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(kShowProgressBarButton));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text(kProgressBarTitle), findsOneWidget);

      // Verify that the progress indicator is displayed
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      await cleanUpToasts(tester);
    });
  });

  /// Tests for the [showCustom] method functionality
  /// These tests verify the ability to display custom toast widgets
  group('Toastification - showCustom()', () {
    /// Verifies that custom widgets can be displayed as toasts
    /// Tests the basic custom builder functionality
    testWidgets('should display custom widget when showCustom is called',
        (tester) async {
      const kShowCustomToastButton = Key('show_custom_toast');
      const kCustomToastContainer = Key('custom_toast_container');
      const kCustomToastText = 'Custom Toast';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  key: kShowCustomToastButton,
                  onPressed: () {
                    toastification.showCustom(
                      context: context,
                      builder: (context, toast) => Container(
                        key: kCustomToastContainer,
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue,
                        child: const Text(kCustomToastText),
                      ),
                    );
                  },
                  child: const Text('Show Custom Toast'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(kCustomToastContainer), findsNothing);

      await tester.tap(find.byKey(kShowCustomToastButton));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byKey(kCustomToastContainer), findsOneWidget);
      expect(find.text(kCustomToastText), findsOneWidget);

      await cleanUpToasts(tester);
    });

    /// Verifies alignment positioning system
    /// Tests that toasts appear in the specified screen position
    testWidgets('should respect custom alignment when specified',
        (tester) async {
      const kShowCustomToastButton = Key('show_custom_toast');
      const kCustomToastContainer = Key('custom_toast_container');
      const kCustomToastText = 'Custom Toast';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  key: kShowCustomToastButton,
                  onPressed: () {
                    toastification.showCustom(
                      context: context,
                      alignment: Alignment.bottomCenter,
                      builder: (context, toast) => Container(
                        key: kCustomToastContainer,
                        child: const Text(kCustomToastText),
                      ),
                    );
                  },
                  child: const Text('Show Custom Toast'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(kShowCustomToastButton));
      await tester.pump();
      await tester.pumpAndSettle();

      final containerFinder = find.byKey(kCustomToastContainer);
      expect(containerFinder, findsOneWidget);

      final renderBox = tester.renderObject(containerFinder) as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      expect(position.dy > tester.getCenter(find.byType(Scaffold)).dy, true);

      await cleanUpToasts(tester);
    });

    /// Verifies automatic closure for custom toasts
    /// Tests that custom toasts respect autoCloseDuration
    testWidgets('should auto-close with custom duration', (tester) async {
      const kAutoCloseToast = Key('auto_close_toast');
      const kAutoCloseText = 'Auto Close Toast';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                toastification.showCustom(
                  context: context,
                  autoCloseDuration: const Duration(milliseconds: 1000),
                  animationDuration: const Duration(milliseconds: 200),
                  builder: (context, toast) => Container(
                    key: kAutoCloseToast,
                    child: const Text(kAutoCloseText),
                  ),
                );
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byKey(kAutoCloseToast), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      expect(find.byKey(kAutoCloseToast), findsNothing);
    });
  });

  group('Toastification - dismiss()', () {
    testWidgets('should remove toast from overlay when dismiss method called',
        (tester) async {
      late ToastificationItem toastItem;

      const kShowBasicToastButton = Key('show_basic_toast');
      const kBasicTitle = 'Basic Title';
      const kBasicDescription = 'Basic Description';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      key: kShowBasicToastButton,
                      onPressed: () {
                        toastItem = toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          title: const Text(kBasicTitle),
                          description: const Text(kBasicDescription),
                          animationDuration: const Duration(milliseconds: 100),
                        );
                      },
                      child: const Text('Show Basic Toast'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Verify that the toast is not displayed initially
      expect(find.text(kBasicTitle), findsNothing);

      // Tap the button to show the toast
      await tester.tap(find.byKey(kShowBasicToastButton));

      expect(toastItem, isNotNull);
      log('ToastItem: $toastItem');

      // Using pump to rebuild and start animations we have
      await tester.pump();

      // Using pumpAndSettle to wait for the animation to complete
      await tester.pumpAndSettle();

      // Verify that the toast is displayed with the correct title and description
      expect(find.text(kBasicTitle), findsOneWidget);
      expect(find.text(kBasicDescription), findsOneWidget);

      toastification.dismiss(toastItem);

      // Using pump to rebuild and start close animations
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify that the toast is removed from the widget tree
      expect(find.text(kBasicTitle), findsNothing);
    });

    testWidgets('should remove toast when dismissById is called',
        (tester) async {
      late ToastificationItem toastItem;
      const kBasicTitle = 'Basic Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                toastItem = toastification.show(
                  context: context,
                  title: const Text(kBasicTitle),
                );
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text(kBasicTitle), findsOneWidget);

      toastification.dismissById(toastItem.id);

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text(kBasicTitle), findsNothing);
    });

    testWidgets('should remove all toasts when dismissAll is called',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Column(
              children: [
                ElevatedButton(
                  onPressed: () => toastification.show(
                    context: context,
                    title: const Text('Toast 1'),
                  ),
                  child: const Text('Show Toast 1'),
                ),
                ElevatedButton(
                  onPressed: () => toastification.show(
                    context: context,
                    title: const Text('Toast 2'),
                  ),
                  child: const Text('Show Toast 2'),
                ),
              ],
            ),
          ),
        ),
      );

      // Show both toasts
      await tester.tap(find.text('Show Toast 1'));
      await tester.pump();
      await tester.tap(find.text('Show Toast 2'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify both toasts are visible
      expect(find.text('Toast 1'), findsOneWidget);
      expect(find.text('Toast 2'), findsOneWidget);

      // Dismiss all toasts
      toastification.dismissAll(delayForAnimation: false);
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify all toasts are removed
      expect(find.text('Toast 1'), findsNothing);
      expect(find.text('Toast 2'), findsNothing);
    });

    testWidgets('should handle dismissing non-existent toast gracefully',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Container(),
          ),
        ),
      );

      // Should not throw when dismissing non-existent toast
      expect(
        () => toastification.dismissById('non-existent-id'),
        returnsNormally,
      );
    });

    testWidgets('should not affect other toasts when dismissing specific toast',
        (tester) async {
      late ToastificationItem toast1;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    toast1 = toastification.show(
                      context: context,
                      title: const Text('Toast 1'),
                    );
                  },
                  child: const Text('Show Toast 1'),
                ),
                ElevatedButton(
                  onPressed: () => toastification.show(
                    context: context,
                    title: const Text('Toast 2'),
                  ),
                  child: const Text('Show Toast 2'),
                ),
              ],
            ),
          ),
        ),
      );

      // Show both toasts
      await tester.tap(find.text('Show Toast 1'));
      await tester.pump();
      await tester.tap(find.text('Show Toast 2'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Dismiss only first toast
      toastification.dismiss(toast1);
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify only first toast is removed
      expect(find.text('Toast 1'), findsNothing);
      expect(find.text('Toast 2'), findsOneWidget);

      await cleanUpToasts(tester);
    });
  });

  group('Toastification - findToastificationItem()', () {
    testWidgets('should find existing toast by id', (tester) async {
      late ToastificationItem originalToast;
      const kBasicTitle = 'Basic Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                originalToast = toastification.show(
                  context: context,
                  title: const Text(kBasicTitle),
                );
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pumpAndSettle();

      final foundToast =
          toastification.findToastificationItem(originalToast.id);
      expect(foundToast, isNotNull);
      expect(foundToast?.id, equals(originalToast.id));

      await cleanUpToasts(tester);
    });

    testWidgets('should return null for non-existent toast id', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(),
        ),
      );

      final foundToast =
          toastification.findToastificationItem('non-existent-id');
      expect(foundToast, isNull);
    });

    testWidgets('should find correct toast when multiple toasts exist',
        (tester) async {
      late ToastificationItem toast1;
      late ToastificationItem toast2;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    toast1 = toastification.show(
                      context: context,
                      title: const Text('Toast 1'),
                    );
                  },
                  child: const Text('Show Toast 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    toast2 = toastification.show(
                      context: context,
                      title: const Text('Toast 2'),
                    );
                  },
                  child: const Text('Show Toast 2'),
                ),
              ],
            ),
          ),
        ),
      );

      // Show both toasts
      await tester.tap(find.text('Show Toast 1'));
      await tester.pump();
      await tester.tap(find.text('Show Toast 2'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Find first toast
      final foundToast1 = toastification.findToastificationItem(toast1.id);
      expect(foundToast1?.id, equals(toast1.id));

      // Find second toast
      final foundToast2 = toastification.findToastificationItem(toast2.id);
      expect(foundToast2?.id, equals(toast2.id));

      // Verify they're different
      expect(foundToast1?.id, isNot(equals(foundToast2?.id)));

      await cleanUpToasts(tester);
    });

    testWidgets('should still find toast before animation completes',
        (tester) async {
      late ToastificationItem toast;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                toast = toastification.show(
                  context: context,
                  title: const Text('Toast'),
                  animationDuration: const Duration(milliseconds: 500),
                );
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      // This waiting is for the OverlayEntry to be added to the tree
      // we don't wait for the animation to completed
      await tester.pump();
      // Don't wait for animation to complete

      final foundToast = toastification.findToastificationItem(toast.id);
      expect(foundToast, isNotNull);
      expect(foundToast?.id, equals(toast.id));

      await tester.pumpAndSettle(); // Clean up

      await cleanUpToasts(tester);
    });
  });
}
