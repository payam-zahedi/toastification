import 'dart:async';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:toastification/src/core/widget/toast_builder.dart';
import 'package:toastification/toastification.dart';

/// This class is responsible for managing the [Toastification] items
/// we have several ToastificationManagers for each [Alignment] object
///
/// You don't need to use [ToastificationManager] directly
/// [Toastification] will handle them internally
class ToastificationManager {
  ToastificationManager({
    required this.alignment,
    required this.config,
  });

  final Alignment alignment;

  final ToastificationConfig config;

  @visibleForTesting
  OverlayEntry? overlayEntry;

  /// this key is attached to [AnimatedList] so we can add or remove items using it.
  @visibleForTesting
  final listGlobalKey = GlobalKey<AnimatedListState>();

  /// this is the list of items that are currently shown
  /// if the list is empty, the overlay entry will be removed
  @visibleForTesting
  final List<ToastificationItem> notifications = [];

  /// this is the delay for removing the overlay entry
  ///
  /// when we want to remove the last toast, we need to wait for the animation
  /// to be completed and then remove the overlay.
  @visibleForTesting
  final removeOverlayDelay = const Duration(milliseconds: 50);

  /// Shows a [ToastificationItem] with the given [builder] and [animationBuilder].
  ///
  /// if the [notifications] list is empty, we will create the [overlayEntry]
  /// otherwise we will just add the [item] to the [notifications] list.
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

    if (overlayEntry == null) {
      _createNotificationHolder(overlayState);
    }

    scheduler.addPostFrameCallback((_) {
      _addItemToList(item);
    });

    return item;
  }

  void _addItemToList(ToastificationItem item) {
    if (notifications.contains(item)) return;

    notifications.insert(0, item);
    listGlobalKey.currentState?.insertItem(
      0,
      duration: _createAnimationDuration(item),
    );

    while (notifications.length > config.maxToastLimit) {
      dismissLast();
    }
  }

  /// Finds the [ToastificationItem] with the given [id].
  ToastificationItem? findToastificationItem(String id) {
    try {
      return notifications
          .firstWhereOrNull((notification) => notification.id == id);
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
    final index = notifications.indexOf(notification);
    // print("Toastification Manager Dismiss Notifications: $_notifications");
    if (index != -1) {
      notification = notifications[index];

      if (notification.isRunning) {
        notification.stop();
      }

      final removedItem = notifications.removeAt(index);

      Duration delay = removeOverlayDelay;

      /// if the [showRemoveAnimation] is true, we will show the remove animation
      /// of the notification.
      if (showRemoveAnimation) {
        final animationDuration = _createAnimationDuration(removedItem);

        delay = animationDuration + delay;

        _removeItemWithExitWatch(
          index,
          removedItem,
          (BuildContext context, Animation<double> animation) {
            return ToastHolderWidget(
              item: removedItem,
              animation: animation,
              alignment: alignment,
              transformerBuilder: _toastAnimationBuilder(removedItem),
            );
          },
          duration: animationDuration,
        );

        /// if the [showRemoveAnimation] is false, we will remove the notification
        /// without showing the remove animation.
      } else {
        _removeItemWithExitWatch(
          index,
          removedItem,
          (BuildContext context, Animation<double> animation) {
            return const SizedBox.shrink();
          },
          duration: _defaultRemoveDuration,
        );
      }

      // Always dispose the item after the delay value notifier and timer can cause leaks memory.
      Future.delayed(delay, () {
        removedItem.dispose();
      });

      /// we will remove the [_overlayEntry] if there are no notifications
      /// We need to check if the _notifications list is empty twice.
      /// To make sure after the delay, there are no new notifications added.
      ///
      /// This timer is only a safety net for exit animations that were never
      /// observed (see [_removeItemWithExitWatch]): while the animation is
      /// still running, its status listener owns the teardown. Tearing the
      /// overlay down from here would race the [AnimatedList]'s own
      /// bookkeeping and dispose the animation controller twice.
      if (notifications.isEmpty) {
        Future.delayed(
          delay,
          () {
            final exit = exitAnimations[removedItem.id];
            if (exit is AnimationController && exit.isAnimating) {
              return;
            }
            exitAnimations.remove(removedItem.id);
            _removeOverlayIfIdle();
          },
        );
      }
    }
  }

  /// [AnimatedList.removeItem]'s own default duration, replicated because the
  /// framework keeps it private.
  static const Duration _defaultRemoveDuration = Duration(milliseconds: 300);

  /// Exit animations currently running, keyed by [ToastificationItem.id].
  ///
  /// The overlay may only be torn down once the framework has finished its
  /// own bookkeeping for every one of them, see [_removeItemWithExitWatch].
  @visibleForTesting
  final Map<String, Animation<double>> exitAnimations = {};

  /// Starts the exit animation of [item] on the [AnimatedList] and drives the
  /// overlay teardown from the animation itself.
  ///
  /// `AnimatedListState.removeItem` disposes the animation controller in a
  /// `.then` MICROTASK once the exit animation completes, and the list's
  /// `State.dispose` disposes every controller still in flight too. If the
  /// overlay entry is removed in the very frame that completes the animation,
  /// that microtask runs after the dispose — on the web the engine does not
  /// flush microtasks between `onBeginFrame` and `onDrawFrame` — and the
  /// controller is disposed twice: `Null check operator used on a null value`
  /// in `AnimationController.dispose`. A timer set to the animation duration
  /// lands in exactly that frame as soon as frames stall (background tab,
  /// rendering hiccup).
  ///
  /// So the teardown waits for [AnimationStatus.dismissed] and is queued as a
  /// microtask from the status listener, i.e. AFTER the framework's own
  /// `.then` for that very tick. By the time it runs, the controller has left
  /// the list's bookkeeping and the dispose has nothing left to free twice.
  void _removeItemWithExitWatch(
    int index,
    ToastificationItem item,
    AnimatedRemovedItemBuilder builder, {
    required Duration duration,
  }) {
    void watch(Animation<double> animation) {
      // The builder runs on every frame of the exit; watch only once.
      if (exitAnimations.containsKey(item.id)) return;
      exitAnimations[item.id] = animation;

      void onStatus(AnimationStatus status) {
        if (status != AnimationStatus.dismissed) return;
        animation.removeStatusListener(onStatus);
        exitAnimations.remove(item.id);
        scheduleMicrotask(_removeOverlayIfIdle);
      }

      animation.addStatusListener(onStatus);
    }

    listGlobalKey.currentState?.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        watch(animation);
        return builder(context, animation);
      },
      duration: duration,
    );
  }

  /// Removes the [overlayEntry] once no toast is shown nor still exiting.
  void _removeOverlayIfIdle() {
    if (notifications.isNotEmpty || exitAnimations.isNotEmpty) return;
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
            constraints: BoxConstraints.tightFor(
              width: config.itemWidth,
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: AnimatedList(
                key: listGlobalKey,
                clipBehavior: config.clipBehavior,
                initialItemCount: notifications.length,
                reverse: alignment.y >= 0,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  final item = notifications[index];

                  return ToastHolderWidget(
                    item: item,
                    animation: animation,
                    alignment: alignment,
                    transformerBuilder: _toastAnimationBuilder(item),
                  );
                },
              ),
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

  ToastificationAnimationBuilder _toastAnimationBuilder(
    ToastificationItem item,
  ) =>
      item.animationBuilder ?? config.animationBuilder;

  Duration _createAnimationDuration(ToastificationItem item) =>
      item.animationDuration ?? config.animationDuration;
}
