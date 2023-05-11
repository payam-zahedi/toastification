import 'package:flutter/material.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/core/toastification_item.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/built_in_builder.dart';

final toastification = Toastification();

class Toastification {
  static final Toastification _instance = Toastification._internal();

  Toastification._internal();

  factory Toastification() => _instance;

  final Map<Alignment, ToastificationManager> _managers = {};

  ToastificationConfig config = const ToastificationConfig();

  /// using this method you can show a notification
  /// if there is no notification in the notification list,
  /// we will animate in the overlay
  /// otherwise we will just add the notification to the list
  ToastificationItem showCustom({
    required BuildContext context,
    AlignmentGeometry? alignment,
    required ToastificationBuilder builder,
    required ToastificationAnimationBuilder? animationBuilder,
    required Duration? animationDuration,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
  }) {
    final effectiveAlignment =
        (alignment ?? config.alignment).resolve(Directionality.of(context));

    final manager = _managers.putIfAbsent(
      effectiveAlignment,
      () =>
          ToastificationManager(alignment: effectiveAlignment, config: config),
    );

    return manager.showCustom(
      context: context,
      builder: builder,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      overlayState: overlayState,
    );
  }

  /// using this method you can show a notification by using the [navigator] overlay
  ToastificationItem showWithNavigatorState({
    required NavigatorState navigator,
    required ToastificationBuilder builder,
    AlignmentGeometry? alignment,
    ToastificationAnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Duration? autoCloseDuration,
  }) {
    final context = navigator.context;

    return showCustom(
      context: context,
      alignment: alignment,
      builder: builder,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      overlayState: navigator.overlay,
    );
  }

  ToastificationItem show({
    required BuildContext context,
    AlignmentGeometry? alignment,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
    ToastificationAnimationBuilder? animationBuilder,
    ToastificationType? type,
    ToastificationStyle? style,
    required String title,
    Duration? animationDuration,
    String? description,
    Widget? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Brightness? brightness,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    double? elevation,
    VoidCallback? onCloseTap,
    bool? showProgressBar,
    bool? showCloseButton,
    bool? closeOnClick,
    bool? pauseOnHover,
  }) {
    return showCustom(
      context: context,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
      overlayState: overlayState,
      builder: (context, holder) {
        return BuiltInWidgetBuilder(
          item: holder,
          type: type,
          style: style,
          title: title,
          description: description,
          icon: icon,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          brightness: brightness,
          padding: padding,
          margin: margin,
          borderRadius: borderRadius,
          elevation: elevation,
          onCloseTap: onCloseTap,
          showProgressBar: showProgressBar,
          showCloseButton: showCloseButton,
          closeOnClick: closeOnClick,
          pauseOnHover: pauseOnHover,
        );
      },
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
    );
  }

  ToastificationItem? findToastificationItem(String id) {
    try {
      for (final manager in _managers.values) {
        final foundValue = manager.findToastificationItem(id);

        if (foundValue != null) {
          return foundValue;
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  /// using this method you can remove a notification
  /// if there is no notification in the notification list,
  /// we will remove the overlay entry
  void dismiss(ToastificationItem notification) {
    final manager = _managers[notification.alignment];

    if (manager != null) {
      manager.dismiss(notification);
    }
  }

  /// This function dismisses all the notifications in the [_notifications] list.
  /// The delayForAnimation parameter is optional and defaults to true.
  /// When true, it adds a delay for better animation.
  void dismissAll({bool delayForAnimation = true}) {
    for (final manager in _managers.values) {
      manager.dismissAll(delayForAnimation: delayForAnimation);
    }
  }

  /// remove a notification by its [id]
  /// if there is no notification with the given [id], nothing will happen
  void dismissById(String id) {
    final notification = findToastificationItem(id);

    if (notification != null) {
      dismiss(notification);
    }
  }
}
