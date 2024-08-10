import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class BuildInContentModel {
  Widget? title;
  Widget? description;
  Color? primaryColor;
  Color? foregroundColor;
  Color? backgroundColor;
  bool showProgressBar;
  double? progressBarValue;
  Widget? progressBarWidget;
  final BuiltInStyle style;
  final ProgressIndicatorThemeData? progressIndicatorTheme;

  BuildInContentModel({
    required this.style,
    this.title,
    this.description,
    this.primaryColor,
    this.foregroundColor,
    this.backgroundColor,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
  });
}
