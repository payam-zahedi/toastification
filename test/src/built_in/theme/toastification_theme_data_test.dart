import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  late ThemeData theme;
  late FlatStandardToastStyle flatStyle;
  late MinimalStandardToastStyle minimalStyle;

  setUp(() {
    theme = ThemeData.light();
    flatStyle = FlatStandardToastStyle(
      type: ToastificationType.success,
      flutterTheme: theme,
    );
    minimalStyle = MinimalStandardToastStyle(
      type: ToastificationType.success,
      flutterTheme: theme,
    );
  });

  group('ToastificationThemeData', () {
    group('initialization', () {
      test('default values', () {
        final themeData = ToastificationThemeData(
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        expect(themeData.toastStyle, isNull);
        expect(themeData.flutterTheme, equals(theme));
        expect(themeData.direction, equals(TextDirection.ltr));
        expect(themeData.showProgressBar, isFalse);
        expect(themeData.applyBlurEffect, isFalse);
        expect(themeData.showIcon, isTrue);
      });

      test('custom values', () {
        final themeData = ToastificationThemeData(
          toastStyle: flatStyle,
          flutterTheme: theme,
          direction: TextDirection.rtl,
          showProgressBar: true,
          applyBlurEffect: true,
          showIcon: false,
        );

        expect(themeData.toastStyle, equals(flatStyle));
        expect(themeData.direction, equals(TextDirection.rtl));
        expect(themeData.showProgressBar, isTrue);
        expect(themeData.applyBlurEffect, isTrue);
        expect(themeData.showIcon, isFalse);
      });
    });

    group('copyWith', () {
      test('no modifications', () {
        final originalTheme = ToastificationThemeData(
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        expect(originalTheme.copyWith(), equals(originalTheme));
      });

      test('partial modifications', () {
        final originalTheme = ToastificationThemeData(
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        final modifiedTheme = originalTheme.copyWith(
          toastStyle: flatStyle,
          direction: TextDirection.rtl,
          showProgressBar: true,
          applyBlurEffect: true,
          showIcon: false,
        );

        expect(modifiedTheme.toastStyle, equals(flatStyle));
        expect(modifiedTheme.direction, equals(TextDirection.rtl));
        expect(modifiedTheme.showProgressBar, isTrue);
        expect(modifiedTheme.applyBlurEffect, isTrue);
        expect(modifiedTheme.showIcon, isFalse);
      });
    });

    group('equality', () {
      test('equal properties', () {
        final instance1 = ToastificationThemeData(
          toastStyle: flatStyle,
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );
        final instance2 = ToastificationThemeData(
          toastStyle: flatStyle,
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        expect(instance1, equals(instance2));
        expect(instance1.hashCode, equals(instance2.hashCode));
      });

      test('different properties', () {
        final baseTheme = ToastificationThemeData(
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        final variations = [
          baseTheme.copyWith(direction: TextDirection.rtl),
          baseTheme.copyWith(showProgressBar: true),
          baseTheme.copyWith(applyBlurEffect: true),
          baseTheme.copyWith(showIcon: false),
          baseTheme.copyWith(toastStyle: flatStyle),
          baseTheme.copyWith(toastStyle: minimalStyle),
        ];

        for (final variation in variations) {
          expect(baseTheme, isNot(equals(variation)));
          expect(variation, isNot(equals(baseTheme)));
        }
      });

      test('different toast styles', () {
        final baseTheme = ToastificationThemeData(
          flutterTheme: theme,
          direction: TextDirection.ltr,
        );

        final themeWithFlat = baseTheme.copyWith(toastStyle: flatStyle);
        final themeWithMinimal = baseTheme.copyWith(toastStyle: minimalStyle);

        expect(themeWithFlat, isNot(equals(themeWithMinimal)));
      });
    });
  });
}
