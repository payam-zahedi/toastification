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

  /// This is the list of items that are currently shown
  /// if the list is empty, the overlay entry will be removed
  final ValueNotifier<List<ToastificationItem>> _notifications =
      ValueNotifier<List<ToastificationItem>>([]);

  /// This is the delay for showing the overlay entry
  /// We need this delay because we want to show the item animation after
  /// the overlay is created
  ///
  /// When we want to show first toast, we need to wait for the overlay to be created
  /// and then show the toast item.
  final _createOverlayDelay = const Duration(milliseconds: 100);

  /// This is the delay for removing the overlay entry
  ///
  /// When we want to remove the last toast, we need to wait for the animation
  /// to be completed and then remove the overlay.
  final _removeOverlayDelay = const Duration(milliseconds: 50);

  /// Shows a [ToastificationItem] with the given [builder] and [animationBuilder].
  ///
  /// If the [_notifications] list is empty, we will create the [_overlayEntry]
  /// otherwise, we will just add the [item] to the [_notifications] list.
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

        while (_notifications.length > config.maxToastLimit) {
          dismissLast();
        }
      },
    );

    return item;
  }

  /// Finds the [ToastificationItem] with the given [id].
  ToastificationItem? findToastificationItem(String id) {
    try {
      return _notifications.value
          .firstWhereOrNull((notification) => notification.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Using this method you can remove a notification item
  /// If there is no notification in the notification list,
  /// we will remove the overlay entry
  ///
  /// If the [showRemoveAnimation] is true, we will show the remove animation
  /// of the [notification] item.
  /// Otherwise, we will remove the notification without showing any animation.
  /// This is useful when you want to remove the notification manually,
  /// like when you have some [Dismissible] widget
  void dismiss(
    ToastificationItem notification, {
    bool showRemoveAnimation = true,
  }) {
    final updatedList = List<ToastificationItem>.from(_notifications.value);
    if (updatedList.remove(notification)) {
      _notifications.value = updatedList;

      /// We will remove the [_overlayEntry] if there are no notifications
      /// We need to check if the _notifications list is empty twice.
      /// To make sure after the delay, there are no new notifications added.
      if (_notifications.value.isEmpty) {
        Future.delayed(
          (notification.animationDuration ?? config.animationDuration) +
              _removeOverlayDelay,
          () {
            if (_notifications.value.isEmpty) {
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
    final cloneList = _notifications.value.toList(growable: false).reversed;

    for (final toastItem in cloneList) {
      if (findToastificationItem(toastItem.id) != null) {
        dismiss(toastItem);

        if (delayForAnimation) {
          await Future.delayed(const Duration(milliseconds: 150));
        }
      }
    }
  }

  /// Remove the first notification in the list.
  void dismissFirst() {
    if (_notifications.value.isNotEmpty) {
      dismiss(_notifications.value.first);
    }
  }

  /// Remove the last notification in the list.
  void dismissLast() {
    if (_notifications.value.isNotEmpty) {
      dismiss(_notifications.value.last);
    }
  }

  void _createNotificationHolder(OverlayState overlay) {
    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);
  }

  /// Create a [OverlayEntry] as holder of the notifications
  OverlayEntry _createOverlayEntry() {
    ValueNotifier<bool> _isHovering = ValueNotifier<bool>(false);

    return OverlayEntry(
      opaque: false,
      builder: (context) {
        return Align(
          alignment: alignment,
          child: MouseRegion(
            onEnter: (_) => _isHovering.value = true,
            onExit: (_) => _isHovering.value = false,
            child: Container(
              margin: _marginBuilder(context, alignment, config),
              constraints: BoxConstraints.tightFor(
                width: config.itemWidth,
              ),
              child: ValueListenableBuilder<List<ToastificationItem>>(
                valueListenable: _notifications,
                builder: (context, notifications, child) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isHovering,
                    builder: (context, isHovering, child) {
                      // Limita aos últimos 5 toasts (o último item é o mais novo)
                      final maxToasts = 5;
                      final visibleNotifications =
                          notifications.length <= maxToasts
                              ? notifications
                              : notifications
                                  .sublist(notifications.length - maxToasts);

                      // Reverte a lista para que o toast mais novo seja renderizado por último
                      final reverseVisibleNotifications =
                          visibleNotifications.reversed.toList();

                      final totalToasts = visibleNotifications.length;
                      final maxOpacity = 1.0;
                      final minOpacity = 0.5; // Ajuste conforme necessário

                      return Stack(
                        alignment: Alignment.topCenter,
                        children: reverseVisibleNotifications
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final item = entry.value;

                          // Calcula a opacidade: todos os toasts têm opacidade máxima ao hover
                          double opacity;
                          if (isHovering) {
                            opacity = maxOpacity;
                          } else {
                            final reverseListIndex = totalToasts - index - 1;
                            if (reverseListIndex != 0) {
                              opacity = maxOpacity -
                                  (reverseListIndex / (totalToasts - 1)) *
                                      (maxOpacity - minOpacity);
                            } else {
                              opacity = maxOpacity;
                            }
                          }

                          // Expande a stack ao hover
                          final targetOffset = isHovering
                              ? (totalToasts - index - 1) *
                                  90.0 // Ajuste conforme necessário
                              : (totalToasts - index - 1) *
                                  10.0; // Ajuste conforme necessário

                          return AnimatedPositioned(
                            key: ValueKey(item.id),
                            duration: _createAnimationDuration(item),
                            curve: Curves.easeInOut,
                            top: targetOffset,
                            left: 0,
                            right: 0,
                            child: AnimatedOpacity(
                              opacity: opacity,
                              duration: _createAnimationDuration(item),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: _createAnimationDuration(item),
                                builder: (context, animationValue, child) {
                                  return ToastHolderWidget(
                                    item: item,
                                    animation:
                                        AlwaysStoppedAnimation(animationValue),
                                    alignment: alignment,
                                    transformerBuilder:
                                        _toastAnimationBuilder(item),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
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

    return marginValue.add(MediaQuery.of(context).viewPadding);
  }

  ToastificationAnimationBuilder _toastAnimationBuilder(
    ToastificationItem item,
  ) =>
      item.animationBuilder ?? config.animationBuilder;

  Duration _createAnimationDuration(ToastificationItem item) =>
      item.animationDuration ?? config.animationDuration;
}
