import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/src/utils/common_utils.dart';

void main() {
  group('CommonUtils', () {
    group('convertRange', () {
      test('should convert value from one range to another correctly', () {
        // Test case 1: Convert 50 from range 0-100 to range 0-1
        expect(
          CommonUtils.convertRange(0, 100, 0, 1, 50),
          equals(0.5),
        );

        // Test case 2: Convert 75 from range 0-100 to range 0-1
        expect(
          CommonUtils.convertRange(0, 100, 0, 1, 75),
          equals(0.75),
        );

        // Test case 3: Convert value with negative ranges
        expect(
          CommonUtils.convertRange(-100, 100, -1, 1, 0),
          equals(0.0),
        );

        // Test case 4: Convert value with decimal input
        expect(
          CommonUtils.convertRange(0, 10, 0, 100, 5.5),
          equals(55.0),
        );
      });

      test('should handle edge cases', () {
        // Test minimum value
        expect(
          CommonUtils.convertRange(0, 100, 0, 1, 0),
          equals(0.0),
        );

        // Test maximum value
        expect(
          CommonUtils.convertRange(0, 100, 0, 1, 100),
          equals(1.0),
        );

        // Test value outside range (should still work based on the formula)
        expect(
          CommonUtils.convertRange(0, 100, 0, 1, 150),
          equals(1.5),
        );
      });
    });
  });
}
