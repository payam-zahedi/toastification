import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  group('ToastificationConfig', () {
    test('default values', () {
      const config = ToastificationConfig();
      expect(config.alignment, defaultAlignment);
      expect(config.itemWidth, defaultWidth);
      expect(config.clipBehavior, defaultClipBehavior);
      expect(config.animationDuration, defaultItemAnimationDuration);
      expect(config.marginBuilder, defaultMarginBuilder);
      expect(config.maxToastLimit, 10);
      expect(config.applyMediaQueryViewInsets, true);
    });

    test('custom constructor', () {
      final config = ToastificationConfig(
        alignment: Alignment.bottomCenter,
        itemWidth: 500,
        clipBehavior: Clip.antiAlias,
        animationDuration: Duration(seconds: 1),
        animationBuilder: (context, animation, alignment, child) => child,
        marginBuilder: (context, alignment) => EdgeInsets.zero,
        maxToastLimit: 5,
        applyMediaQueryViewInsets: false,
      );

      expect(config.alignment, Alignment.bottomCenter);
      expect(config.itemWidth, 500);
      expect(config.clipBehavior, Clip.antiAlias);
      expect(config.animationDuration, Duration(seconds: 1));
      expect(config.marginBuilder, isNotNull);
      expect(config.maxToastLimit, 5);
      expect(config.applyMediaQueryViewInsets, false);
    });

    test('copyWith updates properties', () {
      const config = ToastificationConfig();
      final updated = config.copyWith(
        alignment: Alignment.bottomCenter,
        itemWidth: 300,
        clipBehavior: Clip.antiAlias,
        animationBuilder: (context, animation, alignment, child) => child,
        marginBuilder: (context, alignment) => EdgeInsets.zero,
        animationDuration: Duration(seconds: 1),
        maxToastLimit: 5,
        applyMediaQueryViewInsets: false,
      );

      expect(updated.itemWidth, 300);
      expect(updated.maxToastLimit, 5);
      expect(updated.applyMediaQueryViewInsets, false);
      expect(updated.alignment, Alignment.bottomCenter);
      expect(updated.clipBehavior, Clip.antiAlias);
      expect(updated.animationDuration, Duration(seconds: 1));
      expect(updated.marginBuilder, isNotNull);
    });

    test('equals | returns true for unchanged copyWith check', () {
      const config = ToastificationConfig();
      final updated = config.copyWith();
      expect(config, updated);
    });

    test('equals | returns false for changed copyWith check', () {
      const config = ToastificationConfig();
      final updated = config.copyWith(
        alignment: Alignment.bottomCenter,
        itemWidth: 300,
        clipBehavior: Clip.antiAlias,
        animationBuilder: (context, animation, alignment, child) => child,
        marginBuilder: (context, alignment) => EdgeInsets.zero,
        animationDuration: Duration(seconds: 1),
        maxToastLimit: 5,
        applyMediaQueryViewInsets: false,
      );

      expect(config == updated, false);
      expect(config, isNot(equals(updated)));
    });

    test('hashCode', () {
      const config = ToastificationConfig();
      final updated = config.copyWith(
        alignment: Alignment.bottomCenter,
        itemWidth: 300,
        clipBehavior: Clip.antiAlias,
        animationBuilder: (context, animation, alignment, child) => child,
        marginBuilder: (context, alignment) => EdgeInsets.zero,
        animationDuration: Duration(seconds: 1),
        maxToastLimit: 5,
        applyMediaQueryViewInsets: false,
      );

      expect(config.hashCode, isNot(updated.hashCode));
    });
  });
}
