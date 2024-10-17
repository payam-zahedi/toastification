import 'package:example/src/database/database.dart';
import 'package:example/src/database/database_provider.dart';
import 'package:example/src/database/utils_mapping.dart';
import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

final toastDetailControllerProvider =
    StateNotifierProvider<ToastDetailControllerNotifier, ToastDetail>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ToastDetailControllerNotifier(db);
});

class ToastDetailControllerNotifier extends StateNotifier<ToastDetail> {
  final AppDatabase _db;

  ToastDetailControllerNotifier(this._db) : super(ToastDetail()) {
    _loadState();
  }

  Future<void> _saveState() async {
    try {
      print('Saving toast detail state...');
      final companion = state.toCompanion(state);
      await _db.upsertToastDetail(companion);
      print('Toast detail state saved successfully!');
    } catch (e) {
      print('Failed to save toast detail state: $e');
    }
  }

  Future<void> _loadState() async {
    try {
      print('Loading toast detail state...');
      final toastDetailData = await _db.getToastDetail(1);

      if (toastDetailData != null) {
        state = ToastDetailDrift.fromCompanion(toastDetailData);
        print('Toast detail state loaded successfully!');
      } else {
        print(
            'No existing toast detail found, creating default toast detail...');
        final toastDetail = await _db.getOrCreateDefaultToastDetail();
        state = ToastDetailDrift.fromCompanion(toastDetail);
      }
    } catch (e) {
      print('Failed to load toast detail state: $e');
      // Reset the state to default values in case of failure
      resetStateToDefaults();
    }
  }

  /// Resets the state to default values and persists the reset state.
  void resetStateToDefaults() {
    state = ToastDetail(
      type: ToastificationType.success, // Default type
      style: ToastificationStyle.flat, // Default style
      alignment: Alignment.topLeft, // Default alignment
      title: const Text('Default Title'),
      description: const Text('Default Description'),
      icon: null, // No default icon
      primaryColor: null,
      backgroundColor: null,
      foregroundColor: null,
      iconColor: null,
      borderRadius: BorderRadius.zero, // Default border radius
      shadow: ShadowOptions.none, // Default shadow option
      direction: null,
      autoCloseDuration: const Duration(seconds: 5),
      animationDuration: const Duration(milliseconds: 300),
      animationType: const BounceAnimationType(), // Default animation type
      useContext: true,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always, // Default close button
      closeOnClick: true,
      dragToClose: false,
      pauseOnHover: true,
      applyBlurEffect: false,
      showIcon: true,
    );
    _saveState(); // Persist the reset state
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
