import 'package:flutter/cupertino.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:uuid/uuid.dart';

enum ToastTimeStatus {
  init,
  started,
  paused,
  stopped,
  finished,
}

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
          _timeStatus.value = ToastTimeStatus.finished;
          onAutoCompleteCompleted?.call(this);
        },
      )..start();

      _timeStatus.value = ToastTimeStatus.started;
    }
  }

  final String id;
  final Duration? autoCloseDuration;
  final ToastificationBuilder builder;

  late final PausableTimer? _timer;

  final ValueNotifier<ToastTimeStatus> _timeStatus =
      ValueNotifier(ToastTimeStatus.init);

  ToastTimeStatus get timeStatus => _timeStatus.value;

  Duration? get currentDuration => _timer?.duration;
  Duration? get elapsedDuration => _timer?.elapsed;

  bool get isRunning =>
      _timeStatus.value == ToastTimeStatus.started ||
      _timeStatus.value == ToastTimeStatus.paused;

  void start() {
    _timer?.start();
    _timeStatus.value = ToastTimeStatus.started;
  }

  void pause() {
    _timer?.pause();
    _timeStatus.value = ToastTimeStatus.paused;
  }

  void stop() {
    _timer?.cancel();
    _timeStatus.value = ToastTimeStatus.stopped;
  }

  void addListenerOnTimeStatus(VoidCallback listener) {
    _timeStatus.addListener(listener);
  }

  void removeListenerOnTimeStatus(VoidCallback listener) {
    _timeStatus.removeListener(listener);
  }
}
