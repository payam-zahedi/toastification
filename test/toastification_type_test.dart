import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/src/built_in/toastification_type.dart';
import 'package:toastification/src/utils/constants_values.dart';

void main() {
  group('ToastificationType', () {
    test('Default types', () {
      expect(ToastificationType.info.name, 'info');
      expect(ToastificationType.info.color, infoColor);
      expect(ToastificationType.info.icon, Iconsax.info_circle_copy);

      expect(ToastificationType.success.name, 'success');
      expect(ToastificationType.success.color, successColor);
      expect(ToastificationType.success.icon, Iconsax.tick_circle_copy);

      expect(ToastificationType.warning.name, 'warning');
      expect(ToastificationType.warning.color, warningColor);
      expect(ToastificationType.warning.icon, Iconsax.danger_copy);

      expect(ToastificationType.error.name, 'error');
      expect(ToastificationType.error.color, errorColor);
      expect(ToastificationType.error.icon, Iconsax.close_circle_copy);
    });

    test('Default types: equality and hashCode', () {
      expect(ToastificationType.info, ToastificationType.info);
      expect(
          ToastificationType.info.hashCode, ToastificationType.info.hashCode);

      expect(ToastificationType.success, ToastificationType.success);
      expect(ToastificationType.success.hashCode,
          ToastificationType.success.hashCode);

      expect(ToastificationType.warning, ToastificationType.warning);
      expect(ToastificationType.warning.hashCode,
          ToastificationType.warning.hashCode);

      expect(ToastificationType.error, ToastificationType.error);
      expect(
          ToastificationType.error.hashCode, ToastificationType.error.hashCode);
    });

    test('Custom types: creation', () {
      const customName = 'custom';
      const customColor = Colors.purple;
      const customIcon = Iconsax.star;

      final customType =
          ToastificationType.custom(customName, customColor, customIcon);

      expect(customType.name, customName);
      expect(customType.color, customColor);
      expect(customType.icon, customIcon);
    });

    test('Custom types: equality and hashCode', () {
      const customType1 =
          ToastificationType.custom('custom', Colors.purple, Iconsax.star);
      const customType2 =
          ToastificationType.custom('custom', Colors.purple, Iconsax.star);
      const customType3 =
          ToastificationType.custom('different', Colors.red, Iconsax.heart);

      expect(customType1, customType2);
      expect(customType1.hashCode, customType2.hashCode);
      expect(customType1, isNot(customType3));
      expect(customType1.hashCode, isNot(customType3.hashCode));
    });
  });
}
