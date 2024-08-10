import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/widget/on_hover_builder.dart';
import 'package:toastification/toastification.dart';

class BuiltInBuilder extends StatelessWidget {
  const BuiltInBuilder({
    super.key,
    required this.toastificationModel,
  });
  final ToastificationModel toastificationModel;
  @override
  Widget build(BuildContext context) {
    return _BuiltInContainer(
      toastificationModel: toastificationModel,
      child: BuiltInToastBuilder(
        toastificationModel: toastificationModel,
      ),
    );
  }

  BuiltInStyle toastDefaultStyle() {
    final type = toastificationModel.type ?? ToastificationType.info;

    final style = toastificationModel.style ?? ToastificationStyle.fillColored;

    return BuiltInStyle.fromToastificationStyle(style, type);
  }
}

class BuiltInToastBuilder extends StatelessWidget {
  const BuiltInToastBuilder({
    super.key,
    required this.toastificationModel,
  });
  final ToastificationModel toastificationModel;

  @override
  Widget build(BuildContext context) {
    final style = toastificationModel.style ?? ToastificationStyle.flat;
    final closeButtonType =
        toastificationModel.closeButtonShowType ?? CloseButtonShowType.always;

    return OnHoverShow(
      enabled: closeButtonType == CloseButtonShowType.onHover,
      childBuilder: (context, showWidget) {
        final showCloseButton =
            (closeButtonType != CloseButtonShowType.none) && showWidget;

        return switch (style) {
          ToastificationStyle.flat => FlatToastWidget(
              toastModel: toastificationModel.toastModel(showCloseButton),
            ),
          ToastificationStyle.flatColored => FlatColoredToastWidget(
              toastModel: toastificationModel.toastModel(showCloseButton),
            ),
          ToastificationStyle.fillColored => FilledToastWidget(
              toastModel: toastificationModel.toastModel(showCloseButton),
            ),
          ToastificationStyle.minimal => MinimalToastWidget(
              toastModel: toastificationModel.toastModel(showCloseButton),
            ),
          ToastificationStyle.simple => SimpleToastWidget(
              toastModel: toastificationModel.toastModel(showCloseButton),
            ),
        };
      },
    );
  }
}

/// This widget help you to use the default behavior of the built-in
/// toastification Items
class _BuiltInContainer extends StatelessWidget {
  const _BuiltInContainer({
    required this.toastificationModel,
    required this.child,
  });

  final ToastificationModel toastificationModel;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final closeOnClick = toastificationModel.closeOnClick ?? false;
    final pauseOnHover = toastificationModel.pauseOnHover ?? true;
    final dragToClose = toastificationModel.dragToClose ?? true;
    final callbacks =
        toastificationModel.callbacks ?? const ToastificationCallbacks();
    final hasTimeout = toastificationModel.item!.hasTimer;

    Widget toast = Padding(
      padding: toastificationModel.margin ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: child,
    );

    if ((toastificationModel.pauseOnHover ?? true) && hasTimeout) {
      toast = MouseRegion(
        onEnter: (event) {
          toastificationModel.item!.pause();
        },
        onExit: (event) {
          toastificationModel.item!.start();
        },
        child: toast,
      );
    }

    toast = GestureDetector(
      onTap: () {
        // if close on click is enabled dismiss the toast
        if (closeOnClick) toastification.dismiss(toastificationModel.item!);

        // call the onTap callback
        callbacks.onTap?.call(toastificationModel.item!);
      },
      child: toast,
    );

    if (dragToClose) {
      toast = _FadeDismissible(
        item: toastificationModel.item!,
        pauseOnHover: pauseOnHover,
        dismissDirection: toastificationModel.dismissDirection,
        onDismissed: callbacks.onDismissed == null
            ? null
            : () {
                callbacks.onDismissed?.call(toastificationModel.item!);
              },
        child: toast,
      );
    }

    return toast;
  }
}

class _FadeDismissible extends StatefulWidget {
  const _FadeDismissible({
    required this.item,
    required this.pauseOnHover,
    this.onDismissed,
    this.dismissDirection,
    required this.child,
  });

  final ToastificationItem item;
  final bool pauseOnHover;
  final VoidCallback? onDismissed;
  final DismissDirection? dismissDirection;
  final Widget child;

  @override
  State<_FadeDismissible> createState() => _FadeDismissibleState();
}

class _FadeDismissibleState extends State<_FadeDismissible> {
  double currentOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _handleDragUpdate(true, event.kind);
      },
      onPointerUp: (event) {
        _handleDragUpdate(false, event.kind);
      },
      child: Dismissible(
        key: ValueKey('dismiss-${widget.item.id}'),
        onUpdate: (details) {
          setState(() {
            currentOpacity = details.progress;
          });
        },
        direction: widget.dismissDirection ?? DismissDirection.horizontal,
        behavior: HitTestBehavior.deferToChild,
        onDismissed: (direction) {
          // call the onDismissed callback
          widget.onDismissed?.call();

          toastification.dismiss(widget.item, showRemoveAnimation: false);
        },
        child: Opacity(
          opacity: 1 - currentOpacity,
          child: widget.child,
        ),
      ),
    );
  }

  void _handleDragUpdate(bool startDrag, PointerDeviceKind pointerKind) {
    if (widget.pauseOnHover && pointerKind == PointerDeviceKind.mouse) return;

    if (widget.item.hasTimer && startDrag) {
      widget.item.pause();
    } else {
      widget.item.start();
    }
  }
}
