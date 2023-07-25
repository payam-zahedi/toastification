import 'package:example/src/core/usecase/responsive/responsive.dart';
import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  final Widget child;
  final bool isWithBorder;

  const AppBarContainer({
    super.key,
    required this.isWithBorder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final sidePaddings = context.responsiveValue(
      desktop: 12.0,
      tablet: 6.0,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      margin: EdgeInsetsDirectional.fromSTEB(
        isWithBorder ? sidePaddings : 0,
        isWithBorder ? 12 : 0,
        isWithBorder ? sidePaddings : 0,
        0,
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        sidePaddings,
        12,
        sidePaddings,
        12,
      ),
      decoration: BoxDecoration(
        border: isWithBorder
            ? Border.all(
                color: colorScheme.onBackground.withAlpha(40),
                width: 1,
              )
            : null,
        color: colorScheme.background,
        boxShadow: isWithBorder
            ? [
                BoxShadow(
                  color: colorScheme.onBackground.withOpacity(.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
