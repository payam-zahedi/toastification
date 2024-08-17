// Originally copied from https://github.com/boyan01/overlay_support/blob/master/lib/src/overlay_state_finder.dart

import 'package:flutter/material.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/widget/toastification_config_provider.dart';

/// Key used to locate the [ToastificationOverlayState].
final GlobalKey<ToastificationOverlayState> _keyFinder =
    GlobalKey(debugLabel: 'toastification_overlay');

/// This method is responsible for finding [ToastificationOverlayState] with
/// the GlobalKey that is assigned to [_GlobalToastificationOverlay].
///
/// It throws an error if the overlay state is not found and if the app
/// is not wrapped with a [ToastificationWrapper].
ToastificationOverlayState findToastificationOverlayState() {
  assert(
    _debugInitialized,
    'Toastification is not initialized!\n'
    'ensure your app is wrapped with a ToastificationWrapper widget',
  );
  final state = _keyFinder.currentState;
  assert(() {
    if (state == null) {
      throw FlutterError(
        '''
We can't find ToastificationOverlayState in your app.
Did you declare ToastificationWrapper in your app's widget tree like this?
  ToastificationWrapper(
    child: MaterialApp(
      title: 'My Application',
      home: HomePage(),
    ),
  );
''',
      );
    }
    return true;
  }());
  return state!;
}

/// Flag indicating whether Toastification is initialized or not.
bool _debugInitialized = false;

/// A wrapper widget that allows the show method to work without context.
/// You can also provides Toastification configurations to its descendants.
class ToastificationWrapper extends StatelessWidget {
  /// The child widget for this wrapper - Mainly MaterialApp
  final Widget child;

  /// The configuration for Toastification.
  final ToastificationConfig? config;

  const ToastificationWrapper({
    super.key,
    required this.child,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ToastificationConfigProvider(
      config: config ??
          ToastificationConfigProvider.maybeOf(context)?.config ??
          const ToastificationConfig(),
      child: _GlobalToastificationOverlay(child: child),
    );
  }
}

/// A global overlay widget for Toastification.
class _GlobalToastificationOverlay extends StatefulWidget {
  /// The child widget.
  final Widget child;

  /// Constructs a [_GlobalToastificationOverlay] with the provided [child].
  _GlobalToastificationOverlay({required this.child}) : super(key: _keyFinder);

  @override
  StatefulElement createElement() {
    _debugInitialized = true;
    return super.createElement();
  }

  @override
  _GlobalToastificationOverlayState createState() =>
      _GlobalToastificationOverlayState();
}

class _GlobalToastificationOverlayState
    extends ToastificationOverlayState<_GlobalToastificationOverlay> {
  @override
  Widget build(BuildContext context) {
    assert(() {
      if (context
              .findAncestorWidgetOfExactType<_GlobalToastificationOverlay>() !=
          null) {
        throw FlutterError(
          'There is already a ToastificationWrapper in the widget tree.',
        );
      }
      return true;
    }());
    return widget.child;
  }

  /// Retrieves the [OverlayState].
  ///
  /// It traverses the widget tree to find the nearest [Navigator] widget and
  /// retrieves its overlay. If a [Navigator] widget is not found, it throws
  /// an error indicating that the app's widget tree should be wrapped
  /// with a [ToastificationWrapper].
  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;
    void visitor(Element element) {
      if (navigator != null) return;

      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(
      navigator != null,
      '''
It looks like you are not using Navigator in your app.
Did you wrapped your app widget like this?
  ToastificationWrapper(
    child: MaterialApp(
      title: 'My Application',
      home: HomePage(),
    ),
  )
''',
    );
    return navigator?.overlay;
  }

  @override
  ToastificationConfig? get globalConfig =>
      ToastificationConfigProvider.maybeOf(context)?.config;
}

/// Abstract class representing the state of a Toastification overlay.
abstract class ToastificationOverlayState<T extends StatefulWidget>
    extends State<T> {
  /// Retrieves the overlay state.
  OverlayState? get overlayState;

  /// Retrieves the global Toastification configuration.
  ToastificationConfig? get globalConfig;
}
