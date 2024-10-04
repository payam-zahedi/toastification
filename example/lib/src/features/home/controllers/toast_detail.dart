import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';

final toastDetailControllerProvider =
    StateNotifierProvider<ToastDetailControllerNotifier, ToastDetail>((ref) {
  return ToastDetailControllerNotifier();
});

class ToastDetailControllerNotifier extends StateNotifier<ToastDetail> {
  static const _hiveKey = 'toastDetailKey';

  ToastDetailControllerNotifier() : super(ToastDetail()) {
    _loadState();
  }

  Future<void> _saveState() async {
    final box = Hive.box('toastDetailBox');
    box.put(_hiveKey, state.toMap());
  }

  Future<void> _loadState() async {
    final box = Hive.box('toastDetailBox');
    final data = box.get(_hiveKey);

    if (data != null) {
      try {
        final Map<String, dynamic> castData = Map<String, dynamic>.from(data);
        state = ToastDetailSerialization.fromMap(castData);
      } catch (_, _) {
        // This is a fallback in case the data is corrupted, so the user can still use the app
        state = ToastDetail();
        _saveState();
      }
    }
  }

  void changeType(ToastificationType type) {
    state = state.copyWith(type: type);
    _saveState();
  }

  void changeStyle(ToastificationStyle style) {
    state = state.copyWith(style: style);
    _saveState();
  }

  void changeAlignment(AlignmentGeometry alignment) {
    state = state.copyWith(alignment: alignment);
    _saveState();
  }

  void changeTitle(String title) {
    state = state.copyWith(title: Text(title));
    _saveState();
  }

  void changeDescription(String description) {
    state = state.copyWith(description: Text(description));
    _saveState();
  }

  void changeIcon(IconModel? icon) {
    state = state.copyWith(icon: icon);
    _saveState();
  }

  void changeShowIcon(bool showIcon) {
    state = state.copyWith(showIcon: showIcon);
    _saveState();
  }

  void changePrimary(Color? primaryColor) {
    state = state.copyWith(primaryColor: primaryColor);
    _saveState();
  }

  void changeBackgroundColor(Color? backgroundColor) {
    state = state.copyWith(backgroundColor: backgroundColor);
    _saveState();
  }

  void changeForegroundColor(Color? foregroundColor) {
    state = state.copyWith(foregroundColor: foregroundColor);
    _saveState();
  }

  void changeIconColor(Color? iconColor) {
    state = state.copyWith(iconColor: iconColor);
    _saveState();
  }

  void changeBorderRadius(BorderRadiusGeometry? borderRadius) {
    state = state.copyWith(borderRadius: borderRadius);
    _saveState();
  }

  void changeShadow(ShadowOptions shadow) {
    state = state.copyWith(shadow: shadow);
    _saveState();
  }

  void changeDirection(TextDirection? direction) {
    state = state.copyWith(direction: direction);
    _saveState();
  }

  void changeAutoCloseDuration(Duration? autoCloseDuration) {
    state = state.copyWith(autoCloseDuration: autoCloseDuration);
    _saveState();
  }

  void changeAnimationDuration(Duration? animationDuration) {
    state = state.copyWith(animationDuration: animationDuration);
    _saveState();
  }

  void changeAnimationType(AnimationType animationType) {
    state = state.copyWith(animationType: animationType);
    _saveState();
  }

  void changeUseContext(bool useContext) {
    state = state.copyWith(useContext: useContext);
    _saveState();
  }

  void changeShowProgressBar(bool showProgressBar) {
    state = state.copyWith(showProgressBar: showProgressBar);
    _saveState();
  }

  void changeCloseButtonShowType(CloseButtonShowType closeButtonShowType) {
    state = state.copyWith(closeButtonShowType: closeButtonShowType);
    _saveState();
  }

  void changeCloseOnClick(bool closeOnClick) {
    state = state.copyWith(closeOnClick: closeOnClick);
    _saveState();
  }

  void changeDragToClose(bool dragToClose) {
    state = state.copyWith(dragToClose: dragToClose);
    _saveState();
  }

  void changePauseOnHover(bool pauseOnHover) {
    state = state.copyWith(pauseOnHover: pauseOnHover);
    _saveState();
  }

  void changeApplyBlurEffect(bool applyBlurEffect) {
    state = state.copyWith(applyBlurEffect: applyBlurEffect);
    _saveState();
  }

  void resetColors() {
    state = state.copyWith(
      primaryColor: null,
      backgroundColor: null,
      foregroundColor: null,
      iconColor: null,
    );
    _saveState();
  }
}
