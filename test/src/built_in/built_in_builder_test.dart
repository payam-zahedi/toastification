import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/built_in/built_in_builder.dart';
import 'package:toastification/toastification.dart';

/// Creates a [ToastificationItem] for testing purposes.
ToastificationItem createTestSampleItem() {
  return ToastificationItem(
    builder: (context, item) => const SizedBox(),
    alignment: Alignment.topRight,
  );
}

// TODO(payam): add more parameters to this function to able to test more features of the BuiltInBuilder in the future
/// Wraps a [BuiltInBuilder] in a minimal widget tree for testing.
Widget buildTestApp({
  required ToastificationItem item,
  ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  MouseCursor? onHoverMouseCursor,
}) {
  return MaterialApp(
    home: Scaffold(
      body: BuiltInBuilder(
        item: item,
        title: const Text('Test Toast'),
        closeButton: const ToastCloseButton(),
        callbacks: callbacks,
        onHoverMouseCursor: onHoverMouseCursor,
      ),
    ),
  );
}

void main() {
  group('BuiltInBuilder - onHoverMouseCursor', () {
    testWidgets(
        'should not add MouseRegion with click cursor when onHoverMouseCursor is not provided',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildTestApp(item: item));
      await tester.pumpAndSettle();

      expect(
        find.byKey(BuiltInBuilderKeys.mouseRegion),
        findsNothing,
      );
    });

    testWidgets(
        'should add MouseRegion with click cursor when onHoverMouseCursor is SystemMouseCursors.click',
        (tester) async {
      final item = createTestSampleItem();

      await tester.pumpWidget(buildTestApp(
        item: item,
        onHoverMouseCursor: SystemMouseCursors.click,
      ));
      await tester.pumpAndSettle();

      final mouseRegionFinder = find.byKey(BuiltInBuilderKeys.mouseRegion);
      expect(mouseRegionFinder, findsOneWidget);

      final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder);
      expect(mouseRegion.cursor, SystemMouseCursors.click);
    });
  });
}
