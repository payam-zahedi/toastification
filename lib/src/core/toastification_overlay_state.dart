// Originally copied from https://github.com/boyan01/overlay_support/blob/master/lib/src/overlay_state_finder.dart

import 'package:flutter/material.dart';
import 'package:toastification/src/core/toastification_config.dart';
import 'package:toastification/src/widget/toastification_config_provider.dart';

final GlobalKey<ToastificationOverlayState> _keyFinder =
    GlobalKey(debugLabel: 'toastification_overlay');

ToastificationOverlayState? findToastificationOverlayState({
  BuildContext? context,
}) {
  if (context == null) {
    assert(
      _debugInitialized,
      'Toastification Not Initialized ! \n'
      'ensure your app wrapped widget ToastificationWrapper',
    );
    final state = _keyFinder.currentState;
    assert(() {
      if (state == null) {
        throw FlutterError(
            '''We can't find ToastificationOverlayState in your app.
         
         Did you declare ToastificationWrapper in your app widget tree like this?
         
         ToastificationWrapper(
           child: MaterialApp(
             title: 'Overlay Support Example',
             home: HomePage(),
           ),
         )
      
      ''');
      }
      return true;
    }());
    return state;
  }
  return context.findAncestorStateOfType<ToastificationOverlayState>();
}

bool _debugInitialized = false;

class ToastificationWrapper extends StatelessWidget {
  final Widget child;

  final ToastificationConfig? config;

  const ToastificationWrapper({
    Key? key,
    required this.child,
    this.config,
  }) : super(key: key);

  ToastificationOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<ToastificationOverlayState>();
  }

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

class _GlobalToastificationOverlay extends StatefulWidget {
  final Widget child;

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
          'There is already an ToastificationWrapper in the Widget tree.',
        );
      }
      return true;
    }());
    return widget.child;
  }

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

    assert(navigator != null,
        '''It looks like you are not using Navigator in your app.
         
         do you wrapped you app widget like this?
         
         ToastificationWrapper(
           child: MaterialApp(
             title: 'My Application',
             home: HomePage(),
           ),
         )
      
      ''');
    return navigator?.overlay;
  }
}

abstract class ToastificationOverlayState<T extends StatefulWidget>
    extends State<T> {
  OverlayState? get overlayState;
}
