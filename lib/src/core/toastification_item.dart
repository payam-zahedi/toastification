import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// enum to define the status of the timer of the toastification item
/// [init] : the timer is not started yet
/// [started] : the timer is started
/// [paused] : the timer is paused
/// [stopped] : the timer is stopped
/// [finished] : the timer is finished
///
enum ToastTimeStatus {
  /// the timer is not started yet
  init,

  /// the timer is started
  started,

  /// the timer is paused
  paused,

  /// the timer is stopped
  stopped,

  /// the timer is completed
  finished,
}

/// type definition for the builder of the custom toastification
/// use this builder to create your own toastification widget
typedef ToastificationBuilder = Widget Function(
  BuildContext context,
  ToastificationItem holder,
);

/// type definition for the animation builder of the custom toastification
/// use this builder to create your own toastification animation
typedef ToastificationAnimationBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Alignment alignment,
  Widget child,
);

/// class to define the toastification item
/// this class is the base model for the toastification item
///
/// * do not create an instance of this class directly
/// [Toastification] class is responsible for creating an instance of this class
///
/// this class will be returned when you call [show] or [showCustom] methods
///
/// you can also use this class to control the toastification items
///
class ToastificationItem implements Equatable {
  ToastificationItem({
    required this.builder,
    required this.alignment,
    this.animationBuilder,
    this.animationDuration,
    this.autoCloseDuration,
    void Function(ToastificationItem holder)? onAutoCompleteCompleted,
  }) : id = _uuid.v4() {
    if (autoCloseDuration != null) {
      _timer = PausableTimer(
        autoCloseDuration!,
        () {
          _timeStatus.value = ToastTimeStatus.finished;
          onAutoCompleteCompleted?.call(this);
        },
      )..start();

      _timeStatus.value = ToastTimeStatus.started;
    } else {
      _timer = null;
    }
  }

  /// unique id for the toastification item
  /// this id will be used to identify the toastification item
  final String id;

  /// the alignment of the toastification item
  /// this alignment will be used to define the position of the toastification item in the screen
  final Alignment alignment;

  /// the duration of the auto close timer
  /// if the [autoCloseDuration] is provided then the timer will be created
  /// and the toastification item will be dismissed automatically after the [autoCloseDuration] is finished
  final Duration? autoCloseDuration;

  /// the builder of the toastification item
  /// this builder will be used to create the toastification item widget
  final ToastificationBuilder builder;

  /// the animation builder of the toastification item
  final ToastificationAnimationBuilder? animationBuilder;

  /// the animation duration of the toastification item animation
  final Duration? animationDuration;

  /// the timer of the toastification item
  late final PausableTimer? _timer;

  /// the status notifier of the timer
  final ValueNotifier<ToastTimeStatus> _timeStatus =
      ValueNotifier(ToastTimeStatus.init);

  /// the status of the timer
  ToastTimeStatus get timeStatus => _timeStatus.value;

  /// The original duration this timer was created with.
  Duration? get originalDuration => _timer?.duration;

  /// the amount of the time that timer has been running for.
  ///
  /// If the timer is paused, the elapsed time is also not computed anymore, so
  /// [elapsed] is always less than or equals to the [duration].  Duration? get elapsedDuration => _timer?.elapsed;
  Duration? get elapsedDuration => _timer?.elapsed;

  /// checks if the [autoCloseDuration] is provided or not
  /// if the [autoCloseDuration] is provided then the timer will be created
  bool get hasTimer => _timer != null;

  /// checks if the timer is running or not
  bool get isRunning =>
      _timeStatus.value == ToastTimeStatus.started ||
      _timeStatus.value == ToastTimeStatus.paused;

  /// checks if the timer is started or not
  bool get isStarted => _timeStatus.value == ToastTimeStatus.started;

  /// starts the timer
  void start() {
    if (hasTimer) {
      _timer?.start();
      _timeStatus.value = ToastTimeStatus.started;
    }
  }

  /// pauses the timer
  void pause() {
    if (hasTimer) {
      _timer?.pause();
      _timeStatus.value = ToastTimeStatus.paused;
    }
  }

  /// stops the timer
  void stop() {
    if (hasTimer) {
      _timer?.cancel();
      _timeStatus.value = ToastTimeStatus.stopped;
    }
  }

  /// add a listener to the timer status notifier
  void addListenerOnTimeStatus(VoidCallback listener) {
    _timeStatus.addListener(listener);
  }

  /// remove a listener from the timer status notifier
  void removeListenerOnTimeStatus(VoidCallback listener) {
    _timeStatus.removeListener(listener);
  }

  @override
  String toString() {
    return 'id: $id, timerDuration: $originalDuration, elapsedDuration: $elapsedDuration';
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => false;
}
