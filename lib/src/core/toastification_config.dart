import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _defaultAlignment = AlignmentDirectional.topEnd;
const _itemAnimationDuration = Duration(milliseconds: 600);
const _defaultWidth = 400.0;
const _defaultClipBehavior = Clip.none;


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
  });

  final AlignmentGeometry alignment;
  final double itemWidth;

  /// The ClipBehavior of [AnimatedList], used as entry point for all [ToastificationItem]s' widgets under the hood. The default value is [Clip.none].
  final Clip clipBehavior;
  final Duration animationDuration;
  final ToastificationAnimationBuilder animationBuilder;
  final EdgeInsetsGeometry Function(BuildContext context, AlignmentGeometry alignment) marginBuilder;

  // Copy with method for ToastificationConfig
  ToastificationConfig copyWith({
    AlignmentGeometry? alignment,
    double? itemWidth,
    Clip? clipBehavior,
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
    EdgeInsetsGeometry Function(BuildContext context, AlignmentGeometry alignment)? marginBuilder,
  }) {
    return ToastificationConfig(
      alignment: alignment ?? this.alignment,
      itemWidth: itemWidth ?? this.itemWidth,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      marginBuilder: marginBuilder ?? this.marginBuilder,
    );
  }

  @override
  List<Object?> get props => [
        alignment,
        itemWidth,
        animationDuration,
        marginBuilder,
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
EdgeInsetsGeometry _defaultMarginBuilder(BuildContext context, AlignmentGeometry alignment) {
  final y = alignment.resolve(Directionality.of(context)).y;
  final kbdBottomMargin = MediaQuery.of(context).viewInsets.bottom;

  log('Margin builder called with y: $y');
  log('Margin builder called with alignment: $alignment');

  return switch (y) {
    <= -0.5 => const EdgeInsets.only(top: 12),
    >= 0.5 => EdgeInsets.only(bottom: 12 + kbdBottomMargin),
    _ => EdgeInsets.zero,
  };
}
