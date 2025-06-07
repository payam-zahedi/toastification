import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// enum to define the style of the built-in toastification
enum StandardStyle {
  minimal,
  fillColored,
  flatColored,
  flat,

  /// a simple toast message just show the given title without any icon or extra widget
  simple,
}

// TODO: convert this to sealed class
/// Base abstract class for built-in styles
abstract class BaseStandardToastStyle extends Equatable {
  const BaseStandardToastStyle({
    required this.type,
    this.providedValues,
    this.flutterTheme,
  });

  final ToastificationType type;
  final StandardStyleValues? providedValues;
  final ThemeData? flutterTheme;

  DefaultStyleValues get defaults;

  MaterialColor get primaryColor =>
      providedValues?.primaryColor ?? defaults.primaryColor;
  Color get backgroundColor =>
      providedValues?.surfaceLight ?? defaults.surfaceLight;
  Color get foregroundColor =>
      providedValues?.surfaceDark ?? defaults.surfaceDark;

  /// Returns a blurred version of the background color
  /// usually add some transparency to the color
  Color blurredBackgroundColor(bool applyBlur, Color color) =>
      applyBlur ? color.withValues(alpha: 0.5) : color;

  IconData get icon => type.icon;
  Color get iconColor;
  IconData get closeIcon => Icons.close;
  Color get closeIconColor => foregroundColor.withValues(alpha: .4);

  EdgeInsetsGeometry get padding => providedValues?.padding ?? defaults.padding;
  BorderSide get borderSide =>
      providedValues?.borderSide ?? defaults.borderSide;
  BorderRadiusGeometry get borderRadius =>
      providedValues?.borderRadius ?? defaults.borderRadius;

  double get minHeight => providedValues?.minHeight ?? defaults.minHeight;

  TextStyle? get titleTextStyle => flutterTheme?.textTheme.titleSmall?.copyWith(
        color: foregroundColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  TextStyle? get descriptionTextStyle =>
      flutterTheme?.textTheme.titleSmall?.copyWith(
        color: foregroundColor.withValues(alpha: .8),
        fontSize: 14,
        fontWeight: FontWeight.w300,
        height: 1.2,
      );

  int get titleMaxLines =>
      providedValues?.titleMaxLines ?? defaults.titleMaxLines;

  int get descriptionMaxLines =>
      providedValues?.descriptionMaxLines ?? defaults.descriptionMaxLines;

  double get elevation => 0.0;
  List<BoxShadow> get boxShadow =>
      providedValues?.boxShadow ?? defaults.boxShadow;

  double get progressIndicatorStrokeWidth =>
      providedValues?.progressIndicatorStrokeWidth ??
      defaults.progressIndicatorStrokeWidth;

  ProgressIndicatorThemeData get progressIndicatorTheme =>
      providedValues?.progressIndicatorTheme ?? defaultProgressIndicatorTheme;

  ProgressIndicatorThemeData get defaultProgressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: foregroundColor.withValues(alpha: .15),
        linearMinHeight: progressIndicatorStrokeWidth,
        linearTrackColor: foregroundColor.withValues(alpha: .05),
        refreshBackgroundColor: foregroundColor.withValues(alpha: .05),
      );

  @override
  List<Object?> get props => [
        type,
        providedValues,
        flutterTheme,
      ];
}

class DefaultStyleValues extends StandardStyleValues {
  const DefaultStyleValues({
    required MaterialColor primaryColor,
    required Color surfaceLight,
    required Color surfaceDark,
    EdgeInsetsGeometry padding =
    BorderSide borderSide = const BorderSide(color: Colors.black12),
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    List<BoxShadow> boxShadow = const [],
    int titleMaxLines = 2,
    int descriptionMaxLines = 6,
    double progressIndicatorStrokeWidth = 2.0,
    double minHeight = 64.0,
  }) : super(
          primaryColor: primaryColor,
          surfaceLight: surfaceLight,
          surfaceDark: surfaceDark,
          padding: padding,
          borderSide: borderSide,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          titleMaxLines: titleMaxLines,
          descriptionMaxLines: descriptionMaxLines,
          progressIndicatorStrokeWidth: progressIndicatorStrokeWidth,
          minHeight: minHeight,
        );

  @override
  MaterialColor get primaryColor => super.primaryColor!;
  @override
  Color get surfaceLight => super.surfaceLight!;
  @override
  Color get surfaceDark => super.surfaceDark!;
  @override
  EdgeInsetsGeometry get padding => super.padding!;
  @override
  BorderSide get borderSide => super.borderSide!;
  @override
  BorderRadiusGeometry get borderRadius => super.borderRadius!;
  @override
  List<BoxShadow> get boxShadow => super.boxShadow!;
  @override
  int get titleMaxLines => super.titleMaxLines!;

  @override
  int get descriptionMaxLines => super.descriptionMaxLines!;

  @override
  double get progressIndicatorStrokeWidth =>
      super.progressIndicatorStrokeWidth!;

  @override
  double get minHeight => super.minHeight!;

  @override
  List<Object> get props => [
        primaryColor,
        surfaceLight,
        surfaceDark,
        padding,
        borderSide,
        borderRadius,
        boxShadow,
        titleMaxLines,
        descriptionMaxLines,
        progressIndicatorStrokeWidth,
        minHeight,
      ];
}

class StandardStyleValues extends Equatable {
  const StandardStyleValues({
    this.primaryColor,
    this.surfaceLight,
    this.surfaceDark,
    this.padding,
    this.borderSide,
    this.borderRadius,
    this.boxShadow,
    this.titleMaxLines,
    this.descriptionMaxLines,
    this.progressIndicatorStrokeWidth,
    this.progressIndicatorTheme,
    this.minHeight,
  });

  final MaterialColor? primaryColor;
  final Color? surfaceLight;
  final Color? surfaceDark;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final int? titleMaxLines;
  final int? descriptionMaxLines;

  final double? progressIndicatorStrokeWidth;
  final ProgressIndicatorThemeData? progressIndicatorTheme;
  final double? minHeight;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        primaryColor,
        surfaceLight,
        surfaceDark,
        padding,
        borderSide,
        borderRadius,
        boxShadow,
        titleMaxLines,
        descriptionMaxLines,
        progressIndicatorStrokeWidth,
        progressIndicatorTheme,
        minHeight,
      ];
}

// TODO: remove this when the toastification package is updated
extension ToastStyleExtension on ToastificationStyle {
  StandardStyle get toStandard {
    return switch (this) {
      ToastificationStyle.flat => StandardStyle.flat,
      ToastificationStyle.flatColored => StandardStyle.flatColored,
      ToastificationStyle.fillColored => StandardStyle.fillColored,
      ToastificationStyle.minimal => StandardStyle.minimal,
      ToastificationStyle.simple => StandardStyle.simple,
    };
  }
}
