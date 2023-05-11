import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _defaultAlignment = AlignmentDirectional.topEnd;
const _itemAnimationDuration = Duration(milliseconds: 300);

class ToastificationConfig {
  const ToastificationConfig({
    this.alignment = _defaultAlignment,
    this.animationDuration = _itemAnimationDuration,
    this.animationBuilder = _defaultAnimationBuilderConfig,
  });

  final Duration animationDuration;
  final AlignmentGeometry alignment;
  final ToastificationAnimationBuilder animationBuilder;

  // Copy with method for ToastificationConfig

  ToastificationConfig copyWith({
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
  }) {
    return ToastificationConfig(
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToastificationConfig &&
          other.animationDuration == animationDuration &&
          other.animationBuilder == animationBuilder;

  @override
  int get hashCode => animationDuration.hashCode ^ animationBuilder.hashCode;
}

Widget _defaultAnimationBuilderConfig(
  BuildContext context,
  Animation<double> animation,
  Alignment alignment,
  Widget child,
) {
  return DefaultToastTransition(
    animation: animation,
    alignment: alignment,
    child: child,
  );
}
