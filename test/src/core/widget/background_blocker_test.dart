import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/core/widget/background_blocker.dart';

void main() {
  group('BackgroundBlocker', () {
    testWidgets('uses the blocks callback of the latest widget', (
      tester,
    ) async {
      var backgroundTaps = 0;

      Future<void> pumpBlocker({required bool blocks}) {
        return tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => backgroundTaps++,
                ),
                BackgroundBlocker(
                  blocks: () => blocks,
                  child: const SizedBox.expand(),
                ),
              ],
            ),
          ),
        );
      }

      await pumpBlocker(blocks: true);
      await tester.tapAt(const Offset(20, 20));

      expect(backgroundTaps, 0);

      await pumpBlocker(blocks: false);
      await tester.tapAt(const Offset(20, 20));

      expect(backgroundTaps, 1);
    });
  });
}
