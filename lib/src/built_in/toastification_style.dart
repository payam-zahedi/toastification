/// Defines the visual style of built-in toast notifications.
///
/// The style affects how the toast notification is rendered, including its
/// background, borders, colors, and overall visual presentation.
///
/// Available styles:
/// * [minimal] - A clean, minimalist design with subtle borders
/// * [fillColored] - Full background color based on the toast type
/// * [flatColored] - Combines flat design with type-based colors
/// * [flat] - Modern flat design with neutral colors
/// * [simple] - Basic text-only toast without icons or decorations
///
/// Usage example:
/// ```dart
/// toastification.show(
///   title: Text('Hello'),
///   style: ToastificationStyle.flat,
///   type: ToastificationType.success,
/// );
/// ```
enum ToastificationStyle {
  /// A minimalist design with subtle borders and clean appearance
  minimal,

  /// Full colored background based on the toast type (info, success, warning, error)
  fillColored,

  /// Flat design with colors determined by the toast type
  flatColored,

  /// Modern flat design with consistent neutral colors
  flat,

  /// Basic text-only toast without icons or additional styling
  /// Useful for simple message displays
  simple,
}
