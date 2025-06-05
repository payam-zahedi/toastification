import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('StandardStyleValues', () {
    test('should have correct properties', () {
      const values = StandardStyleValues(
        primaryColor: Colors.blue,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
        padding: EdgeInsets.all(8.0),
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
        progressIndicatorStrokeWidth: 4.0,
      );

      expect(values.primaryColor, Colors.blue);
      expect(values.surfaceLight, Colors.white);
      expect(values.surfaceDark, Colors.black);
      expect(values.padding, EdgeInsets.all(8.0));
      expect(values.borderSide, BorderSide(color: Colors.red));
      expect(values.borderRadius, BorderRadius.all(Radius.circular(8.0)));
      expect(values.boxShadow, [
        BoxShadow(
          color: Colors.red,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ]);
      expect(values.progressIndicatorStrokeWidth, 4.0);
    });

    test('should support value equality', () {
      const values1 = StandardStyleValues(
        primaryColor: Colors.blue,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
      );
      const values2 = StandardStyleValues(
        primaryColor: Colors.blue,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
      );

      expect(values1, values2);
    });
  });

  group('DefaultStyleValues', () {
    test('should have correct default properties', () {
      const values = DefaultStyleValues(
        primaryColor: Colors.blue,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
      );

      expect(values.primaryColor, Colors.blue);
      expect(values.surfaceLight, Colors.white);
      expect(values.surfaceDark, Colors.black);
      expect(values.padding, EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16));
      expect(values.borderSide, BorderSide(color: Colors.black12));
      expect(values.borderRadius, BorderRadius.all(Radius.circular(12)));
      expect(values.boxShadow, []);
      expect(values.progressIndicatorStrokeWidth, 2.0);
    });
  });

  group('BaseStandardToastStyle', () {
    test('should have correct default properties', () {
      final style = TestToastStyle(
        type: ToastificationType.success,
        providedValues: const StandardStyleValues(
          primaryColor: Colors.blue,
          surfaceLight: Colors.white,
          surfaceDark: Colors.black,
        ),
      );

      expect(style.primaryColor, Colors.blue);
      expect(style.backgroundColor, Colors.white);
      expect(style.foregroundColor, Colors.black);
      expect(style.icon, ToastificationType.success.icon);
      expect(style.closeIcon, Icons.close);
      expect(style.closeIconColor, Colors.black.withAlpha(102));
      expect(style.padding, EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16));
      expect(style.borderSide, BorderSide(color: Colors.black12));
      expect(style.borderRadius, BorderRadius.all(Radius.circular(12)));
      expect(style.elevation, 0.0);
      expect(style.boxShadow, []);
      expect(style.progressIndicatorStrokeWidth, 2.0);
    });
  });
}

class TestToastStyle extends BaseStandardToastStyle {
  const TestToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => const DefaultStyleValues(
        primaryColor: Colors.blue,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
      );

  @override
  Color get iconColor => Colors.red;
}
