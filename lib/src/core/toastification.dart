import 'package:flutter/material.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/widget/toastification_config_provider.dart';
import 'package:toastification/src/core/toastification_item.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/built_in_builder.dart';

/// This is the main singleton class instance of the package.
/// You can use this instance to show and manage your notifications.
///
/// use [show] method to show a built-in notifications
/// example :
///
/// ```dart
/// toastification.show(
///   context: context,
///   alignment: Alignment.topRight,
///   title: 'Hello World',
///   description: 'This is a notification',
///   type: ToastificationType.info,
///   style: ToastificationStyle.floating,
///   autoCloseDuration: Duration(seconds: 3),
/// );
/// ```
///
/// use [showCustom] method to show a custom notification
/// you should create your own widget and pass it to the [builder] parameter
/// example :
///
/// ```dart
/// toastification.showCustom(
///   context: context,
///   alignment: Alignment.topRight,
///   animationDuration: Duration(milliseconds: 500),
///   autoCloseDuration: Duration(seconds: 3),
///   builder: (context, item) {
///     return CustomToastWidget();
///   },
/// );
/// ```
final toastification = Toastification();

/// This is the main class of the package.
/// You can use this class to show and manage your notifications.
///
/// use [show] method to show a built-in notifications
/// example :
///
/// ```dart
/// Toastification().show(
///   context: context,
///   alignment: Alignment.topRight,
///   title: 'Hello World',
///   description: 'This is a notification',
///   type: ToastificationType.info,
///   style: ToastificationStyle.floating,
///   autoCloseDuration: Duration(seconds: 3),
/// );
/// ```
///
/// use [showCustom] method to show a custom notification
/// you should create your own widget and pass it to the [builder] parameter
/// example :
///
/// ```dart
/// Toastification().showCustom(
///   context: context,
///   alignment: Alignment.topRight,
///   animationDuration: Duration(milliseconds: 500),
///   autoCloseDuration: Duration(seconds: 3),
///   builder: (context, item) {
///     return CustomToastWidget();
///   },
/// );
/// ```
class Toastification {
  static final Toastification _instance = Toastification._internal();

  Toastification._internal();

  factory Toastification() => _instance;

  final Map<Alignment, ToastificationManager> _managers = {};

  /// shows a custom notification
  /// you should create your own widget and pass it to the [builder] parameter
  ///
  /// example :
  ///
  /// ```dart
  /// toastification.showCustom(
  ///   context: context,
  ///   alignment: Alignment.topRight,
  ///   animationDuration: Duration(milliseconds: 500),
  ///   autoCloseDuration: Duration(seconds: 3),
  ///   builder: (context, item) {
  ///     return CustomToastWidget();
  ///   },
  /// );
  /// ```
  ToastificationItem showCustom({
    required BuildContext context,
    AlignmentGeometry? alignment,
    TextDirection? direction,
    required ToastificationBuilder builder,
    required ToastificationAnimationBuilder? animationBuilder,
    required Duration? animationDuration,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
    VoidCallback? onAutoCompleteCompleted,
  }) {
    direction ??= Directionality.of(context);

    final config = ToastificationConfigProvider.maybeOf(context)?.config ??
        const ToastificationConfig();

    final effectiveAlignment =
        (alignment ?? config.alignment).resolve(direction);

    final manager = _managers.putIfAbsent(
      effectiveAlignment,
      () => ToastificationManager(
        alignment: effectiveAlignment,
        config: config,
      ),
    );

    return manager.showCustom(
      context: context,
      builder: builder,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      overlayState: overlayState,
      onAutoCompleteCompleted: onAutoCompleteCompleted,
    );
  }

  /// using this method you can show a notification by using the [navigator] overlay
  /// you should create your own widget and pass it to the [builder] parameter
  ///
  /// ```dart
  /// toastification.showWithNavigatorState(
  ///   navigator: navigatorState or Navigator.of(context),
  ///   alignment: Alignment.topRight,
  ///   animationDuration: Duration(milliseconds: 500),
  ///   autoCloseDuration: Duration(seconds: 3),
  ///   builder: (context, item) {
  ///     return CustomToastWidget();
  ///   },
  /// );
  /// ```
  ToastificationItem showWithNavigatorState({
    required NavigatorState navigator,
    required ToastificationBuilder builder,
    AlignmentGeometry? alignment,
    TextDirection? textDirection,
    ToastificationAnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Duration? autoCloseDuration,
  }) {
    final context = navigator.context;

    return showCustom(
      context: context,
      alignment: alignment,
      direction: textDirection,
      builder: builder,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      overlayState: navigator.overlay,
    );
  }

  /// shows a built-in notification with the given parameters
  ///
  /// example :
  ///
  /// ```dart
  /// toastification.show(
  ///   context: context,
  ///   alignment: Alignment.topRight,
  ///   title: 'Hello World',
  ///   description: 'This is a notification',
  ///   type: ToastificationType.info,
  ///   style: ToastificationStyle.floating,
  ///   autoCloseDuration: Duration(seconds: 3),
  /// );
  /// ```
  // TODO(payam): add brightness and dark mode items
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
    Color? primaryColor,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    VoidCallback? onCloseTap,
    bool? showProgressBar,
    ProgressIndicatorThemeData? progressBarTheme,
    CloseButtonShowType? closeButtonShowType,
    bool? closeOnClick,
    bool? dragToClose,
    bool? pauseOnHover,
    IconData? closeIcon,
    bool? showCloseButton,
    VoidCallback? onAutoCompleteCompleted,
    Color? loaderBackgroundColor,
    Color? loaderColor,
  }) {
    return showCustom(
      context: context,
      alignment: alignment,
      direction: direction,
      autoCloseDuration: autoCloseDuration,
      overlayState: overlayState,
      onAutoCompleteCompleted: onAutoCompleteCompleted,
      builder: (context, holder) {
        return BuiltInBuilder(
          item: holder,
          type: type,
          style: style,
          title: title,
          description: description,
          icon: icon,
          primaryColor: primaryColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          margin: margin,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          direction: direction,
          onCloseTap: onCloseTap,
          showProgressBar: showProgressBar,
          progressBarTheme: progressBarTheme,
          closeButtonShowType: closeButtonShowType,
          closeOnClick: closeOnClick,
          dragToClose: dragToClose,
          pauseOnHover: pauseOnHover,
          closeIcon: closeIcon ?? Icons.cancel,
          showCloseButton: showCloseButton ?? true,
          loaderBackgroundColor: loaderBackgroundColor,
          loaderColor: loaderColor,
        );
      },
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
    );
  }

  /// finds and returns a [ToastificationItem] by its [id]
  ///
  /// if there is no notification with the given [id] it will return null
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

  /// dismisses the given [notification]
  ///
  /// if the [notification] is not in the list, nothing will happen
  void dismiss(
    ToastificationItem notification, {
    bool showRemoveAnimation = true,
  }) {
    final manager = _managers[notification.alignment];

    if (manager != null) {
      manager.dismiss(notification, showRemoveAnimation: showRemoveAnimation);
    }
  }

  /// dismisses all notifications that are currently showing in the screen
  ///
  /// The [delayForAnimation] parameter is used to determine
  /// whether to wait for the animation to finish or not.
  void dismissAll({bool delayForAnimation = true}) {
    for (final manager in _managers.values) {
      manager.dismissAll(delayForAnimation: delayForAnimation);
    }
  }

  /// dismisses a notification by its [id]
  ///
  /// if there is no notification with the given [id] nothing will happen
  void dismissById(
    String id, {
    bool showRemoveAnimation = true,
  }) {
    final notification = findToastificationItem(id);

    if (notification != null) {
      dismiss(notification, showRemoveAnimation: true);
    }
  }
}
