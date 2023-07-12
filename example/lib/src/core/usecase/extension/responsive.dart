import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ResponsiveContext on BuildContext {
  T responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    assert(mobile != null || tablet != null || desktop != null);

    final isMobile = ResponsiveWrapper.of(this).isSmallerThan(MOBILE);
    final isTablet = ResponsiveWrapper.of(this).isSmallerThan(TABLET);
    final isDesktop = ResponsiveWrapper.of(this).isTablet ||
        ResponsiveWrapper.of(this).isDesktop;

    if (isMobile) {
      return (mobile ?? tablet ?? desktop)!;
    } else if (isTablet) {
      return (tablet ?? desktop ?? mobile)!;
    } else if (isDesktop) {
      return (desktop ?? tablet ?? mobile)!;
    } else {
      return (mobile ?? tablet ?? desktop)!;
    }
  }
}
