import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/widget/list/toast_list_view.dart';
import 'package:toastification/toastification.dart';

/// Shows the toasts one after another in an [AnimatedList].
class AnimatedToastListView extends ToastListView {
  AnimatedToastListView({
    required super.alignment,
    required super.config,
    required super.items,
    required super.onExitEnd,
  });

  /// this key is attached to [AnimatedList] so we can add or remove items using it.
  final _listKey = GlobalKey<AnimatedListState>();

  // TODO(payam): remove once the minimum Flutter version includes
  // flutter/flutter#192699, see https://github.com/payam-zahedi/toastification/issues/254
  /// exit animations that are still running.
  ///
  /// on the web, removing the overlay in the frame that finishes an exit
  /// animation makes [AnimatedList] dispose its controller twice, so the
  /// overlay waits for all of them.
  final Set<Animation<double>> _exitAnimations = {};

  @override
  bool get isBuilt => _listKey.currentState != null;

  @override
  bool get isExiting {
    // drop animations whose list was disposed before they finished.
    _exitAnimations.removeWhere((animation) => !animation.isAnimating);

    return _exitAnimations.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      clipBehavior: config.clipBehavior,
      initialItemCount: items.length,
      reverse: alignment.y >= 0,
      primary: true,
      shrinkWrap: true,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
            return buildToast(items[index], animation);
          },
    );
  }

  @override
  void insert(ToastificationItem item, Duration duration) {
    _listKey.currentState?.insertItem(items.indexOf(item), duration: duration);
  }

  @override
  void remove(int index, ToastificationItem item, Duration duration) {
    _listKey.currentState?.removeItem(index, (
      BuildContext context,
      Animation<double> animation,
    ) {
      if (duration == Duration.zero) {
        return const SizedBox.shrink();
      }

      _trackExitAnimation(animation);

      return buildToast(item, animation);
    }, duration: duration);
  }

  /// calls [onExitEnd] when a toast's exit [animation] ends.
  ///
  /// the call is queued after [AnimatedList]'s own cleanup, so the list never
  /// disposes the animation's controller twice.
  void _trackExitAnimation(Animation<double> animation) {
    // the builder runs on every frame of the exit.
    if (!_exitAnimations.add(animation)) return;

    void onStatus(AnimationStatus status) {
      // if it's not dismissed yet, we don't do anything.
      if (status != AnimationStatus.dismissed) return;

      animation.removeStatusListener(onStatus);

      _exitAnimations.remove(animation);
      // queued after AnimatedList's own cleanup for this animation.
      scheduleMicrotask(onExitEnd);
    }

    animation.addStatusListener(onStatus);
  }
}
