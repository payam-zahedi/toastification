import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/core/widget/toastification_config_provider.dart';

void main() {
  group('ToastificationConfigProvider', () {
    final config = ToastificationConfig();
    final differentConfig = ToastificationConfig(
      animationDuration: const Duration(seconds: 1),
      alignment: Alignment.topCenter,
    );

    testWidgets('provides config to widget tree', (tester) async {
      ToastificationConfig? result;

      await tester.pumpWidget(
        ToastificationConfigProvider(
          config: config,
          child: Builder(
            builder: (context) {
              result = ToastificationConfigProvider.of(context).config;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, equals(config));
    });

    testWidgets('maybeOf returns null when no provider exists', (tester) async {
      ToastificationConfigProvider? result;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            result = ToastificationConfigProvider.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(result, isNull);
    });

    testWidgets('of throws assertion error when no provider exists',
        (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(
              () => ToastificationConfigProvider.of(context),
              throwsAssertionError,
            );
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('updateShouldNotify returns true when config changes',
        (tester) async {
      final provider = ToastificationConfigProvider(
        config: config,
        child: const SizedBox(),
      );

      final shouldUpdate = provider.updateShouldNotify(
        ToastificationConfigProvider(
          config: differentConfig,
          child: const SizedBox(),
        ),
      );

      expect(shouldUpdate, isTrue);
    });
  });
}
