import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/src/core/context_ext.dart';

typedef CloseButtonBuilder = Widget Function(
    BuildContext context, VoidCallback onCloseTap);

class ToastCloseButton extends Equatable {
  const ToastCloseButton({
    this.showType = CloseButtonShowType.always,
    this.buttonBuilder,
  });

  final CloseButtonShowType showType;
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

/// Using this enum you can define the behavior of the toast close button
enum CloseButtonShowType {
  /// [always] - show the close button always
  always._('Always'),

  /// [onHover] - show the close button only when the mouse is hovering the toast
  onHover._('On Hover'),

  /// [none] - do not show the close button
  none._('None');

  const CloseButtonShowType._(this.title);

  final String title;

  @override
  String toString() => title;

  String toValueString() => 'CloseButtonShowType.$name';
}

class ToastCloseButtonHolder extends StatelessWidget {
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

class _DefaultCloseButton extends StatelessWidget {
  const _DefaultCloseButton({
    required this.onCloseTap,
  });

  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    final toastTheme = context.toastTheme;

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
                toastTheme.closeIcon,
                color: toastTheme.closeIconColor,
                size: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}
