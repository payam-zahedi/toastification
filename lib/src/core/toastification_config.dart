import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _defaultAlignment = AlignmentDirectional.topEnd;
const _itemAnimationDuration = Duration(milliseconds: 600);
const _defaultWidth = 400.0;
const _defaultMargin = EdgeInsets.symmetric(vertical: 32);

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
/// 
class ToastificationConfig extends Equatable {
  const ToastificationConfig({
    this.alignment = _defaultAlignment,
    this.animationDuration = _itemAnimationDuration,
    this.animationBuilder = _defaultAnimationBuilderConfig,
    this.itemWidth = _defaultWidth,
    this.margin = _defaultMargin,
  });

  final AlignmentGeometry alignment;
  final Duration animationDuration;
  final ToastificationAnimationBuilder animationBuilder;
  final double itemWidth;
  final EdgeInsetsGeometry margin;

  // Copy with method for ToastificationConfig
  ToastificationConfig copyWith({
    AlignmentGeometry? alignment,
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
    double? itemWidth,
    EdgeInsetsGeometry? margin,
  }) {
    return ToastificationConfig(
      alignment: alignment ?? this.alignment,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      itemWidth: itemWidth ?? this.itemWidth,
      margin: margin ?? this.margin,
    );
  }

  @override
  List<Object?> get props => [
        alignment,
        animationDuration,
        itemWidth,
        margin,
      ];
}

Widget _defaultAnimationBuilderConfig(
  BuildContext context,
  Animation<double> animation,
  Alignment alignment,
  Widget child,
) {
  return ToastificationTransition(
    animation: animation,
    alignment: alignment,
    child: child,
  );
}
