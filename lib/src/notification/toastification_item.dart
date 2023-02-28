import 'package:pausable_timer/pausable_timer.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class ToastificationItem {
  ToastificationItem({
    this.autoCloseDuration,
  }) : id = uuid.v4();

  final String id;
  final Duration? autoCloseDuration;
}

class ToastificationHolder {
  ToastificationHolder({
    required this.item,
    void Function(ToastificationHolder holder)? onAutoCompleteCompleted,
  }) {
    if (item.autoCloseDuration != null) {
      _timer = PausableTimer(
        item.autoCloseDuration!,
        () {
          onAutoCompleteCompleted?.call(this);
        },
      )..start();
    }
  }

  final ToastificationItem item;

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
