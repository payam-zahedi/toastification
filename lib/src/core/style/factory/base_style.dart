import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

abstract class BaseStyle implements BuiltInStyle {
  const BaseStyle(this.type, this.theme);

  final ToastificationType type;
  final ThemeData theme;

  @override
  MaterialColor get primaryColor => ToastHelper.createMaterialColor(type.color);

  @override
  Color get foregroundColor => ToastHelper.createMaterialColor(Colors.white);

  @override
  IconData get icon => type.icon;

  @override
  IconData get closeIcon => Icons.close;

  @override
  Color get closeIconColor => foregroundColor.withOpacity(.3);

  @override
  BorderRadiusGeometry get borderRadius =>
      const BorderRadius.all(Radius.circular(12));

  @override
  BorderSide get borderSide => const BorderSide(
        color: Colors.black12,
        width: 1,
      );
  @override
  EdgeInsetsGeometry get padding =>
      const EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16);

  @override
  double get progressIndicatorStrokeWidth => 2.0;

  @override
  TextStyle? get titleTextStyle => theme.textTheme.titleSmall?.copyWith(
        color: foregroundColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  @override
  TextStyle? get descriptionTextStyle => theme.textTheme.titleSmall?.copyWith(
        color: foregroundColor.withOpacity(.8),
        fontSize: 14,
        fontWeight: FontWeight.w300,
        height: 1.2,
      );

  @override
  double get elevation => 0.0;

  @override
  List<BoxShadow> get boxShadow => [];

  @override
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: foregroundColor.withOpacity(.15),
        linearMinHeight: progressIndicatorStrokeWidth,
        linearTrackColor: foregroundColor.withOpacity(.05),
        refreshBackgroundColor: foregroundColor.withOpacity(.05),
      );
}
