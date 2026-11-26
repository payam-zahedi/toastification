import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:toastification/src/core/widget/list/toast_list_view.dart';
import 'package:toastification/toastification.dart';

/// This class is responsible for managing the [Toastification] items
/// we have several ToastificationManagers for each [Alignment] object
///
/// You don't need to use [ToastificationManager] directly
/// [Toastification] will handle them internally
class ToastificationManager {
  ToastificationManager({required this.alignment, required this.config});

  final Alignment alignment;

  final ToastificationConfig config;

  @visibleForTesting
  OverlayEntry? overlayEntry;

  /// this is the list of all the items, newest first: the pending ones, then
  /// the displayed ones.
  /// if the list is empty, the overlay entry will be removed
  @visibleForTesting
  late final List<ToastificationItem> notifications = CombinedListView([
    _pending,
    _displayed,
  ]);

  /// toasts that [showCustom] accepted but that are not in the list yet,
  /// newest first. They move to [_displayed] after the next frame, see
  /// [_display].
  final List<ToastificationItem> _pending = [];

  /// toasts that are in the [_listView], newest first.
  final List<ToastificationItem> _displayed = [];

  /// lays out the [_displayed] toasts inside the [overlayEntry].
  late final _listView = ToastListView.of(
    alignment: alignment,
    config: config,
    items: _displayed,
    onExitEnd: _removeOverlayIfIdle,
  );

  /// this is the delay for removing the overlay entry
  ///
  /// when we want to remove the last toast, we need to wait for the animation
  /// to be completed and then remove the overlay.
  @visibleForTesting
  final removeOverlayDelay = const Duration(milliseconds: 50);

  /// Shows a [ToastificationItem] with the given [builder] and [animationBuilder].
  ///
  /// the [item] is displayed after the next frame.
  /// if there is no [overlayEntry], we will create it.
  ToastificationItem showCustom({
    required OverlayState overlayState,
    required SchedulerBinding scheduler,
    required ToastificationBuilder builder,
    required ToastificationAnimationBuilder? animationBuilder,
    required Duration? animationDuration,
    required ToastificationCallbacks callbacks,
    Duration? autoCloseDuration,
  }) {
    final item = ToastificationItem(
      builder: builder,
      alignment: alignment,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      onAutoCompleteCompleted: (toastItem) {
        dismiss(toastItem);
        callbacks.onAutoCompleteCompleted?.call(toastItem);
      },
    );

    _pending.insert(0, item);

    // the overlay and the list can't change while the widget tree is building.
    if (scheduler.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      scheduler.addPostFrameCallback((_) {
        _displayOnNextFrame(item, overlayState, scheduler);
      });
    } else {
      _displayOnNextFrame(item, overlayState, scheduler);
    }

    return item;
  }

  /// keeps the toasts within [ToastificationConfig.maxToastLimit], makes sure
  /// an [overlayEntry] holds the list, and displays the pending [item] after
  /// the next frame, once the list is built.
  void _displayOnNextFrame(
    ToastificationItem item,
    OverlayState overlayState,
    SchedulerBinding scheduler,
  ) {
    while (notifications.length > config.maxToastLimit) {
      dismissLast();
    }

    // the toast was dismissed in the meantime.
    if (!_pending.contains(item)) return;

    if (overlayEntry == null) {
      _createNotificationHolder(overlayState);
    }

    scheduler.addPostFrameCallback((_) => _display(item));
    // a post-frame callback alone doesn't schedule a frame.
    scheduler.ensureVisualUpdate();
  }

  /// moves a pending [item] to [_displayed] and into the list.
  void _display(ToastificationItem item) {
    // the toast was dismissed before its frame.
    if (!_pending.remove(item)) return;

    _displayed.insert(0, item);
    _listView.insert(item, _createAnimationDuration(item));
  }

  /// Finds the [ToastificationItem] with the given [id].
  ToastificationItem? findToastificationItem(String id) {
    try {
      return notifications.firstWhereOrNull(
        (notification) => notification.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  /// using this method you can remove a notification item
  /// if there is no notification in the notification list,
  /// we will remove the overlay entry
  ///
  /// if the [showRemoveAnimation] is true, we will show the remove animation
  /// of the [notification] item.
  /// otherwise we will remove the notification without showing any animation.
  /// this is useful when you want to remove the notification manually,
  /// like when you have some [Dismissible] widget
  void dismiss(
    ToastificationItem notification, {
    bool showRemoveAnimation = true,
  }) {
    final isPending = _pending.remove(notification);

    // if its a pending toast, that means it hasn't been displayed yet,
    // so we just need to remove it from the pending list without worrying about animations.
    if (isPending) {
      // disposed after the caller's callbacks, like a displayed toast.
      scheduleMicrotask(notification.dispose);

      // a list that was never built has no exit animation to wait for.
      if (!_listView.isBuilt) {
        scheduleMicrotask(_removeOverlayIfIdle);
      } else {
        Future.delayed(removeOverlayDelay, _removeOverlayIfIdle);
      }
      return;
    }

    final index = _displayed.indexOf(notification);

    if (index != -1) {
      notification = _displayed[index];

      if (notification.isRunning) {
        notification.stop();
      }

      final removedItem = _displayed.removeAt(index);

      // Use Duration.zero when there is no remove animation. Without a
      // duration, AnimatedList falls back to its 300ms default.
      final Duration removeDuration = showRemoveAnimation
          ? _createAnimationDuration(removedItem)
          : Duration.zero;
      final Duration delay = removeDuration + removeOverlayDelay;

      _listView.remove(index, removedItem, removeDuration);

      // Always dispose the item after the delay value notifier and timer can cause leaks memory.
      Future.delayed(delay, () {
        removedItem.dispose();
      });

      /// we will remove the [_overlayEntry] if there are no notifications
      /// We need to check if the _notifications list is empty twice.
      /// To make sure after the delay, there are no new notifications added.
      if (notifications.isEmpty) {
        Future.delayed(delay, _removeOverlayIfIdle);
      }
    }
  }

  void _removeOverlayIfIdle() {
    if (notifications.isNotEmpty || _listView.isExiting) return;

    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  /// This function dismisses all the notifications in the [notifications] list.
  /// The [delayForAnimation] parameter is optional and defaults to true.
  /// When it is true, it adds a delay for better animation.
  void dismissAll({bool delayForAnimation = true}) async {
    // Creates a new list cloneList that has all the notifications from the _notifications list, but in reverse order.
    final cloneList = notifications.toList(growable: false).reversed;

    // For each cloned "toastItem" notification in "cloneList",
    // we will remove it and then pause for a duration if delayForAnimation is true.
    for (final toastItem in cloneList) {
      /// If the item is still in the [_notification] list, we will remove it
      if (findToastificationItem(toastItem.id) != null) {
        // Dismiss the current notification item
        dismiss(toastItem);

        // If delayForAnimation is true, wait for 150ms before proceeding to the next item
        if (delayForAnimation) {
          await Future.delayed(const Duration(milliseconds: 150));
        }
      }
    }
  }

  /// remove the first notification in the list.
  void dismissFirst() {
    dismiss(notifications.first);
  }

  /// remove the last notification in the list.
  void dismissLast() {
    dismiss(notifications.last);
  }

  void _createNotificationHolder(OverlayState overlay) {
    overlayEntry = _createOverlayEntry();
    overlay.insert(overlayEntry!);
  }

  /// create a [OverlayEntry] as holder of the notifications
  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      opaque: false,
      builder: (context) {
        Widget overlay = Align(
          alignment: alignment,
          child: Container(
            margin: _marginBuilder(context, alignment, config),
            constraints: BoxConstraints.tightFor(width: config.itemWidth),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: _listView.build(context),
            ),
          ),
        );

        if (config.blockBackgroundInteraction) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: overlay,
          );
        }

        return overlay;
      },
    );
  }

  EdgeInsetsGeometry _marginBuilder(
    BuildContext context,
    AlignmentGeometry alignment,
    ToastificationConfig config,
  ) {
    var marginValue = config.marginBuilder(context, alignment);

    if (config.applyMediaQueryViewInsets) {
      marginValue = marginValue.add(MediaQuery.of(context).viewInsets);
    }

    /// Add the MediaQuery viewPadding as margin so other widgets behind the toastification overlay
    /// will be touchable and not covered by the toastification overlay.
    return marginValue.add(MediaQuery.of(context).viewPadding);
  }

  Duration _createAnimationDuration(ToastificationItem item) =>
      item.animationDuration ?? config.animationDuration;
}
