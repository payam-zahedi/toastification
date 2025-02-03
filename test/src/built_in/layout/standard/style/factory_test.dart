import 'package:flutter_test/flutter_test.dart';
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
}
