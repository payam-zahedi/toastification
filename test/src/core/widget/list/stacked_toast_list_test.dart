import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/src/core/widget/list/toast_stack.dart';
import 'package:toastification/toastification.dart';

const _colors = [Colors.red, Colors.green, Colors.blue, Colors.orange];

void main() {
  late ToastificationManager manager;
  late OverlayState overlayState;

  /// how many times each toast was built.
  late Map<int, int> builds;

  Future<void> createOverlay(
    WidgetTester tester, {
    Alignment alignment = Alignment.topCenter,
    int maxToastLimit = 10,
  }) async {
    builds = {};
    manager = ToastificationManager(
      alignment: alignment,
      config: ToastificationConfig(
        layout: const ToastificationLayout.stacked(),
        // no margin, so the stack starts at the edge of the 800x600 screen.
        marginBuilder: (context, alignment) => EdgeInsets.zero,
        maxToastLimit: maxToastLimit,
      ),
    );

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

  /// shows [count] toasts, `toast 0` is the oldest one.
  Future<List<ToastificationItem>> showToasts(
    WidgetTester tester,
    int count, {
    void Function(int index)? onTap,
    double Function(int index)? height,
  }) async {
    final items = [
      for (var index = 0; index < count; index++)
        manager.showCustom(
          overlayState: overlayState,
          scheduler: tester.binding,
          builder: (context, item) {
            builds[index] = (builds[index] ?? 0) + 1;

            return GestureDetector(
              onTap: onTap == null ? null : () => onTap(index),
              child: Container(
                key: ValueKey('toast $index'),
                height: height?.call(index) ?? 60,
                color: _colors[index],
              ),
            );
          },
          animationBuilder: null,
          animationDuration: null,
          callbacks: const ToastificationCallbacks(),
        ),
    ];

    await tester.pumpAndSettle();

    return items;
  }

  Finder toast(int index) => find.byKey(ValueKey('toast $index'));

  Future<TestGesture> hover(WidgetTester tester, Offset position) async {
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(gesture.removePointer);
    await gesture.addPointer(location: Offset.zero);
    await gesture.moveTo(position);
    await tester.pumpAndSettle();

    return gesture;
  }

  group('collapsed', () {
    testWidgets('should show the newest toast in front and the older ones '
        'behind it', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 3);

      // the newest toast keeps its size, each older one is 5% smaller and
      // sticks out 8 more.
      expect(tester.getRect(toast(2)), const Rect.fromLTWH(200, 0, 400, 60));
      expect(tester.getRect(toast(1)), const Rect.fromLTRB(210, 11, 590, 68));
      expect(tester.getRect(toast(0)), const Rect.fromLTRB(220, 22, 580, 76));

      expect(tester.getSize(find.byType(ToastStack)), const Size(400, 76));
    });

    testWidgets('should paint the newest toast on top of the others', (
      tester,
    ) async {
      await createOverlay(tester);
      await showToasts(tester, 3);

      expect(
        find.byType(ToastStack),
        paints
          ..rect(color: _colors[0])
          ..rect(color: _colors[1])
          ..rect(color: _colors[2]),
      );
    });

    testWidgets('should not paint more than three toasts', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 4);

      expect(find.byType(ToastStack), isNot(paints..rect(color: _colors[0])));
      expect(tester.getSize(find.byType(ToastStack)), const Size(400, 76));
    });

    testWidgets('should hide the part of a higher toast that the front toast '
        'does not cover', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 2, height: (index) => index == 0 ? 120 : 60);

      // the higher toast starts above the screen and is cut where a toast
      // as high as the front toast would start.
      expect(tester.getRect(toast(0)).top, lessThan(0));
      expect(
        find.byType(ToastStack),
        paints
          ..clipRect(rect: const Rect.fromLTRB(-1e9, 8, 1e9, 1e9))
          ..rect(color: _colors[0]),
      );
    });

    testWidgets('should hide the same part of a higher toast for a bottom '
        'alignment', (tester) async {
      await createOverlay(tester, alignment: Alignment.bottomCenter);
      await showToasts(tester, 2, height: (index) => index == 0 ? 120 : 60);

      expect(tester.getRect(toast(0)).bottom, greaterThan(600));
      expect(
        find.byType(ToastStack),
        paints
          ..clipRect(rect: const Rect.fromLTRB(-1e9, -1e9, 1e9, 60))
          ..rect(color: _colors[0]),
      );
    });

    testWidgets('should grow to the top for a bottom alignment', (
      tester,
    ) async {
      await createOverlay(tester, alignment: Alignment.bottomCenter);
      await showToasts(tester, 2);

      expect(tester.getRect(toast(1)), const Rect.fromLTWH(200, 540, 400, 60));
      expect(tester.getRect(toast(0)), const Rect.fromLTRB(210, 532, 590, 589));
    });

    testWidgets('should move the older toasts back step by step while a new '
        'toast comes in', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 1);

      manager.showCustom(
        overlayState: overlayState,
        scheduler: tester.binding,
        builder: (context, item) => const SizedBox(height: 60),
        animationBuilder: null,
        animationDuration: null,
        callbacks: const ToastificationCallbacks(),
      );
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // half way between the front and the place behind it.
      expect(tester.getRect(toast(0)).bottom, inExclusiveRange(60, 68));
      expect(tester.getRect(toast(0)).width, inExclusiveRange(380, 400));

      await tester.pumpAndSettle();

      expect(tester.getRect(toast(0)), const Rect.fromLTRB(210, 11, 590, 68));
    });

    testWidgets('should give a tap on an older toast to the stack', (
      tester,
    ) async {
      final tapped = <int>[];

      await createOverlay(tester);
      await showToasts(tester, 2, onTap: tapped.add);

      // the part of the older toast that sticks out.
      await tester.tapAt(const Offset(400, 64));
      await tester.pumpAndSettle();

      expect(tapped, isEmpty);
      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 60, 400, 60));
    });
  });

  group('ToastStack', () {
    testWidgets('should follow a new expansion and direction', (tester) async {
      Widget stack({required double expansion, required bool reverse}) {
        final animation = AlwaysStoppedAnimation(expansion);

        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 400,
            child: ToastStack(
              expansion: animation,
              relayout: animation,
              reverse: reverse,
              children: [
                for (var index = 1; index >= 0; index--)
                  SizedBox(key: ValueKey('toast $index'), height: 60),
              ],
            ),
          ),
        );
      }

      await tester.pumpWidget(stack(expansion: 0, reverse: false));

      expect(tester.getRect(toast(0)), const Rect.fromLTRB(10, 11, 390, 68));

      await tester.pumpWidget(stack(expansion: 1, reverse: false));

      expect(tester.getRect(toast(0)), const Rect.fromLTWH(0, 60, 400, 60));

      await tester.pumpWidget(stack(expansion: 1, reverse: true));

      expect(tester.getRect(toast(0)), const Rect.fromLTWH(0, 0, 400, 60));
    });
  });

  group('expand', () {
    testWidgets('should expand to a list while the pointer is over the '
        'stack', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 3);

      final gesture = await hover(tester, const Offset(400, 30));

      expect(tester.getRect(toast(2)), const Rect.fromLTWH(200, 0, 400, 60));
      expect(tester.getRect(toast(1)), const Rect.fromLTWH(200, 60, 400, 60));
      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 120, 400, 60));

      // the pointer is still over the expanded list.
      await gesture.moveTo(const Offset(400, 150));
      await tester.pumpAndSettle();

      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 120, 400, 60));

      await gesture.moveTo(const Offset(400, 300));
      await tester.pumpAndSettle();

      expect(tester.getRect(toast(0)), const Rect.fromLTRB(220, 22, 580, 76));
    });

    testWidgets('should not expand while the pointer is next to the stack', (
      tester,
    ) async {
      await createOverlay(tester);
      await showToasts(tester, 3);

      // below the stack, where the expanded list would be.
      await hover(tester, const Offset(400, 100));

      expect(tester.getSize(find.byType(ToastStack)), const Size(400, 76));
    });

    testWidgets('should not rebuild the toasts', (tester) async {
      await createOverlay(tester);
      await showToasts(tester, 3);

      final buildsBefore = Map.of(builds);

      final gesture = await hover(tester, const Offset(400, 30));
      await gesture.moveTo(const Offset(400, 300));
      await tester.pumpAndSettle();

      expect(builds, buildsBefore);
    });

    testWidgets('should expand on a tap and collapse on a tap outside', (
      tester,
    ) async {
      await createOverlay(tester);
      await showToasts(tester, 2);

      await tester.tapAt(const Offset(400, 30));
      await tester.pumpAndSettle();

      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 60, 400, 60));

      await tester.tapAt(const Offset(400, 300));
      await tester.pumpAndSettle();

      expect(tester.getRect(toast(0)), const Rect.fromLTRB(210, 11, 590, 68));
    });

    testWidgets('should give a tap to an older toast when expanded', (
      tester,
    ) async {
      final tapped = <int>[];

      await createOverlay(tester);
      await showToasts(tester, 2, onTap: tapped.add);

      await hover(tester, const Offset(400, 30));
      await tester.tapAt(const Offset(400, 90));

      expect(tapped, [0]);
    });
  });

  group('dismiss', () {
    testWidgets('should play the exit animation of a toast', (tester) async {
      await createOverlay(tester);
      final items = await showToasts(tester, 2);

      manager.dismiss(items.last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // the toast is on its way out, the older one on its way to the front.
      expect(toast(1), findsOneWidget);
      expect(tester.getRect(toast(0)).width, inExclusiveRange(380, 400));

      await tester.pumpAndSettle();

      expect(toast(1), findsNothing);
      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 0, 400, 60));
    });

    testWidgets('should remove a toast at once without the animation', (
      tester,
    ) async {
      await createOverlay(tester);
      final items = await showToasts(tester, 2);

      manager.dismiss(items.last, showRemoveAnimation: false);
      await tester.pump();

      expect(toast(1), findsNothing);
      expect(tester.getRect(toast(0)), const Rect.fromLTWH(200, 0, 400, 60));

      // the manager disposes the item after a delay.
      await tester.pump(const Duration(milliseconds: 50));
    });

    testWidgets('should remove the overlay after the last toast', (
      tester,
    ) async {
      await createOverlay(tester);
      final items = await showToasts(tester, 2);

      // the exit of the first one is still running when the second one ends.
      manager.dismiss(items.first);
      await tester.pump(const Duration(milliseconds: 100));
      manager.dismiss(items.last, showRemoveAnimation: false);
      await tester.pump(const Duration(milliseconds: 100));

      expect(manager.overlayEntry, isNotNull);

      await tester.pumpAndSettle();

      expect(manager.overlayEntry, isNull);
    });

    testWidgets('should keep the newest toasts within maxToastLimit', (
      tester,
    ) async {
      await createOverlay(tester, maxToastLimit: 2);
      await showToasts(tester, 4);

      expect(toast(3), findsOneWidget);
      expect(toast(2), findsOneWidget);
      expect(toast(1), findsNothing);
      expect(toast(0), findsNothing);
    });
  });
}
