import 'dart:developer';

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

  // Add new wrapper method
  Future<void> _updateAndSave(
      ToastDetail Function(ToastDetail current) update) async {
    state = update(state);
    await saveState();
  }

  Future<void> saveState() async {
    try {
      final companion = state.toCompanion();
      await _db.upsertToastDetail(companion);
    } catch (error) {
      log('Error saving toast detail state: $error');
    }
  }

  Future<void> _loadState() async {
    try {
      final toastDetailData = await _db.retrieveSavedToastState();

      state = ToastDetailDrift.fromCompanion(toastDetailData);
    } catch (e) {
      clearState();
    }
  }

  void clearState([bool clearDatabase = false]) {
    state = ToastDetail();

    if (clearDatabase) {
      _db.deleteToastDetail();
    }
  }

  void changeType(ToastificationType type) {
    _updateAndSave((current) => current.copyWith(type: type));
  }

  void changeStyle(ToastificationStyle style) {
    _updateAndSave((current) => current.copyWith(style: style));
  }

  void changeAlignment(AlignmentGeometry alignment) {
    _updateAndSave((current) => current.copyWith(alignment: alignment));
  }

  void changeTitle(String title) {
    _updateAndSave((current) => current.copyWith(title: Text(title)));
  }

  void changeDescription(String description) {
    _updateAndSave(
        (current) => current.copyWith(description: Text(description)));
  }

  void changeIcon(IconModel? icon) {
    _updateAndSave((current) => current.copyWith(icon: icon));
  }

  void changeShowIcon(bool showIcon) {
    _updateAndSave((current) => current.copyWith(showIcon: showIcon));
  }

  void changePrimary(Color? primaryColor) {
    _updateAndSave((current) => current.copyWith(primaryColor: primaryColor));
  }

  void changeBackgroundColor(Color? backgroundColor) {
    _updateAndSave(
        (current) => current.copyWith(backgroundColor: backgroundColor));
  }

  void changeForegroundColor(Color? foregroundColor) {
    _updateAndSave(
        (current) => current.copyWith(foregroundColor: foregroundColor));
  }

  void changeIconColor(Color? iconColor) {
    _updateAndSave((current) => current.copyWith(iconColor: iconColor));
  }

  void changeBorderRadius(BorderRadiusGeometry? borderRadius) {
    _updateAndSave((current) => current.copyWith(borderRadius: borderRadius));
  }

  void changeShadow(ShadowOptions shadow) {
    _updateAndSave((current) => current.copyWith(shadow: shadow));
  }

  void changeDirection(TextDirection? direction) {
    _updateAndSave((current) => current.copyWith(direction: direction));
  }

  void changeAutoCloseDuration(Duration? autoCloseDuration) {
    _updateAndSave(
        (current) => current.copyWith(autoCloseDuration: autoCloseDuration));
  }

  void changeAnimationDuration(Duration? animationDuration) {
    _updateAndSave(
        (current) => current.copyWith(animationDuration: animationDuration));
  }

  void changeAnimationType(AnimationType animationType) {
    _updateAndSave((current) => current.copyWith(animationType: animationType));
  }

  void changeUseContext(bool useContext) {
    _updateAndSave((current) => current.copyWith(useContext: useContext));
  }

  void changeShowProgressBar(bool showProgressBar) {
    _updateAndSave(
        (current) => current.copyWith(showProgressBar: showProgressBar));
  }

  void changeCloseButton(ToastCloseButton closeButton) {
    _updateAndSave((current) => current.copyWith(closeButton: closeButton));
  }

  void changeCloseOnClick(bool closeOnClick) {
    _updateAndSave((current) => current.copyWith(closeOnClick: closeOnClick));
  }

  void changeDragToClose(bool dragToClose) {
    _updateAndSave((current) => current.copyWith(dragToClose: dragToClose));
  }

  void changePauseOnHover(bool pauseOnHover) {
    _updateAndSave((current) => current.copyWith(pauseOnHover: pauseOnHover));
  }

  void changeApplyBlurEffect(bool applyBlurEffect) {
    _updateAndSave(
        (current) => current.copyWith(applyBlurEffect: applyBlurEffect));
  }

  void resetColors() {
    _updateAndSave((current) => current.copyWith(
          primaryColor: null,
          backgroundColor: null,
          foregroundColor: null,
          iconColor: null,
        ));
  }
}
