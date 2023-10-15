import 'package:flutter/widgets.dart';
import 'package:toastification/src/core/toastification_config.dart';

class ToastificationConfigProvider extends InheritedWidget {
  const ToastificationConfigProvider({
    super.key,
    required this.config,
    required super.child,
  });

  final ToastificationConfig config;

  static ToastificationConfigProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ToastificationConfigProvider>();
  }

  static ToastificationConfigProvider of(BuildContext context) {
    final ToastificationConfigProvider? result = maybeOf(context);
    assert(result != null, 'No ToastificationConfigProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ToastificationConfigProvider oldWidget) =>
      config != oldWidget.config;
}
