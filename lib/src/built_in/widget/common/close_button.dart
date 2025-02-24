import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';

/// Signature for a function that builds a custom close button widget.
///
/// [context] The build context.
/// [onClose] Callback function when the close button is tapped.
typedef CloseButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback onClose,
);

/// Configuration class for toast close button customization.
///
/// This class allows you to customize the behavior and appearance of the close button
/// in toast notifications.
class ToastCloseButton extends Equatable {
  /// Creates a [ToastCloseButton] instance.
  ///
  /// [showType] determines when the close button should be visible.
  /// [buttonBuilder] optional custom builder for the close button widget.
  const ToastCloseButton({
    this.showType = CloseButtonShowType.always,
    this.buttonBuilder,
  });

  /// Defines when the close button should be shown
  final CloseButtonShowType showType;

  /// Custom builder for the close button widget
  final CloseButtonBuilder? buttonBuilder;

  ToastCloseButton copyWith({
    CloseButtonShowType? showType,
    CloseButtonBuilder? buttonBuilder,
  }) {
    return ToastCloseButton(
      showType: showType ?? this.showType,
      buttonBuilder: buttonBuilder ?? this.buttonBuilder,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [showType, buttonBuilder];
}

/// Defines the visibility behavior of the toast close button.
///
/// This enum provides three different modes for controlling when
/// the close button should be visible in the toast notification.
enum CloseButtonShowType {
  /// Shows the close button at all times
  always._('Always'),

  /// Shows the close button only when the mouse hovers over the toast
  onHover._('On Hover'),

  /// Never shows the close button
  none._('None');

  const CloseButtonShowType._(this.title);

  final String title;

  @override
  String toString() => title;

  String toValueString() => 'CloseButtonShowType.$name';
}

/// A widget that manages the display and animation of the toast close button.
///
/// This widget handles the visibility transitions and positioning of the close button
/// based on the provided configuration.
class ToastCloseButtonHolder extends StatelessWidget {
  /// Creates a [ToastCloseButtonHolder] instance.
  ///
  /// [onCloseTap] Callback function when the close button is tapped.
  /// [showCloseButton] Controls the visibility of the close button.
  /// [toastCloseButton] Configuration for the close button appearance and behavior.
  const ToastCloseButtonHolder({
    super.key,
    required this.onCloseTap,
    required this.showCloseButton,
    required this.toastCloseButton,
  });

  final VoidCallback onCloseTap;
  final bool showCloseButton;
  final ToastCloseButton toastCloseButton;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !showCloseButton,
      child: SizedBox(
        height: 30,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: 1,
                child: child,
              ),
            );
          },
          child: showCloseButton
              ? SizedBox(
                  key: const ValueKey('close_button_visible'),
                  child: toastCloseButton.buttonBuilder
                          ?.call(context, onCloseTap) ??
                      _DefaultCloseButton(onCloseTap: onCloseTap),
                )
              : const SizedBox.shrink(
                  key: ValueKey('close_button_hidden'),
                ),
        ),
      ),
    );
  }
}

/// The default close button implementation.
///
/// This widget provides the standard close button appearance and behavior
/// when no custom button builder is provided.
class _DefaultCloseButton extends StatelessWidget {
  const _DefaultCloseButton({
    required this.onCloseTap,
  });

  /// Callback function executed when the close button is tapped
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    final toastStyle = context.toastTheme.toastStyle!;

    return SizedBox.square(
      dimension: 30,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: Builder(
          builder: (context) {
            return InkWell(
              onTap: onCloseTap,
              borderRadius: BorderRadius.circular(5),
              child: Icon(
                toastStyle.closeIcon,
                color: toastStyle.closeIconColor,
                size: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}
