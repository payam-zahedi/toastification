import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _itemAnimationDuration = Duration(milliseconds: 300);

class ToastificationConfig {
  const ToastificationConfig({
    this.animationDuration = _itemAnimationDuration,
    this.animationBuilder = _defaultAnimationBuilderConfig,
  });

  final Duration animationDuration;
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
  Widget child,
) {
  return DefaultToastWidget(
    animation: animation,
    child: child,
  );
}
