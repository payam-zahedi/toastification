import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/core/toastification_item.dart';
import 'package:toastification/src/widget/toast_builder.dart';

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

  /// using this method you can show a notification
  /// if there is no notification in the notification list,
  /// we will animate in the overlay
  /// otherwise we will just add the notification to the list
  ToastificationItem showCustom({
    required BuildContext context,
    required ToastificationBuilder builder,
    required ToastificationAnimationBuilder? animationBuilder,
    required Duration? animationDuration,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
  }) {
    final item = ToastificationItem(
      builder: builder,
      alignment: alignment,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      onAutoCompleteCompleted: (holder) {
        dismiss(holder);
      },
    );

    /// we need this delay because we want to show the item animation after
    /// the overlay created
    var delay = const Duration(milliseconds: 10);

    if (_overlayEntry == null) {
      _createNotificationHolder(context, overlay: overlayState);

      delay = const Duration(milliseconds: 300);
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

  ToastificationItem? findToastificationItem(String id) {
    try {
      return _notifications
          .firstWhereOrNull((notification) => notification.id == id);
    } catch (e) {
      return null;
    }
  }

  /// using this method you can remove a notification
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
              child: _createAnimationBuilder(context, animation, removedItem),
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
      Future.delayed(
        removedItem.animationDuration ?? config.animationDuration,
        () {
          if (_notifications.isEmpty) {
            _overlayEntry?.remove();
            _overlayEntry = null;
          }
        },
      );
    }
  }

  /// This function dismisses all the notifications in the [_notifications] list.
  /// The delayForAnimation parameter is optional and defaults to true.
  /// When true, it adds a delay for better animation.
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

  void _createNotificationHolder(
    BuildContext context, {
    OverlayState? overlay,
  }) {
    final overlayState = overlay ?? Overlay.of(context, rootOverlay: true);

    _overlayEntry = _createOverlayEntry(context);

    overlayState.insert(_overlayEntry!);
  }

  /// create a [OverlayEntry] as holder of the notifications
  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      opaque: false,
      builder: (context) {
        Widget overlay = Align(
          alignment: alignment,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 32),
            constraints: const BoxConstraints.tightFor(
              width: 450,
            ),
            child: AnimatedList(
              key: _listGlobalKey,
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
                  child: _createAnimationBuilder(context, animation, item),
                );
              },
            ),
          ),
        );

        return overlay;
      },
    );
  }

  Widget _createAnimationBuilder(
    BuildContext context,
    Animation<double> animation,
    ToastificationItem item,
  ) {
    return item.animationBuilder?.call(
          context,
          animation,
          alignment,
          item.builder(context, item),
        ) ??
        config.animationBuilder(
          context,
          animation,
          alignment,
          item.builder(context, item),
        );
  }

  Duration _createAnimationDuration(
    ToastificationItem item,
  ) {
    return item.animationDuration ?? config.animationDuration;
  }
}
