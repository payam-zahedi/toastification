import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/toastification.dart';

/// Keeps the [ToastificationManager]s, and decides which one shows a toast.
///
/// [Toastification] has one host for each [ToastificationScope] in use.
sealed class ToastificationHost {
  ToastificationHost();

  /// creates the host of the given [scope].
  factory ToastificationHost.fromScope(ToastificationScope scope) {
    return switch (scope) {
      ToastificationScope.app => SingleOverlayHost(),
      ToastificationScope.overlay => MultiOverlayHost(),
    };
  }

  /// all the managers of this host.
  Iterable<ToastificationManager> get managers;

  /// returns the manager that shows the toasts of [alignment]
  /// requested for [overlayState], and creates it if there is none.
  ToastificationManager managerFor(
    OverlayState overlayState,
    Alignment alignment,
    ToastificationConfig config,
  );

  /// finds and returns a [ToastificationItem] by its [id]
  ///
  /// if there is no notification with the given [id] it will return null
  ToastificationItem? findToastificationItem(String id) {
    for (final manager in managers) {
      final foundValue = manager.findToastificationItem(id);

      if (foundValue != null) {
        return foundValue;
      }
    }

    return null;
  }

  /// dismisses the given [notification]
  ///
  /// if the [notification] is not in this host, nothing will happen
  void dismiss(
    ToastificationItem notification, {
    bool showRemoveAnimation = true,
  }) {
    // a manager ignores the notifications it doesn't hold.
    for (final manager in managers) {
      manager.dismiss(notification, showRemoveAnimation: showRemoveAnimation);
    }
  }

  /// dismisses all notifications of this host
  void dismissAll({bool delayForAnimation = true}) {
    for (final manager in managers) {
      manager.dismissAll(delayForAnimation: delayForAnimation);
    }
  }
}

/// The host of [ToastificationScope.app].
///
/// it has one manager for each [Alignment], whatever overlay a toast is
/// requested for, so the toasts of an alignment are shown in one overlay.
class SingleOverlayHost extends ToastificationHost {
  final Map<Alignment, ToastificationManager> _managers = {};

  @override
  Iterable<ToastificationManager> get managers => _managers.values;

  @override
  ToastificationManager managerFor(
    OverlayState overlayState,
    Alignment alignment,
    ToastificationConfig config,
  ) {
    return _managers.putIfAbsent(
      alignment,
      () => ToastificationManager(alignment: alignment, config: config),
    );
  }

  /// releases the managers of this host.
  void dispose() {
    for (final manager in managers) {
      manager.dispose();
    }
    _managers.clear();
  }
}

/// The host of [ToastificationScope.overlay].
///
/// each overlay has its own [SingleOverlayHost], so a toast is shown in the
/// overlay it is requested for.
class MultiOverlayHost extends ToastificationHost {
  /// the host of each overlay.
  @visibleForTesting
  final Map<OverlayState, SingleOverlayHost> hosts = {};

  @override
  Iterable<ToastificationManager> get managers =>
      hosts.values.expand((host) => host.managers);

  @override
  ToastificationManager managerFor(
    OverlayState overlayState,
    Alignment alignment,
    ToastificationConfig config,
  ) {
    // an overlay that left the tree, like a closed window,
    // can't show the toasts of its host anymore.
    hosts.removeWhere((overlay, host) {
      if (overlay.mounted) return false;

      host.dispose();
      return true;
    });

    return hosts
        .putIfAbsent(overlayState, SingleOverlayHost.new)
        .managerFor(overlayState, alignment, config);
  }
}
