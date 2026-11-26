import 'package:equatable/equatable.dart';

/// Decides how the toasts of one alignment are laid out.
///
/// set it with [ToastificationConfig.layout].
sealed class ToastificationLayout extends Equatable {
  const ToastificationLayout();

  /// the toasts are shown one after another in a list.
  ///
  /// This is the default value.
  const factory ToastificationLayout.list() = ToastificationListLayout;

  /// the toasts overlap in a compact stack, with the newest one in front.
  ///
  /// the stack expands to the list when the pointer hovers over it or when
  /// it is tapped, and collapses again when the pointer leaves it or when
  /// something else is tapped.
  const factory ToastificationLayout.stacked() = ToastificationStackedLayout;

  @override
  List<Object?> get props => [];
}

/// The layout of [ToastificationLayout.list].
final class ToastificationListLayout extends ToastificationLayout {
  const ToastificationListLayout();
}

/// The layout of [ToastificationLayout.stacked].
final class ToastificationStackedLayout extends ToastificationLayout {
  const ToastificationStackedLayout();
}
