import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _defaultAlignment = AlignmentDirectional.topEnd;
const _itemAnimationDuration = Duration(milliseconds: 600);
const _defaultWidth = 400.0;
const _defaultClipBehavior = Clip.none;

typedef ToastificationMarginBuilder = EdgeInsetsGeometry Function(
    BuildContext context, AlignmentGeometry alignment);

/// you can use [ToastificationConfig] class to change default values of [Toastification]
///
/// when you are using [show] or [showCustom] methods,
/// if some of the parameters are not provided,
///
/// [Toastification] will use this class to get the default values.
///
/// to provide the [ToastificationConfig] to the widget tree you can use
/// the [ToastificationConfigProvider] widget.
///
class ToastificationConfig extends Equatable {
  const ToastificationConfig({
    this.alignment = _defaultAlignment,
    this.itemWidth = _defaultWidth,
    this.clipBehavior = _defaultClipBehavior,
    this.animationDuration = _itemAnimationDuration,
    this.animationBuilder = _defaultAnimationBuilderConfig,
    this.marginBuilder = _defaultMarginBuilder,
    this.applyMediaQueryViewInsets = true,
  });

  final AlignmentGeometry alignment;
  final double itemWidth;

  /// The ClipBehavior of [AnimatedList], used as entry point for all [ToastificationItem]s' widgets under the hood. The default value is [Clip.none].
  final Clip clipBehavior;

  /// The duration of the animation for [ToastificationItem]s. The default value is 600 milliseconds.
  final Duration animationDuration;

  final ToastificationAnimationBuilder animationBuilder;

  /// Builder method for creating margin for Toastification Overlay.
  final ToastificationMarginBuilder marginBuilder;

  /// Whether to apply the viewInsets to the margin of the Toastification Overlay.
  /// Basically, this is used to move the Toastification Overlay up or down when the keyboard is shown.
  /// So Toast overlay will not be hidden by the keyboard when the keyboard is shown.
  ///
  /// If set to true, MediaQuery.of(context).viewInsets will be added to the result of the [marginBuilder] method.
  final bool applyMediaQueryViewInsets;

  // Copy with method for ToastificationConfig
  ToastificationConfig copyWith({
    AlignmentGeometry? alignment,
    double? itemWidth,
    Clip? clipBehavior,
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
    ToastificationMarginBuilder? marginBuilder,
    bool? applyMediaQueryViewInsets,
  }) {
    return ToastificationConfig(
      alignment: alignment ?? this.alignment,
      itemWidth: itemWidth ?? this.itemWidth,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      marginBuilder: marginBuilder ?? this.marginBuilder,
      applyMediaQueryViewInsets:
          applyMediaQueryViewInsets ?? this.applyMediaQueryViewInsets,
    );
  }

  @override
  List<Object?> get props => [
        alignment,
        itemWidth,
        clipBehavior,
        animationDuration,
        marginBuilder,
        applyMediaQueryViewInsets,
      ];
}

/// Default animation builder for [Toastification]
Widget _defaultAnimationBuilderConfig(
  BuildContext context,
  Animation<double> animation,
  Alignment alignment,
  Widget child,
) {
  return DefaultToastificationTransition(
    animation: animation,
    alignment: alignment,
    child: child,
  );
}

/// Default margin builder for [Toastification]
EdgeInsetsGeometry _defaultMarginBuilder(
  BuildContext context,
  AlignmentGeometry alignment,
) {
  final y = alignment.resolve(Directionality.of(context)).y;

  return switch (y) {
    <= -0.5 => const EdgeInsets.only(top: 12),
    >= 0.5 => const EdgeInsets.only(bottom: 12),
    _ => EdgeInsets.zero,
  };
}
