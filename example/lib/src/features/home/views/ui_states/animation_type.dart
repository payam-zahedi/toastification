import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

sealed class AnimationType {
  const AnimationType({
    required this.title,
    required this.name,
  });

  final String title;
  final String name;

  String buildCode();

  Widget builder(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  );

  static const types = [
    BounceAnimationType(),
    FadeAnimationType(),
    ScaleAnimationType(),
  ];

  @override
  String toString() => name;
}

class BounceAnimationType extends AnimationType {
  const BounceAnimationType()
      : super(
          title: 'Bounce (default)',
          name: 'Bounce',
        );

  @override
  String buildCode() {
    return '';
  }

  @override
  Widget builder(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  ) {
    return DefaultToastificationTransition(
      animation: animation,
      alignment: alignment,
      child: child,
    );
  }
}

class FadeAnimationType extends AnimationType {
  const FadeAnimationType()
      : super(
          title: 'Fade in / out',
          name: 'Fade',
        );

  @override
  String buildCode() {
    return '''(context, animation, alignment, child,) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }''';
  }

  @override
  Widget builder(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class ScaleAnimationType extends AnimationType {
  const ScaleAnimationType()
      : super(
          title: 'Slide in / out',
          name: 'Scale',
        );

  @override
  String buildCode() {
    return '''(context, animation, alignment, child,) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    }''';
  }

  @override
  Widget builder(
    BuildContext context,
    Animation<double> animation,
    Alignment alignment,
    Widget child,
  ) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
