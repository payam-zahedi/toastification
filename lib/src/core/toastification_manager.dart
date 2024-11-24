import 'package:flutter/material.dart';
import 'package:toastification/src/widget/toast_builder.dart';
import 'package:toastification/toastification.dart';

class _NotificationEntry {
  final ToastificationItem item;
  bool isInserted;

  _NotificationEntry({required this.item, this.isInserted = false});
}

/// This class is responsible for managing the [Toastification] items.
/// We have several ToastificationManagers for each [Alignment] object.
///
/// You don't need to use [ToastificationManager] directly.
/// [Toastification] will handle them internally.
class ToastificationManager {
  ToastificationManager({
    required this.alignment,
    required this.config,
  });

  final Alignment alignment;

  final ToastificationConfig config;

  OverlayEntry? _overlayEntry;

  /// This key is attached to [AnimatedList] so we can add or remove items using it.
  final _listGlobalKey = GlobalKey<AnimatedListState>();

  /// This map holds all the notifications, both pending and shown.
  /// The key is the unique ID of each notification.
  final Map<String, _NotificationEntry> _notificationsMap = {};

  /// This is the delay for removing the overlay entry.
  ///
  /// When we want to remove the last toast, we need to wait for the animation
  /// to be completed and then remove the overlay.
  final _removeOverlayDelay = const Duration(milliseconds: 50);

  /// A flag to indicate if `dismissAll` has been called.
  bool _dismissAllCalled = false;

  /// Shows a [ToastificationItem] with the given [builder] and [animationBuilder].
  ///
  /// If the overlay is not yet created, we will create the [_overlayEntry],
  /// and schedule the insertion of the item after the overlay is ready.
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

    final entry = _NotificationEntry(item: item);

    // Add the item to the notifications map immediately with pending status.
    _notificationsMap[item.id] = entry;

    if (_dismissAllCalled) {
      // If dismissAll has been called, do not proceed to show the toast.
      _notificationsMap.remove(item.id);
      return item;
    }

    if (_overlayEntry == null) {
      // Overlay is not yet created; create it.
      _createNotificationHolder(overlayState);

      // Schedule the insertion after the overlay has been built.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _insertPendingItems();
      });
    } else {
      // Overlay already exists; insert the item immediately.
      _insertItem(entry);
    }

    return item;
  }

  /// Inserts all pending items into the UI.
  void _insertPendingItems() {
    if (_dismissAllCalled) {
      // If dismissAll was called, do not insert pending items.
      return;
    }

    for (final entry in _notificationsMap.values.toList()) {
      if (!entry.isInserted) {
        _insertItem(entry);
      }
    }
  }

  /// Helper method to insert an item into the UI.
  void _insertItem(_NotificationEntry entry) {
    // Check if dismissAll was called after scheduling the insertion.
    if (_dismissAllCalled) {
      _notificationsMap.remove(entry.item.id);
      return;
    }

    if (entry.isInserted) {
      // Already inserted.
      return;
    }

    entry.isInserted = true;

    const index = 0; // We insert at the top of the list.

    _listGlobalKey.currentState?.insertItem(
      index,
      duration: _createAnimationDuration(entry.item),
    );
  }

  /// Finds the [ToastificationItem] with the given [id].
  ToastificationItem? findToastificationItem(String id) {
    return _notificationsMap[id]?.item;
  }

  /// Using this method, you can remove a notification item.
  /// If there is no notification in the notification map,
  /// we will remove the overlay entry if necessary.
  ///
  /// If the [showRemoveAnimation] is true, we will show the remove animation
  /// of the [notification] item.
  /// Otherwise, we will remove the notification without showing any animation.
  void dismiss(
    ToastificationItem notification, {
    bool showRemoveAnimation = true,
  }) {
    final entry = _notificationsMap[notification.id];

    if (entry != null && entry.isInserted) {
      // Get the index before removing the entry from the map.
      final index = _getItemIndex(entry);

      // Now it's safe to remove the entry from the map.
      _notificationsMap.remove(notification.id);

      if (index != null && index >= 0) {
        if (notification.isRunning) {
          notification.stop();
        }

        // Remove the item from the AnimatedList.
        if (showRemoveAnimation) {
          _listGlobalKey.currentState?.removeItem(
            index,
            (BuildContext context, Animation<double> animation) {
              return ToastHolderWidget(
                item: notification,
                animation: animation,
                alignment: alignment,
                transformerBuilder: _toastAnimationBuilder(notification),
              );
            },
            duration: _createAnimationDuration(notification),
          );
        } else {
          _listGlobalKey.currentState?.removeItem(
            index,
            (BuildContext context, Animation<double> animation) {
              return const SizedBox.shrink();
            },
          );
        }

        // Check if there are any inserted notifications left.
        if (_notificationsMap.values.where((e) => e.isInserted).isEmpty) {
          Future.delayed(
            (notification.animationDuration ?? config.animationDuration) +
                _removeOverlayDelay,
            () {
              if (_notificationsMap.values.where((e) => e.isInserted).isEmpty) {
                _overlayEntry?.remove();
                _overlayEntry = null;
                _dismissAllCalled = false; // Reset the flag for future toasts.
              }
            },
          );
        }
      }
    } else if (entry != null && !entry.isInserted) {
      // The notification was pending and not yet inserted.
      // Remove it from the map.
      _notificationsMap.remove(notification.id);
      // No UI removal needed.
    }
  }

  /// Helper method to get the index of an inserted item.
  int? _getItemIndex(_NotificationEntry entry) {
    final entries = _notificationsMap.values.where((e) => e.isInserted).toList()
      ..sort((a, b) => a.item.id.compareTo(b.item.id));
    return entries.indexOf(entry);
  }

  /// This function dismisses all the notifications.
  /// The [delayForAnimation] parameter is optional and defaults to true.
  /// When it is true, it adds a delay for better animation.
  void dismissAll({bool delayForAnimation = true}) async {
    // Set the flag to indicate that dismissAll has been called.
    _dismissAllCalled = true;

    // Copy the entries to avoid concurrent modification issues.
    final entriesToDismiss = _notificationsMap.values.toList();

    for (final entry in entriesToDismiss) {
      // Dismiss each notification.
      dismiss(entry.item);
      if (delayForAnimation) {
        await Future.delayed(const Duration(milliseconds: 150));
      }
    }

    // Clear the map after dismissing all notifications.
    _notificationsMap.clear();
  }

  /// Remove the first notification in the list.
  void dismissFirst() {
    final entries =
        _notificationsMap.values.where((e) => e.isInserted).toList();
    if (entries.isNotEmpty) {
      dismiss(entries.first.item);
    }
  }

  /// Remove the last notification in the list.
  void dismissLast() {
    final entries =
        _notificationsMap.values.where((e) => e.isInserted).toList();
    if (entries.isNotEmpty) {
      dismiss(entries.last.item);
    }
  }

  void _createNotificationHolder(OverlayState overlay) {
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);
  }

  /// Create an [OverlayEntry] as holder of the notifications.
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
                initialItemCount:
                    _notificationsMap.values.where((e) => e.isInserted).length,
                reverse: alignment.y >= 0,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  final entries = _notificationsMap.values
                      .where((e) => e.isInserted)
                      .toList();
                  final entry = entries[index];
                  final item = entry.item;

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

    // Add the MediaQuery viewPadding as margin so other widgets behind the toastification overlay
    // will be touchable and not covered by the toastification overlay.
    return marginValue.add(MediaQuery.of(context).viewPadding);
  }

  ToastificationAnimationBuilder _toastAnimationBuilder(
    ToastificationItem item,
  ) =>
      item.animationBuilder ?? config.animationBuilder;

  Duration _createAnimationDuration(ToastificationItem item) =>
      item.animationDuration ?? config.animationDuration;
}
