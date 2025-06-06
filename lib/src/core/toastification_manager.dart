import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
    bool? blockBackgroundInteraction,
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
      _createNotificationHolder(overlayState, blockBackgroundInteraction);
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

      /// if the [showRemoveAnimation] is true, we will show the remove animation
      /// of the notification.
      if (showRemoveAnimation) {
        listGlobalKey.currentState?.removeItem(
          index,
          (BuildContext context, Animation<double> animation) {
            return ToastHolderWidget(
              item: removedItem,
              animation: animation,
              alignment: alignment,
              transformerBuilder: _toastAnimationBuilder(removedItem),
            );
          },
          duration: _createAnimationDuration(removedItem),
        );

        /// if the [showRemoveAnimation] is false, we will remove the notification
        /// without showing the remove animation.
      } else {
        listGlobalKey.currentState?.removeItem(
          index,
          (BuildContext context, Animation<double> animation) {
            return const SizedBox.shrink();
          },
        );
      }

      /// we will remove the [_overlayEntry] if there are no notifications
      /// We need to check if the _notifications list is empty twice.
      /// To make sure after the delay, there are no new notifications added.
      if (notifications.isEmpty) {
        Future.delayed(
          (removedItem.animationDuration ?? config.animationDuration) +
              removeOverlayDelay,
          () {
            if (notifications.isEmpty) {
              overlayEntry?.remove();
              overlayEntry = null;
            }
          },
        );
      }
    }
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

  void _createNotificationHolder(OverlayState overlay, bool? blockBackgroundInteraction) {
    overlayEntry = _createOverlayEntry(blockBackgroundInteraction);
    overlay.insert(overlayEntry!);
  }

  /// create a [OverlayEntry] as holder of the notifications
  OverlayEntry _createOverlayEntry([bool? blockBackgroundInteraction]) {
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

        // Use the provided blockBackgroundInteraction value if available, otherwise use the config value
        final shouldBlockBackgroundInteraction = blockBackgroundInteraction ?? config.blockBackgroundInteraction;

        if (shouldBlockBackgroundInteraction) {
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

  Duration _createAnimationDuration(ToastificationItem item) => item.animationDuration ?? config.animationDuration;
}
