import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:toastification/src/core/toastification_manager.dart';
import 'package:toastification/src/core/toastification_overlay_state.dart';
import 'package:toastification/src/built_in/built_in_builder.dart';
import 'package:toastification/toastification.dart';

// TODO(payam): add navigator observer

/// This is the main singleton class instance of the package.
/// You can use this instance to show and manage your notifications.
///
/// use [show] method to show a built-in notifications
/// example :
///
/// ```dart
/// toastification.show(
///   context: context, // optional if ToastificationWrapper is in widget tree
///   alignment: Alignment.topRight,
///   title: Text('Hello World'),
///   description: Text('This is a notification'),
///   type: ToastificationType.info,
///   style: ToastificationStyle.flat,
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
///   context: context, // optional if ToastificationWrapper is in widget tree
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
///   context: context, // optional if ToastificationWrapper is in widget tree
///   alignment: Alignment.topRight,
///   title: Text('Hello World'),
///   description: Text('This is a notification'),
///   type: ToastificationType.info,
///   style: ToastificationStyle.flat,
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
///   context: context, // optional if ToastificationWrapper is in widget tree
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

  /// Private constructor for the singleton class
  Toastification._internal();

  /// returns the singleton instance of the class
  factory Toastification() => _instance;

  /// list of managers for each [Alignment] object
  ///
  /// for each [Alignment] object we will create a [ToastificationManager]
  @visibleForTesting
  final Map<Alignment, ToastificationManager> managers = {};

  /// shows a custom notification
  ///
  /// you should create your own widget and pass it to the [builder] parameter
  /// in the [builder] parameter you have the access to [ToastificationItem]
  /// so you may want to use that to create your widget.
  ///
  /// the return value is a [ToastificationItem] that you can use to dismiss the notification
  /// or find the notification details by its [id]
  ///
  /// example :
  ///
  /// ```dart
  /// toastification.showCustom(
  ///   context: context, // optional if ToastificationWrapper is in widget tree
  ///   alignment: Alignment.topRight,
  ///   animationDuration: Duration(milliseconds: 500),
  ///   autoCloseDuration: Duration(seconds: 3),
  ///   builder: (context, item) {
  ///     return CustomToastWidget();
  ///   },
  /// );
  /// ```
  ToastificationItem showCustom({
    BuildContext? context,
    AlignmentGeometry? alignment,
    TextDirection? direction,
    required ToastificationBuilder builder,
    ToastificationAnimationBuilder? animationBuilder,
    Duration? animationDuration,
    Duration? autoCloseDuration,
    OverlayState? overlayState,
    DismissDirection? dismissDirection,
    ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  }) {
    context ??= overlayState?.context;

    final contextProvided = context?.mounted == true;

    if (contextProvided) {
      direction ??= Directionality.of(context!);
      overlayState ??= Overlay.maybeOf(context!, rootOverlay: true);
    }

    /// if context isn't provided
    /// or the overlay can't be found in the provided context
    ToastificationOverlayState? toastificationOverlayState;
    if (overlayState == null) {
      toastificationOverlayState = findToastificationOverlayState();
      overlayState = toastificationOverlayState.overlayState;
    }

    /// find the config from the context or use the global config
    final ToastificationConfig config = (contextProvided
            ? ToastificationConfigProvider.maybeOf(context!)?.config
            : toastificationOverlayState?.globalConfig) ??
        const ToastificationConfig();

    direction ??= TextDirection.ltr;

    final effectiveAlignment =
        (alignment ?? config.alignment).resolve(direction);

    final manager = managers.putIfAbsent(
      effectiveAlignment,
      () => ToastificationManager(
        alignment: effectiveAlignment,
        config: config,
      ),
    );

    return manager.showCustom(
      builder: builder,
      scheduler: SchedulerBinding.instance,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      autoCloseDuration: autoCloseDuration,
      overlayState: overlayState!,
      callbacks: callbacks,
    );
  }

  @Deprecated(
      'use show or showCustom method instead, and you can pass the OverlayState as a parameter')

  /// using this method you can show a notification by using the [navigator] overlay
  /// you should create your own widget and pass it to the [builder] parameter
  ///
  ///
  /// the return value is a [ToastificationItem] that you can use to dismiss the notification
  /// or find the notification details by its [id]
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
    ToastificationCallbacks callbacks = const ToastificationCallbacks(),
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
      callbacks: callbacks,
    );
  }

  /// shows a predefined toast widget base on the parameters
  ///
  /// you can use this method to show a built-in toasts
  ///
  /// the return value is a [ToastificationItem] that you can use to dismiss the notification
  /// or find the notification details by its [id]
  ///
  /// example :
  ///
  /// ```dart
  /// toastification.show(
  ///   context: context, // optional if ToastificationWrapper is in widget tree
  ///   alignment: Alignment.topRight,
  ///   title: Text('Hello World'),
  ///   description: Text('This is a notification'),
  ///   type: ToastificationType.info,
  ///   style: ToastificationStyle.flat,
  ///   autoCloseDuration: Duration(seconds: 3),
  /// );
  /// ```
  /// TODO(payam): add close button icon parameter
  ToastificationItem show({
    BuildContext? context,
    OverlayState? overlayState,
    AlignmentGeometry? alignment,
    Duration? autoCloseDuration,
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
    ToastificationType? type,
    ToastificationStyle? style,
    Widget? title,
    Widget? description,
    Widget? icon,
    Color? primaryColor,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    List<BoxShadow>? boxShadow,
    TextDirection? direction,
    bool? showProgressBar,
    ProgressIndicatorThemeData? progressBarTheme,
    @Deprecated(
        'IMPORTANT: The closeButtonShowType parameter is deprecated and will be removed in the next major version. Use the closeButton parameter instead.')
    CloseButtonShowType? closeButtonShowType,
    ToastCloseButton closeButton = const ToastCloseButton(),
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
    DismissDirection? dismissDirection,
    bool? pauseOnHover,
    bool? applyBlurEffect,
    ToastificationCallbacks callbacks = const ToastificationCallbacks(),
  }) {
    // TODO: remove this variable when the deprecated parameter (closeButtonShowType) is removed
    var toastCloseButton = closeButton;
    if (closeButtonShowType != null &&
        closeButtonShowType != closeButton.showType) {
      toastCloseButton = closeButton.copyWith(showType: closeButtonShowType);
    }

    return showCustom(
      context: context,
      overlayState: overlayState,
      alignment: alignment,
      direction: direction,
      autoCloseDuration: autoCloseDuration,
      animationBuilder: animationBuilder,
      animationDuration: animationDuration,
      callbacks: callbacks,
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
          borderSide: borderSide,
          boxShadow: boxShadow,
          direction: direction,
          showIcon: showIcon,
          showProgressBar: showProgressBar,
          progressBarTheme: progressBarTheme,
          closeButton: toastCloseButton,
          closeOnClick: closeOnClick,
          dragToClose: dragToClose,
          dismissDirection: dismissDirection,
          pauseOnHover: pauseOnHover,
          applyBlurEffect: applyBlurEffect,
          callbacks: callbacks,
        );
      },
    );
  }

  /// finds and returns a [ToastificationItem] by its [id]
  ///
  /// if there is no notification with the given [id] it will return null
  ToastificationItem? findToastificationItem(String id) {
    try {
      for (final manager in managers.values) {
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
    final manager = managers[notification.alignment];

    if (manager != null) {
      manager.dismiss(notification, showRemoveAnimation: showRemoveAnimation);
    }
  }

  /// dismisses all notifications that are currently showing in the screen
  ///
  /// The [delayForAnimation] parameter is used to determine
  /// whether to wait for the animation to finish or not.
  void dismissAll({bool delayForAnimation = true}) {
    for (final manager in managers.values) {
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
      dismiss(notification, showRemoveAnimation: showRemoveAnimation);
    }
  }
}
