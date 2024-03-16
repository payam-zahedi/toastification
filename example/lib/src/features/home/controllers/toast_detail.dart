import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

final toastDetailControllerProvider =
    StateNotifierProvider<ToastDetailControllerNotifier, ToastDetail>((ref) {
  return ToastDetailControllerNotifier();
});

class ToastDetailControllerNotifier extends StateNotifier<ToastDetail> {
  ToastDetailControllerNotifier() : super(ToastDetail());

  void changeType(ToastificationType type) {
    state = state.copyWith(type: type);
  }

  void changeStyle(ToastificationStyle style) {
    state = state.copyWith(style: style);
  }

  void changeAlignment(AlignmentGeometry alignment) {
    state = state.copyWith(alignment: alignment);
  }

  void changeTitle(String title) {
    state = state.copyWith(title: Text(title));
  }

  void changeDescription(String description) {
    state = state.copyWith(description: Text(description));
  }

  void changeIcon(IconModel? icon) {
    state = state.copyWith(icon: icon);
  }

  void changePrimary(Color? primaryColor) {
    state = state.copyWith(primaryColor: primaryColor);
  }

  void changeBackgroundColor(Color? backgroundColor) {
    state = state.copyWith(backgroundColor: backgroundColor);
  }

  void changeForegroundColor(Color? foregroundColor) {
    state = state.copyWith(foregroundColor: foregroundColor);
  }

  void changeIconColor(Color? iconColor) {
    state = state.copyWith(iconColor: iconColor);
  }

  void changeBorderRadius(BorderRadiusGeometry? borderRadius) {
    state = state.copyWith(borderRadius: borderRadius);
  }

  void changeShadow(ShadowOptions shadow) {
    state = state.copyWith(shadow: shadow);
  }

  void changeDirection(TextDirection? direction) {
    state = state.copyWith(direction: direction);
  }

  void changeAutoCloseDuration(Duration? autoCloseDuration) {
    state = state.copyWith(autoCloseDuration: autoCloseDuration);
  }

  void changeAnimationDuration(Duration? animationDuration) {
    state = state.copyWith(animationDuration: animationDuration);
  }

  void changeAnimationType(AnimationType animationType) {
    state = state.copyWith(animationType: animationType);
  }

  void changeUseContext(bool useContext) {
    state = state.copyWith(useContext: useContext);
  }

  void changeShowProgressBar(bool showProgressBar) {
    state = state.copyWith(showProgressBar: showProgressBar);
  }

  void changeCloseButtonShowType(CloseButtonShowType closeButtonShowType) {
    state = state.copyWith(closeButtonShowType: closeButtonShowType);
  }

  void changeCloseOnClick(bool closeOnClick) {
    state = state.copyWith(closeOnClick: closeOnClick);
  }

  void changeDragToClose(bool dragToClose) {
    state = state.copyWith(dragToClose: dragToClose);
  }

  void changePauseOnHover(bool pauseOnHover) {
    state = state.copyWith(pauseOnHover: pauseOnHover);
  }

  void changeApplyBlurEffect(bool applyBlurEffect) {
    state = state.copyWith(applyBlurEffect: applyBlurEffect);
  }

  void resetColors() {
    state = state.copyWith(
      primaryColor: null,
      backgroundColor: null,
      foregroundColor: null,
      iconColor: null,
    );
  }
}
