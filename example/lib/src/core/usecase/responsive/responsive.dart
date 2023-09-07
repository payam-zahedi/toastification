import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

const smallMobileBreakpointTag = 'Small-Mobile';
const mobileBreakpointTag = 'Mobile';
const tabletBreakpointTag = 'Tablet';
const desktopBreakpointTag = 'Desktop';
const ultraBreakpointTag = 'Ultra';

extension ResponsiveContext on BuildContext {
  String? get currentBreakpoint =>
      ResponsiveWrapper.of(this).activeBreakpoint.name;

  bool get isSmallMobile => currentBreakpoint == smallMobileBreakpointTag;
  bool get isMobile => currentBreakpoint == mobileBreakpointTag;
  bool get isTablet => currentBreakpoint == tabletBreakpointTag;
  bool get isDesktop => currentBreakpoint == desktopBreakpointTag;
  bool get isUltra => currentBreakpoint == ultraBreakpointTag;

  bool get isInMobileZone => isSmallerThan(tabletBreakpointTag);
  bool get isInDesktopZone => isLargerThan(tabletBreakpointTag);

  bool isLargerThan(String breakpointTag) {
    return ResponsiveWrapper.of(this).isLargerThan(breakpointTag);
  }

  bool isSmallerThan(String breakpointTag) {
    return ResponsiveWrapper.of(this).isSmallerThan(breakpointTag);
  }

  T responsiveValue<T>({
    T? smallMobile,
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    assert(mobile != null || tablet != null || desktop != null);

    final isDesktop = isInDesktopZone;

    if (isSmallMobile) {
      return (smallMobile ?? mobile ?? tablet ?? desktop)!;
    } else if (isMobile) {
      return (mobile ?? tablet ?? desktop)!;
    } else if (isTablet) {
      return (tablet ?? desktop ?? mobile)!;
    } else if (isDesktop) {
      return (desktop ?? tablet ?? mobile)!;
    } else {
      return (mobile ?? tablet ?? desktop)!;
    }
  }

  double fractionalSize(double value) {
    return ResponsiveWrapper.of(this).screenWidth * value;
  }

  void responsiveLog() {
    log(name: 'ResponsiveLog:', 'isInMobileZone: $isInMobileZone');
    log(name: 'ResponsiveLog:', 'isMobile: $isMobile');
    log(name: 'ResponsiveLog:', 'isTablet: $isTablet');
    log(name: 'ResponsiveLog:', 'isDesktop: $isDesktop');
    log(name: 'ResponsiveLog:', 'isInDesktopZone: $isInDesktopZone');

    log(
      name: 'ResponsiveLog:',
      'activeBreakpoint: ${ResponsiveWrapper.of(this).activeBreakpoint}',
    );
    log(
      name: 'ResponsiveLog:',
      'screenWidth: ${ResponsiveWrapper.of(this).screenWidth}',
    );
    log(
        name: 'ResponsiveLog:',
        'scaledWidth: ${ResponsiveWrapper.of(this).scaledWidth}');
  }

  double get cardsBorderRadiusValue => isInDesktopZone ? 24 : 16;

  BorderRadius get cardsBorderRadius =>
      BorderRadius.circular(cardsBorderRadiusValue);
}
