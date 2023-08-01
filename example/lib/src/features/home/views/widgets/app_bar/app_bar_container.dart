import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  final Widget child;
  final double shrinkPercentage;
  final double topMargin;

  const AppBarContainer({
    super.key,
    required this.shrinkPercentage,
    required this.child,
    this.topMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      height: 72,
      duration: const Duration(milliseconds: 700),
      margin: EdgeInsetsDirectional.lerp(
        EdgeInsetsDirectional.fromSTEB(0, topMargin, 0, 0),
        EdgeInsetsDirectional.fromSTEB(12, topMargin, 12, 0),
        shrinkPercentage,
      ),
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
        border: Border.lerp(
          Border.all(
            width: 0,
            color: Colors.transparent,
          ),
          Border.all(
            color: colorScheme.onBackground.withAlpha(40),
            width: 1,
          ),
          shrinkPercentage,
        ),
        color: colorScheme.background,
        boxShadow: [
          BoxShadow.lerp(
            const BoxShadow(
              color: Colors.transparent,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: colorScheme.onBackground.withOpacity(.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            shrinkPercentage,
          )!,
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
