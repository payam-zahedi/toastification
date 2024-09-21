import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:toastification/src/widget/toast_builder.dart';
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

  OverlayEntry? _overlayEntry;

  /// this key is attached to [AnimatedList] so we can add or remove items using it.
  final _listGlobalKey = GlobalKey<AnimatedListState>();

  /// this is the list of items that are currently shown
  /// if the list is empty, the overlay entry will be removed
  final List<ToastificationItem> _notifications = [];

  /// this is the delay for showing the overlay entry
  /// We need this delay because we want to show the item animation after
  /// the overlay created
  ///
  /// When we want to show first toast, we need to wait for the overlay to be created
  /// and then show the toast item.
  final _createOverlayDelay = const Duration(milliseconds: 100);

  /// this is the delay for removing the overlay entry
  ///
  /// when we want to remove the last toast, we need to wait for the animation
  /// to be completed and then remove the overlay.
  final _removeOverlayDelay = const Duration(milliseconds: 50);

  /// Shows a [ToastificationItem] with the given [builder] and [animationBuilder].
  ///
  /// if the [_notifications] list is empty, we will create the [_overlayEntry]
  /// otherwise we will just add the [item] to the [_notifications] list.
  ToastificationItem showCustom({
    required OverlayState overlayState,
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

    /// we need this delay because we want to show the item animation after
    /// the overlay created
    Duration delay = const Duration(milliseconds: 10);

    if (_overlayEntry == null) {
      _createNotificationHolder(overlayState);

      delay = _createOverlayDelay;
    }

    Future.delayed(
      delay,
      () {
        _notifications.insert(0, item);

        _listGlobalKey.currentState?.insertItem(
          0,
          duration: _createAnimationDuration(item),
        );
      },
    );

    // TODO(payam): add limit count feature

    return item;
  }

  /// Finds the [ToastificationItem] with the given [id].
  ToastificationItem? findToastificationItem(String id) {
    try {
      return _notifications
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
    final index = _notifications.indexOf(notification);
    // print("Toastification Manager Dismiss Notifications: $_notifications");
    if (index != -1) {
      notification = _notifications[index];

      if (notification.isRunning) {
        notification.stop();
      }

      final removedItem = _notifications.removeAt(index);

      /// if the [showRemoveAnimation] is true, we will show the remove animation
      /// of the notification.
      if (showRemoveAnimation) {
        _listGlobalKey.currentState?.removeItem(
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
        _listGlobalKey.currentState?.removeItem(
          index,
          (BuildContext context, Animation<double> animation) {
            return const SizedBox.shrink();
          },
        );
      }

      /// we will remove the [_overlayEntry] if there are no notifications
      /// We need to check if the _notifications list is empty twice.
      /// To make sure after the delay, there are no new notifications added.
      if (_notifications.isEmpty) {
        Future.delayed(
          (removedItem.animationDuration ?? config.animationDuration) +
              _removeOverlayDelay,
          () {
            if (_notifications.isEmpty) {
              _overlayEntry?.remove();
              _overlayEntry = null;
            }
          },
        );
      }
    }
  }

  /// This function dismisses all the notifications in the [_notifications] list.
  /// The [delayForAnimation] parameter is optional and defaults to true.
  /// When it is true, it adds a delay for better animation.
  void dismissAll({bool delayForAnimation = true}) async {
    // Creates a new list cloneList that has all the notifications from the _notifications list, but in reverse order.
    final cloneList = _notifications.toList(growable: false).reversed;

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
    dismiss(_notifications.first);
  }

  /// remove the last notification in the list.
  void dismissLast() {
    dismiss(_notifications.last);
  }

  void _createNotificationHolder(OverlayState overlay) {
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);
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
                key: _listGlobalKey,
                clipBehavior: config.clipBehavior,
                initialItemCount: _notifications.length,
                reverse: alignment.y >= 0,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  final item = _notifications[index];

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
