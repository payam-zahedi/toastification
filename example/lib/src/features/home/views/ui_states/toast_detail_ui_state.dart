import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:toastification/toastification.dart';

part 'toast_detail_ui_state.freezed.dart';

@freezed
class ToastDetail with _$ToastDetail {
  factory ToastDetail({
    ToastificationType? type,
    @Default(ToastificationStyle.flat) ToastificationStyle style,
    // placement
    @Default(Alignment.topRight) AlignmentGeometry alignment,
    @Default('Toast Title') String title,
    String? description,
    Widget? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? iconColor,
    BorderRadiusGeometry? borderRadius,
    double? elevation,
    TextDirection? direction,
    Duration? autoCloseDuration,
    Duration? animationDuration,
    VoidCallback? onCloseTap,
    @Default(true) bool newestOnTop,
    @Default(true) bool showProgressBar,
    @Default(true) bool showCloseButton,
    @Default(true) bool closeOnClick,
    @Default(true) bool pauseOnHover,
    @Default(false) bool dragToClose,
  }) = _ToastDetail;
}
