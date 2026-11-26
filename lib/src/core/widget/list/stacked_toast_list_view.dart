import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/widget/list/stacked_toast_list.dart';
import 'package:toastification/src/core/widget/list/toast_list_view.dart';
import 'package:toastification/toastification.dart';

/// Shows the toasts in a [StackedToastList].
class StackedToastListView extends ToastListView {
  StackedToastListView({
    required super.alignment,
    required super.config,
    required super.items,
    required super.onExitEnd,
  });

  final _listKey = GlobalKey<StackedToastListState>();

  @override
  bool get isBuilt => _listKey.currentState != null;

  @override
  bool get isExiting => _listKey.currentState?.isExiting ?? false;

  @override
  Widget build(BuildContext context) {
    return StackedToastList(
      key: _listKey,
      reverse: alignment.y >= 0,
      clipBehavior: config.clipBehavior,
      itemBuilder: buildToast,
      onExitEnd: onExitEnd,
    );
  }

  @override
  void insert(ToastificationItem item, Duration duration) {
    _listKey.currentState?.insertItem(item, duration);
  }

  @override
  void remove(int index, ToastificationItem item, Duration duration) {
    _listKey.currentState?.removeItem(item, duration);
  }
}
