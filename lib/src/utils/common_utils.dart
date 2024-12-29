/// ToastHelper is a helper class that contains some useful utility methods like [convertRange] and [createMaterialColor]
class CommonUtils {
  const CommonUtils._();

  /// Converts a value from one range to another
  ///
  /// example:
  /// ```dart
  /// convertRange(0, 100, 0, 1, 50) // returns 0.5
  /// ```
  ///
  static double convertRange(
    double originalStart,
    double originalEnd,
    double newStart,
    double newEnd,
    double value,
  ) {
    double scale = (newEnd - newStart) / (originalEnd - originalStart);
    return (newStart + ((value - originalStart) * scale));
  }
}
