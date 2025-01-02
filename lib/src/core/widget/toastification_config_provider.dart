import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/toastification_config.dart';

/// This class is responsible for providing the [ToastificationConfig] to the
/// widget tree
///
/// so you can access it using [ToastificationConfigProvider.of(context)] in the above widgets
///
class ToastificationConfigProvider extends InheritedWidget {
  const ToastificationConfigProvider({
    super.key,
    required this.config,
    required super.child,
  });

  final ToastificationConfig config;

  /// finds the possible nearest [ToastificationConfigProvider] in the upper tree
  static ToastificationConfigProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ToastificationConfigProvider>();
  }

  /// finds the nearest [ToastificationConfigProvider] in the upper tree
  static ToastificationConfigProvider of(BuildContext context) {
    final ToastificationConfigProvider? result = maybeOf(context);
    assert(result != null, 'No ToastificationConfigProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ToastificationConfigProvider oldWidget) =>
      config != oldWidget.config;
}
