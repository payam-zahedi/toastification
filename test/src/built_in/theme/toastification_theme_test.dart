import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  late ThemeData flutterTheme;
  late ToastificationThemeData themeData;

  setUp(() {
    flutterTheme = ThemeData.light();
    themeData = ToastificationThemeData(
      flutterTheme: flutterTheme,
      direction: TextDirection.ltr,
    );
  });

  group('ToastificationTheme', () {
    testWidgets('can be accessed using of() method', (tester) async {
      late ToastificationThemeData retrievedTheme;

      await tester.pumpWidget(
        ToastificationTheme(
          themeData: themeData,
          child: Builder(
            builder: (context) {
              retrievedTheme = ToastificationTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(retrievedTheme, equals(themeData));
    });

    testWidgets('updates when theme data changes', (tester) async {
      late ToastificationThemeData retrievedTheme;

      Widget buildWidget(ToastificationThemeData data) {
        return ToastificationTheme(
          themeData: data,
          child: Builder(
            builder: (context) {
              retrievedTheme = ToastificationTheme.of(context);
              return const SizedBox();
            },
          ),
        );
      }

      await tester.pumpWidget(buildWidget(themeData));
      expect(retrievedTheme, equals(themeData));

      final updatedTheme = themeData.copyWith(
        direction: TextDirection.rtl,
        showProgressBar: true,
      );

      await tester.pumpWidget(buildWidget(updatedTheme));
      expect(retrievedTheme, equals(updatedTheme));
      expect(retrievedTheme, isNot(equals(themeData)));
    });

    testWidgets('throws assertion error when no theme is found',
        (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(
              () => ToastificationTheme.of(context),
              throwsAssertionError,
            );
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('wrap creates new ToastificationTheme instance',
        (tester) async {
      late BuildContext testContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      final theme = ToastificationTheme(
        themeData: themeData,
        child: const SizedBox(),
      );

      final wrapped = theme.wrap(
        testContext,
        const SizedBox(),
      );

      expect(wrapped, isA<ToastificationTheme>());
      expect((wrapped as ToastificationTheme).themeData, equals(themeData));
    });
  });
}
