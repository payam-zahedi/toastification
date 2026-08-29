import 'package:material_ui/material_ui.dart';
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
