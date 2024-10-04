import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_model.freezed.dart';

@freezed
class IconModel with _$IconModel {
  factory IconModel({
    required String name,
    required IconData iconData,
    @Default(Colors.white) Color color,
  }) = _IconModel;
}

extension IconModelSerialization on IconModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code_point': iconData.codePoint,
      'font_family': iconData.fontFamily,
      'font_package': iconData.fontPackage,
      'match_text_direction': iconData.matchTextDirection,
      'color': _colorToHex(color),
    };
  }

  static IconModel fromMap(Map<String, dynamic> map) {
    final int codePoint = map['code_point'];
    final String? fontFamily = map['font_family'];
    final String? fontPackage = map['font_package'];
    final bool matchTextDirection = map['match_text_direction'] ?? false;
    final Color color = _colorFromHex(map['color']) ?? Colors.white;

    return IconModel(
      name: map['name'] ?? 'default_name',
      iconData: IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        matchTextDirection: matchTextDirection,
      ),
      color: color,
    );
  }

  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  static Color? _colorFromHex(String? hex) {
    if (hex == null) return null;
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }
}