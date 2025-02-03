import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

void main() {
  late ToastificationItem toastification;

  Widget mockBuilder(BuildContext context, ToastificationItem holder) {
    return const SizedBox();
  }

  group('ToastificationItem Creation', () {
    test('creates with required parameters only', () {
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
      );

      expect(toastification.id, isNotEmpty);
      expect(toastification.alignment, Alignment.topCenter);
      expect(toastification.autoCloseDuration, isNull);
      expect(toastification.hasTimer, isFalse);
      expect(toastification.timeStatus, ToastTimeStatus.init);
    });

    test('creates with auto close duration', () {
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
      );

      expect(toastification.hasTimer, isTrue);
      expect(toastification.timeStatus, ToastTimeStatus.started);
      expect(toastification.originalDuration, const Duration(seconds: 2));
    });

    test('generates unique IDs for each instance', () {
      final uniqueIds = <String>{};
      const instanceCount = 10;

      // Create multiple instances and collect their IDs
      for (var i = 0; i < instanceCount; i++) {
        final toast = ToastificationItem(
          builder: mockBuilder,
          alignment: Alignment.topCenter,
        );
        uniqueIds.add(toast.id);
      }

      // If all IDs were unique, the Set size should equal the number of instances
      expect(uniqueIds.length, equals(instanceCount));
    });
  });

  group('Timer Controls', () {
    setUp(() {
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
      );
    });

    test('pause() changes status to paused', () {
      expect(toastification.timeStatus, ToastTimeStatus.started);
      toastification.pause();
      expect(toastification.timeStatus, ToastTimeStatus.paused);
      expect(toastification.isRunning, isTrue);
    });

    test('start() changes status to started', () {
      toastification.pause();
      expect(toastification.timeStatus, ToastTimeStatus.paused);
      toastification.start();
      expect(toastification.timeStatus, ToastTimeStatus.started);
      expect(toastification.isRunning, isTrue);
    });

    test('stop() changes status to stopped', () {
      expect(toastification.timeStatus, ToastTimeStatus.started);
      toastification.stop();
      expect(toastification.timeStatus, ToastTimeStatus.stopped);
      expect(toastification.isRunning, isFalse);
    });
  });

  group('Timer Status Listener', () {
    late ToastificationItem toastification;
    late int listenerCallCount;

    setUp(() {
      listenerCallCount = 0;
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
      );
    });

    test('listener is called when status changes', () {
      void listener() {
        listenerCallCount++;
      }

      toastification.addListenerOnTimeStatus(listener);

      toastification.pause();
      expect(listenerCallCount, 1);

      toastification.start();
      expect(listenerCallCount, 2);

      toastification.stop();
      expect(listenerCallCount, 3);

      toastification.removeListenerOnTimeStatus(listener);
    });
  });

  group('Auto Complete Callback', () {
    test('onAutoCompleteCompleted is called when timer finishes', () async {
      bool callbackCalled = false;

      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(milliseconds: 100),
        onAutoCompleteCompleted: (_) {
          callbackCalled = true;
        },
      );

      await Future.delayed(const Duration(milliseconds: 150));

      expect(callbackCalled, isTrue);
      expect(toastification.timeStatus, ToastTimeStatus.finished);
    });
  });

  group('Equatable Implementation', () {
    test('two toastifications with different IDs are not equal', () {
      final toast1 = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
      );

      final toast2 = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
      );

      expect(toast1 == toast2, isFalse);
    });
  });

  group('Edge Cases', () {
    test('timer controls do nothing when no autoCloseDuration', () {
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
      );

      expect(toastification.hasTimer, isFalse);

      // These should not throw errors
      toastification.start();
      expect(toastification.timeStatus, ToastTimeStatus.init);

      toastification.pause();
      expect(toastification.timeStatus, ToastTimeStatus.init);

      toastification.stop();
      expect(toastification.timeStatus, ToastTimeStatus.init);
    });

    test('toString returns correct format', () {
      toastification = ToastificationItem(
        builder: mockBuilder,
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 2),
      );

      expect(
        toastification.toString(),
        contains('id: ${toastification.id}'),
      );
      expect(
        toastification.toString(),
        contains('timerDuration: ${toastification.originalDuration}'),
      );
    });
  });
}
