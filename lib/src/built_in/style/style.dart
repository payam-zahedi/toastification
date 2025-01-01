import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Base abstract class for built-in styles
abstract class BaseToastStyle {
  const BaseToastStyle({
    required this.type,
    this.providedValues,
    this.flutterTheme,
  });

  final ToastificationType type;
  final StyleValues? providedValues;
  final ThemeData? flutterTheme;

  DefaultStyleValues get defaults;

  MaterialColor get primaryColor =>
      providedValues?.primaryColor ?? defaults.primaryColor;
  Color get backgroundColor =>
      providedValues?.backgroundColor ?? defaults.backgroundColor;
  Color get foregroundColor =>
      providedValues?.foregroundColor ?? defaults.foregroundColor;

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

  double get elevation => 0.0;
  List<BoxShadow> get boxShadow => [];

  double get progressIndicatorStrokeWidth =>
      providedValues?.progressIndicatorStrokeWidth ??
      defaults.progressIndicatorStrokeWidth;

  ProgressIndicatorThemeData get progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: foregroundColor.withValues(alpha: .15),
        linearMinHeight: progressIndicatorStrokeWidth,
        linearTrackColor: foregroundColor.withValues(alpha: .05),
        refreshBackgroundColor: foregroundColor.withValues(alpha: .05),
      );
}

class DefaultStyleValues extends StyleValues {
  const DefaultStyleValues({
    required MaterialColor primaryColor,
    required Color backgroundColor,
    required Color foregroundColor,
    EdgeInsetsGeometry padding =
        const EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16),
    BorderSide borderSide = const BorderSide(color: Colors.black12),
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    double progressIndicatorStrokeWidth = 2.0,
  }) : super(
          primaryColor: primaryColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          borderSide: borderSide,
          borderRadius: borderRadius,
          progressIndicatorStrokeWidth: progressIndicatorStrokeWidth,
        );

  @override
  MaterialColor get primaryColor => super.primaryColor!;
  @override
  Color get backgroundColor => super.backgroundColor!;
  @override
  Color get foregroundColor => super.foregroundColor!;
  @override
  EdgeInsetsGeometry get padding => super.padding!;
  @override
  BorderSide get borderSide => super.borderSide!;
  @override
  BorderRadiusGeometry get borderRadius => super.borderRadius!;
  @override
  double get progressIndicatorStrokeWidth =>
      super.progressIndicatorStrokeWidth!;
}

class StyleValues extends Equatable {
  const StyleValues({
    this.primaryColor,
    // TODO: rename it to surfaceLight
    this.backgroundColor,
    // TODO: rename it to surfaceDark
    this.foregroundColor,
    this.padding,
    this.borderSide,
    this.borderRadius,
    this.progressIndicatorStrokeWidth,
  });

  final MaterialColor? primaryColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final double? progressIndicatorStrokeWidth;

  @override
  List<Object?> get props => [
        primaryColor,
        backgroundColor,
        foregroundColor,
        padding,
        borderSide,
        borderRadius,
        progressIndicatorStrokeWidth,
      ];
}
