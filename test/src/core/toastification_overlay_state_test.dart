import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/core/toastification_overlay_state.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('ToastificationOverlayState', () {
    testWidgets('ToastificationWrapper initializes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ToastificationWrapper(
          child: MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ),
        ),
      );

      expect(find.byType(ToastificationWrapper), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('ToastificationWrapper with custom config',
        (WidgetTester tester) async {
      final config = ToastificationConfig(
        alignment: Alignment.topLeft,
        animationDuration: const Duration(milliseconds: 300),
      );

      late final ToastificationConfig providedConfig;

      await tester.pumpWidget(
        ToastificationWrapper(
          config: config,
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  providedConfig =
                      ToastificationConfigProvider.of(context).config;

                  return Container();
                },
              ),
            ),
          ),
        ),
      );

      expect(providedConfig, isNotNull);
      expect(providedConfig, equals(config));
      expect(providedConfig.alignment, equals(Alignment.topLeft));
      expect(
        providedConfig.animationDuration,
        equals(const Duration(milliseconds: 300)),
      );
    });

    testWidgets('throws error when no Navigator is found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ToastificationWrapper(
          child: Container(),
        ),
      );

      expect(
        () => findToastificationOverlayState().overlayState,
        throwsAssertionError,
      );
    });

    testWidgets('findToastificationOverlayState throws when not initialized',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(),
        ),
      );

      expect(
        () => findToastificationOverlayState(),
        throwsAssertionError,
      );
    });

    testWidgets('overlayState is accessible when properly initialized',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ToastificationWrapper(
          child: MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ),
        ),
      );

      final overlayState = findToastificationOverlayState().overlayState;

      expect(overlayState, isNotNull);
    });

    testWidgets('global config is accessible', (WidgetTester tester) async {
      final testConfig = ToastificationConfig(
        alignment: Alignment.bottomCenter,
        animationDuration: const Duration(seconds: 1),
      );

      await tester.pumpWidget(
        ToastificationWrapper(
          config: testConfig,
          child: MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ),
        ),
      );

      final globalConfig = findToastificationOverlayState().globalConfig;
      expect(globalConfig, isNotNull);
      expect(globalConfig?.alignment, equals(Alignment.bottomCenter));
      expect(
        globalConfig?.animationDuration,
        equals(const Duration(seconds: 1)),
      );
    });
  });
}
