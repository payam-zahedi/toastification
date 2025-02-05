import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/built_in/built_in_builder.dart';
import 'package:toastification/toastification.dart';

Future<void> cleanUpToasts(WidgetTester tester) async {
  toastification.dismissAll(delayForAnimation: false);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pumpAndSettle();
}

void main() {
  group('show method: basic tests', () {
    late Widget app;

    Future<void> pumpToast(WidgetTester tester) async {
      // Load the main application widget for testing
      await tester.pumpWidget(app);

      // Verify no toast is displayed before tapping the button
      // We used Basic Title as the toast title,
      // so we can use it to check if the toast is displayed
      expect(find.text('Basic Title'), findsNothing);

      // Tap the button, triggering the toastification.show method
      await tester.tap(find.byKey(const Key('show_basic_toast')));

      // Advance one frame to start the toast animation
      await tester.pump();

      // Allow all animations to complete
      await tester.pumpAndSettle();
    }

    setUp(() {
      app = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: Column(
                children: [
                  ElevatedButton(
                    key: const Key('show_basic_toast'),
                    onPressed: () {
                      toastification.show(
                        context: context,
                        style: ToastificationStyle.flat,
                        title: const Text('Basic Title'),
                        description: const Text('Basic Description'),
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
      );
    });

    testWidgets('show toast and check if toast is opened', (tester) async {
      // Load the main application widget for testing
      // and show toast and await for the toast to be displayed
      await pumpToast(tester);

      // Confirm that the toast's title and description are now displayed
      expect(find.text('Basic Title'), findsOneWidget);
      expect(find.text('Basic Description'), findsOneWidget);

      // Clean up the toasts
      await cleanUpToasts(tester);
    });

    testWidgets('show toast and check if toast is closed', (tester) async {
      // Load the main application widget for testing
      // and show toast and await for the toast to be displayed
      await pumpToast(tester);

      // Confirm that BuiltInBuilder is displayed
      expect(find.byType(BuiltInBuilder), findsOneWidget);

      // Clean up the toasts
      await cleanUpToasts(tester);

      // Verify no toast is displayed after dismissing all toasts
      expect(find.byType(BuiltInBuilder), findsNothing);
    });
  });

  group('show method: advanced tests', () {
    testWidgets('should automatically close after autoCloseDuration',
        (tester) async {
      // Build and display a toast that closes quickly
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
                      title: const Text('AutoClose Title'),
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

      // Trigger the toast
      await tester.tap(find.byKey(const Key('show_auto_close')));
      await tester.pump();
      await tester.pumpAndSettle();

      // Confirm toast appears
      expect(find.text('AutoClose Title'), findsOneWidget);

      // Wait longer than autoCloseDuration plus animation time
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();

      // Verify toast is gone
      expect(find.text('AutoClose Title'), findsNothing);

      // We don't need to clean up the toasts because the toast is already closed
    });


    testWidgets('shows toast with a progress bar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ElevatedButton(
                  key: const Key('show_progress_bar'),
                  onPressed: () {
                    toastification.show(
                      context: context,
                      showProgressBar: true,
                      title: const Text('Progress Bar Toast'),
                    );
                  },
                  child: const Text('Show Progress Toast'),
                ),
              ),
            ),
          ),
        ),
      );

      // Trigger the toast
      await tester.tap(find.byKey(const Key('show_progress_bar')));
      await tester.pump();
      await tester.pumpAndSettle();

      // Confirm the toast and a progress indicator is present
      expect(find.text('Progress Bar Toast'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      // Clean up the toasts
      await cleanUpToasts(tester);
    });
  });
}
