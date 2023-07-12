import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    this.active = false,
    this.height = 48,
    this.width,
    this.elevation = 0,
    this.margin,
    this.padding,
    this.onTap,
    this.child,
  });

  final bool active;
  final double? height;
  final double? width;

  final double elevation;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = active
        ? theme.colorScheme.primary.withOpacity(.1)
        : theme.colorScheme.background;

    final foreground =
        active ? theme.colorScheme.primary : theme.colorScheme.onBackground;

    final borderColor =
        active ? theme.colorScheme.primary : theme.colorScheme.outline;

    final borderSize = active ? 1.5 : 1.0;
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          animationDuration: const Duration(milliseconds: 400),
          color: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor, width: borderSize),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 10),
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: active ? FontWeight.w500 : FontWeight.w400,
                    color: foreground,
                  ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      size: 24,
                      color: foreground,
                    ),
                    child: child ?? const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
