import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    this.isElevated = false,
    this.height = 56,
    this.topMargin = 0,
    required this.child,
  });

  final bool isElevated;
  final double topMargin;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 400),
      margin: !isElevated
          ? EdgeInsetsDirectional.fromSTEB(0, topMargin, 0, 0)
          : EdgeInsetsDirectional.fromSTEB(12, topMargin, 12, 0),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: !isElevated
            ? const Border()
            : Border.all(
                color: colorScheme.onSurface.withOpacity(.08),
                width: 1,
              ),
        boxShadow: [
          !isElevated
              ? const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                )
              : BoxShadow(
                  color: colorScheme.onSurface.withOpacity(.1),
                  blurRadius: 48,
                  spreadRadius: -24,
                  offset: const Offset(0, 24),
                ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
