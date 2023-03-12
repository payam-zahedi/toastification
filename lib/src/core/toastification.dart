import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:toastification/src/core/toastification_item.dart';
import 'package:toastification/src/widget/toast_builder.dart';

const _itemAnimationDuration = Duration(milliseconds: 300);
const _containerAnimationDuration = Duration(milliseconds: 500);

final toastification = Toastification();

class Toastification extends NavigatorObserver {
  static final Toastification _instance = Toastification._internal();

  Toastification._internal();

  factory Toastification() => _instance;

  OverlayEntry? _overlayEntry;

  AnimationController? _transitionController;

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
    Duration? autoCloseDuration,
    OverlayState? overlayState,
  }) {
    final item = ToastificationItem(
      builder: builder,
      autoCloseDuration: autoCloseDuration,
      onAutoCompleteCompleted: (holder) {
        dismiss(holder);
      },
    );

    _notifications.insert(0, item);

    if (_overlayEntry == null) {
      _createNotificationHolder(context, overlay: overlayState);
    } else {
      _listGlobalKey.currentState
          ?.insertItem(0, duration: _itemAnimationDuration);

      // TODO(payam): add limit count feature
    }

    return item;
  }

  /// using this method you can show a notification by using the [navigator] overlay
  ToastificationItem showWithNavigatorState({
    required NavigatorState navigator,
    required ToastificationBuilder builder,
    Duration? autoCloseDuration,
  }) {
    final context = navigator.context;

    return showCustom(
      context: context,
      builder: builder,
      autoCloseDuration: autoCloseDuration,
      overlayState: navigator.overlay,
    );
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
  void dismiss(ToastificationItem notification) {
    final index = _notifications.indexOf(notification);

    if (index != -1) {
      notification = _notifications[index];

      if (notification.isRunning) {
        notification.stop();
      }

      final removedItem = _notifications.removeAt(index);

      _listGlobalKey.currentState?.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return ToastBuilderWidget(
            key: ValueKey(removedItem.id),
            animation: animation,
            item: removedItem,
          );
        },
        duration: _itemAnimationDuration,
      );

      /// we will remove the [_overlayEntry] if there are no notifications
      Future.delayed(
        _itemAnimationDuration,
        () {
          if (_notifications.isEmpty) {
            _overlayEntry?.remove();
            _overlayEntry = null;
          }
        },
      );
    }
  }

  void dismissById(String id) {
    final notification = findToastificationItem(id);

    if (notification != null) {
      dismiss(notification);
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
    final overlayState = overlay ?? Overlay.of(context, rootOverlay: false);

    _transitionController = _createContainerAnimationController(overlayState!);

    _overlayEntry = _createOverlayEntry(context);

    overlayState.insert(_overlayEntry!);

    _transitionController?.forward();
  }

  AnimationController _createContainerAnimationController(
      OverlayState overlay) {
    return AnimationController(
      duration: _containerAnimationDuration,
      vsync: overlay,
    );
  }

  /// create a [OverlayEntry] as holder of the notifications
  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      opaque: false,
      builder: (context) {
        Widget overlay = ContainerTransition(
          animation: _transitionController!,
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              constraints: const BoxConstraints.tightFor(
                width: 450,
              ),
              child: AnimatedList(
                key: _listGlobalKey,
                initialItemCount: _notifications.length,
                primary: true,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  return ToastBuilderWidget(
                    key: ValueKey(_notifications[index].id),
                    animation: animation,
                    item: _notifications[index],
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
}
