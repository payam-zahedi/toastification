import 'dart:developer';

import 'package:material_ui/material_ui.dart';
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

  // https://github.com/payam-zahedi/toastification/issues/193
  group('Toastification - before the first frame', () {
    const animationDuration = Duration(milliseconds: 100);

    late BuildContext appContext;

    setUp(() => toastification.hosts.clear());

    Future<void> pumpApp(WidgetTester tester, {Widget? child}) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                appContext = context;
                return child ?? const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    }

    ToastificationItem showToast(String title, {BuildContext? context}) {
      return toastification.show(
        context: context ?? appContext,
        title: Text(title),
        animationDuration: animationDuration,
      );
    }

    // skipOffstage: false, a toast whose enter animation has not started yet
    // has zero height and counts as offstage.
    Finder findToast(String title) => find.text(title, skipOffstage: false);

    void expectNoOverlay() {
      for (final host in toastification.hosts.values) {
        for (final manager in host.managers) {
          expect(manager.notifications, isEmpty);
          expect(manager.overlayEntry, isNull);
        }
      }
    }

    testWidgets('should never show a toast dismissed by id in the same frame',
        (tester) async {
      await pumpApp(tester);

      final item = showToast('A');
      toastification.dismissById(item.id);
      expect(toastification.findToastificationItem(item.id), isNull);

      await tester.pump();
      expect(findToast('A'), findsNothing);
      await tester.pump();
      expect(findToast('A'), findsNothing);
      await tester.pump(const Duration(milliseconds: 100));
      expect(findToast('A'), findsNothing);

      expectNoOverlay();
    });

    testWidgets(
        'should remove toasts shown in the same frame with '
        'dismissAll(delayForAnimation: false)', (tester) async {
      await pumpApp(tester);

      showToast('A');
      showToast('B');
      showToast('C');
      toastification.dismissAll(delayForAnimation: false);

      await tester.pump();
      await tester.pump();
      for (final title in ['A', 'B', 'C']) {
        expect(findToast(title), findsNothing);
      }
      await tester.pump(const Duration(milliseconds: 100));

      expectNoOverlay();
    });

    testWidgets(
        'should remove toasts shown in the same frame with '
        'dismissAll(delayForAnimation: true)', (tester) async {
      await pumpApp(tester);

      showToast('A');
      showToast('B');
      showToast('C');
      toastification.dismissAll();

      // dismissAll waits 150ms between two toasts.
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      for (final title in ['A', 'B', 'C']) {
        expect(findToast(title), findsNothing);
      }
      expectNoOverlay();
    });

    testWidgets('should show a toast from build', (tester) async {
      var shown = false;
      await pumpApp(
        tester,
        child: Builder(
          builder: (context) {
            if (!shown) {
              shown = true;
              showToast('A', context: context);
            }
            return const SizedBox.shrink();
          },
        ),
      );
      expect(tester.takeException(), isNull);

      await tester.pumpAndSettle();
      expect(find.text('A'), findsOneWidget);

      await cleanUpToasts(tester);
    });

    testWidgets('should never show a toast shown and dismissed in one build',
        (tester) async {
      var shown = false;
      await pumpApp(
        tester,
        child: Builder(
          builder: (context) {
            if (!shown) {
              shown = true;
              toastification.dismiss(showToast('A', context: context));
            }
            return const SizedBox.shrink();
          },
        ),
      );
      expect(tester.takeException(), isNull);

      await tester.pump();
      expect(findToast('A'), findsNothing);
      await tester.pump();
      expect(findToast('A'), findsNothing);
      await tester.pump(const Duration(milliseconds: 100));
      expect(findToast('A'), findsNothing);

      expectNoOverlay();
    });
  });

  // https://github.com/payam-zahedi/toastification/issues/255
  group('Toastification - multiple overlays', () {
    const perOverlay = ToastificationConfig(scope: ToastificationScope.overlay);
    const perApp = ToastificationConfig();

    final first = GlobalKey<OverlayState>();
    final second = GlobalKey<OverlayState>();

    setUp(() => toastification.hosts.clear());

    // two overlays side by side, like two windows or two nested navigators.
    Future<void> pumpOverlays(
      WidgetTester tester, {
      bool withFirst = true,
      ToastificationConfig firstConfig = perOverlay,
      ToastificationConfig secondConfig = perOverlay,
    }) {
      Widget overlay(GlobalKey<OverlayState> key, ToastificationConfig config) {
        return Expanded(
          child: ToastificationConfigProvider(
            config: config,
            child: Overlay(key: key),
          ),
        );
      }

      return tester.pumpWidget(
        MaterialApp(
          home: Row(
            children: [
              if (withFirst) overlay(first, firstConfig),
              overlay(second, secondConfig),
            ],
          ),
        ),
      );
    }

    Future<ToastificationItem> showToast(
      WidgetTester tester,
      GlobalKey<OverlayState> overlay,
      String text,
    ) async {
      final item = toastification.showCustom(
        overlayState: overlay.currentState,
        alignment: Alignment.topRight,
        animationDuration: const Duration(milliseconds: 100),
        builder: (context, item) => Text(text),
      );
      await tester.pumpAndSettle();
      return item;
    }

    Finder findIn(GlobalKey<OverlayState> overlay, String text) =>
        find.descendant(of: find.byKey(overlay), matching: find.text(text));

    testWidgets('should show the toasts of all overlays in one list by default',
        (tester) async {
      await pumpOverlays(tester, firstConfig: perApp, secondConfig: perApp);

      await showToast(tester, first, 'First');
      await showToast(tester, second, 'Second');

      expect(findIn(first, 'First'), findsOneWidget);
      expect(findIn(first, 'Second'), findsOneWidget);

      await cleanUpToasts(tester);
    });

    testWidgets(
        'should show, find and dismiss each toast in the overlay it was '
        'requested for', (tester) async {
      await pumpOverlays(tester);

      final firstItem = await showToast(tester, first, 'First');
      final secondItem = await showToast(tester, second, 'Second');

      expect(findIn(first, 'First'), findsOneWidget);
      expect(findIn(second, 'Second'), findsOneWidget);
      expect(toastification.findToastificationItem(firstItem.id), firstItem);
      expect(toastification.findToastificationItem(secondItem.id), secondItem);

      toastification.dismiss(secondItem);
      await tester.pumpAndSettle();
      expect(find.text('Second'), findsNothing);
      expect(findIn(first, 'First'), findsOneWidget);

      await cleanUpToasts(tester);
    });

    testWidgets(
        'should show a toast after another overlay is gone with its toast '
        'still visible, and release that toast', (tester) async {
      await pumpOverlays(tester);
      final firstItem = await showToast(tester, first, 'First');

      await pumpOverlays(tester, withFirst: false);
      await showToast(tester, second, 'Second');

      expect(findIn(second, 'Second'), findsOneWidget);
      expect(toastification.findToastificationItem(firstItem.id), isNull);

      await cleanUpToasts(tester);
    });

    testWidgets('should use the scope of the wrapper when there is no context',
        (tester) async {
      await tester.pumpWidget(
        const ToastificationWrapper(
          config: perOverlay,
          child: MaterialApp(home: Scaffold()),
        ),
      );

      toastification.show(title: const Text('No context'));
      await tester.pumpAndSettle();

      expect(find.text('No context'), findsOneWidget);
      expect(toastification.hosts.keys, [ToastificationScope.overlay]);

      await cleanUpToasts(tester);
    });

    testWidgets('should find and dismiss toasts shown with both scopes',
        (tester) async {
      await pumpOverlays(tester, secondConfig: perApp);

      final firstItem = await showToast(tester, first, 'First');
      final secondItem = await showToast(tester, second, 'Second');

      expect(toastification.hosts, hasLength(2));
      expect(toastification.findToastificationItem(firstItem.id), firstItem);
      expect(toastification.findToastificationItem(secondItem.id), secondItem);

      toastification.dismissAll(delayForAnimation: false);
      await tester.pumpAndSettle();
      expect(find.text('First'), findsNothing);
      expect(find.text('Second'), findsNothing);
    });
  });
}
