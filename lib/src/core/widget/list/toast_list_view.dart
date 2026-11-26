import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/widget/list/animated_toast_list_view.dart';
import 'package:toastification/src/core/widget/list/stacked_toast_list_view.dart';
import 'package:toastification/src/core/widget/toast_builder.dart';
import 'package:toastification/toastification.dart';

/// Lays out the displayed toasts of a [ToastificationManager] and animates
/// the ones that are added or removed.
abstract class ToastListView {
  ToastListView({
    required this.alignment,
    required this.config,
    required this.items,
    required this.onExitEnd,
  });

  /// creates the view of [ToastificationConfig.layout].
  factory ToastListView.of({
    required Alignment alignment,
    required ToastificationConfig config,
    required List<ToastificationItem> items,
    required VoidCallback onExitEnd,
  }) {
    return switch (config.layout) {
      ToastificationListLayout() => AnimatedToastListView(
        alignment: alignment,
        config: config,
        items: items,
        onExitEnd: onExitEnd,
      ),
      ToastificationStackedLayout() => StackedToastListView(
        alignment: alignment,
        config: config,
        items: items,
        onExitEnd: onExitEnd,
      ),
    };
  }

  final Alignment alignment;

  final ToastificationConfig config;

  /// the displayed toasts, newest first. the manager owns this list.
  final List<ToastificationItem> items;

  /// called when the exit animation of a toast ends.
  final VoidCallback onExitEnd;

  /// whether the list is in the widget tree.
  bool get isBuilt;

  /// whether the exit animation of a toast is still running.
  bool get isExiting;

  Widget build(BuildContext context);

  /// animates in the [item] that was added to [items].
  void insert(ToastificationItem item, Duration duration);

  /// animates out the [item] that was removed from [items] at [index].
  ///
  /// a zero [duration] removes it without an animation.
  void remove(int index, ToastificationItem item, Duration duration);

  @protected
  Widget buildToast(ToastificationItem item, Animation<double> animation) {
    return ToastHolderWidget(
      item: item,
      animation: animation,
      alignment: alignment,
      transformerBuilder: item.animationBuilder ?? config.animationBuilder,
    );
  }
}
