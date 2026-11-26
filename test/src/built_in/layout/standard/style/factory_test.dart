import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('StandardToastStyleFactory', () {
    test('creates MinimalStandardToastStyle', () {
      final style = StandardToastStyleFactory.createStyle(
        style: StandardStyle.minimal,
        type: ToastificationType.info,
      );

      expect(style, isA<MinimalStandardToastStyle>());
    });

    test('creates FilledStandardToastStyle', () {
      final style = StandardToastStyleFactory.createStyle(
        style: StandardStyle.fillColored,
        type: ToastificationType.success,
      );

      expect(style, isA<FilledStandardToastStyle>());
    });

    test('creates FlatStandardColoredToastStyle', () {
      final style = StandardToastStyleFactory.createStyle(
        style: StandardStyle.flatColored,
        type: ToastificationType.warning,
      );

      expect(style, isA<FlatStandardColoredToastStyle>());
    });

    test('creates FlatStandardToastStyle', () {
      final style = StandardToastStyleFactory.createStyle(
        style: StandardStyle.flat,
        type: ToastificationType.error,
      );

      expect(style, isA<FlatStandardToastStyle>());
    });

    test('creates SimpleStandardToastStyle', () {
      final style = StandardToastStyleFactory.createStyle(
        style: StandardStyle.simple,
        type: ToastificationType.info,
      );

      expect(style, isA<SimpleStandardToastStyle>());
    });
  });

  group('StandardToastStyleFactory - brightness', () {
    BaseStandardToastStyle createStyle(
      StandardStyle style, {
      StandardStyleValues? providedValues,
    }) {
      return StandardToastStyleFactory.createStyle(
        style: style,
        type: ToastificationType.success,
        providedValues: providedValues,
        brightness: Brightness.dark,
      );
    }

    for (final style in [
      StandardStyle.flat,
      StandardStyle.minimal,
      StandardStyle.simple,
    ]) {
      test('$style keeps the light colors by default', () {
        final toastStyle = StandardToastStyleFactory.createStyle(
          style: style,
          type: ToastificationType.success,
        );

        expect(toastStyle.brightness, Brightness.light);
        expect(toastStyle.backgroundColor, Colors.white);
        expect(toastStyle.foregroundColor, Colors.black);
        expect(toastStyle.borderSide.color, const Color(0xffEBEBEB));
      });

      test('$style uses the dark surface', () {
        final toastStyle = createStyle(style);

        expect(toastStyle.brightness, Brightness.dark);
        expect(toastStyle.backgroundColor, const Color(0xff2B2B2B));
        expect(toastStyle.foregroundColor, Colors.white);
        expect(toastStyle.borderSide.color, const Color(0xff3F3F3F));
      });
    }

    test('flatColored keeps the light colors by default', () {
      final toastStyle = StandardToastStyleFactory.createStyle(
        style: StandardStyle.flatColored,
        type: ToastificationType.success,
      );

      expect(toastStyle.backgroundColor, toastStyle.primaryColor.shade50);
      expect(toastStyle.foregroundColor, Colors.black);
      expect(toastStyle.iconColor, Colors.black);
    });

    test('flatColored tints the dark surface with the type color', () {
      final toastStyle = createStyle(StandardStyle.flatColored);
      final primaryColor = ToastificationType.success.color;

      expect(
        toastStyle.backgroundColor,
        Color.alphaBlend(
          primaryColor.withValues(alpha: .15),
          const Color(0xff2B2B2B),
        ),
      );
      expect(toastStyle.foregroundColor, Colors.white);
      expect(toastStyle.iconColor, Colors.white);
    });

    test('fillColored looks the same as in light', () {
      final dark = createStyle(StandardStyle.fillColored);
      final light = StandardToastStyleFactory.createStyle(
        style: StandardStyle.fillColored,
        type: ToastificationType.success,
      );

      expect(dark.backgroundColor, light.backgroundColor);
      expect(dark.foregroundColor, light.foregroundColor);
    });

    test('provided colors win over the dark defaults', () {
      final toastStyle = createStyle(
        StandardStyle.flat,
        providedValues: const StandardStyleValues(
          surfaceLight: Colors.amber,
          surfaceDark: Colors.indigo,
        ),
      );

      expect(toastStyle.backgroundColor, Colors.amber);
      expect(toastStyle.foregroundColor, Colors.indigo);
    });
  });
}
