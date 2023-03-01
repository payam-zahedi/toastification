import 'package:flutter/cupertino.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

typedef ToastificationBuilder = Widget Function(
  BuildContext context,
  ToastificationItem holder,
);

class ToastificationItem {
  ToastificationItem({
    required this.builder,
    this.autoCloseDuration,
    void Function(ToastificationItem holder)? onAutoCompleteCompleted,
  }) : id = uuid.v4() {
    if (autoCloseDuration != null) {
      _timer = PausableTimer(
        autoCloseDuration!,
        () {
          onAutoCompleteCompleted?.call(this);
        },
      )..start();
    }
  }

  final String id;
  final Duration? autoCloseDuration;
  final ToastificationBuilder builder;

  late final PausableTimer? _timer;

  Duration? get currentDuration => _timer?.duration;
  Duration? get elapsedDuration => _timer?.elapsed;

  void start() {
    _timer?.start();
  }

  void pause() {
    _timer?.pause();
  }

  void stop() {
    _timer?.cancel();
  }
}
