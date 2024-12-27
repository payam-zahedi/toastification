import 'package:drift/drift.dart';
import 'package:example/src/database/database.dart';
import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class UtilsMapping {
  const UtilsMapping._();

  static String alignmentToString(AlignmentGeometry alignment) {
    Alignment effectiveAlignment = alignment is Alignment
        ? alignment
        : alignment.resolve(TextDirection.ltr);

    return '${effectiveAlignment.x},${effectiveAlignment.y}';
  }

  static AlignmentGeometry alignmentFromString(String alignment) {
    try {
      final coordinates = alignment.split(',').map(double.parse).toList();
      if (coordinates.length != 2) {
        return Alignment.center;
      }
      return Alignment(coordinates[0], coordinates[1]);
    } catch (e) {
      return Alignment.topLeft;
    }
  }

  static AnimationType animationTypeFromName(String name) {
    return AnimationType.types.firstWhere(
      (type) => type.name == name,
      orElse: () => const BounceAnimationType(),
    );
  }

  static String? colorToHex(Color? color) {
    return color != null
        ? '#${color.intValue.toRadixString(16).padLeft(8, '0')}'
        : null;
  }

  static Color? colorFromHex(String? hex) {
    if (hex == null) return null;
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  static String? borderRadiusToString(BorderRadiusGeometry? borderRadius) {
    if (borderRadius is BorderRadius) {
      return '${borderRadius.topLeft.x},${borderRadius.topLeft.y},${borderRadius.bottomRight.x},${borderRadius.bottomRight.y}';
    }
    return null;
  }

  static BorderRadiusGeometry? borderRadiusFromString(String? borderRadius) {
    if (borderRadius == null) return null;
    var values = borderRadius.split(',').map(double.parse).toList();
    return BorderRadius.only(
      topLeft: Radius.circular(values[0]),
      topRight: Radius.circular(values[1]),
      bottomLeft: Radius.circular(values[2]),
      bottomRight: Radius.circular(values[3]),
    );
  }
}

extension ToastDetailDrift on ToastDetail {
  ToastDetailsSchemaCompanion toCompanion() {
    return ToastDetailsSchemaCompanion(
      type: Value(ToastificationType.defaultValues.indexOf(type)),
      style: Value(style.index),
      alignment: Value(UtilsMapping.alignmentToString(alignment)),
      title: Value((title as Text).data),
      description: Value((description as Text).data),
      primaryColor: Value(UtilsMapping.colorToHex(primaryColor)),
      backgroundColor: Value(UtilsMapping.colorToHex(backgroundColor)),
      foregroundColor: Value(UtilsMapping.colorToHex(foregroundColor)),
      iconColor: Value(UtilsMapping.colorToHex(iconColor)),
      borderRadius: Value(UtilsMapping.borderRadiusToString(borderRadius)),
      shadow: Value(shadow.index),
      direction: Value(direction?.index),
      autoCloseDuration: Value(autoCloseDuration?.inMilliseconds ?? 4000),
      animationDuration: Value(animationDuration?.inMilliseconds),
      animationType: Value(animationType.name),
      closeButtonShowType: Value(closeButtonShowType.index),
      useContext: Value(useContext),
      showProgressBar: Value(showProgressBar),
      closeOnClick: Value(closeOnClick),
      pauseOnHover: Value(pauseOnHover),
      dragToClose: Value(dragToClose),
      applyBlurEffect: Value(applyBlurEffect),
      showIcon: Value(showIcon),
      icon: Value(icon == null ? null : IconMapper(icon!).toMap()),
    );
  }

  static ToastDetail fromCompanion(ToastDetailsSchemaData? data) {
    if (data == null) return ToastDetail();

    return ToastDetail(
      type: ToastificationType.defaultValues[data.type],
      style: ToastificationStyle.values[data.style],
      alignment: UtilsMapping.alignmentFromString(data.alignment),
      title: Text(data.title ?? 'Default Title'),
      description: Text(data.description ?? 'Default Description'),
      primaryColor: UtilsMapping.colorFromHex(data.primaryColor),
      backgroundColor: UtilsMapping.colorFromHex(data.backgroundColor),
      foregroundColor: UtilsMapping.colorFromHex(data.foregroundColor),
      iconColor: UtilsMapping.colorFromHex(data.iconColor),
      borderRadius: UtilsMapping.borderRadiusFromString(data.borderRadius),
      shadow: ShadowOptions.values[data.shadow],
      direction:
          data.direction != null ? TextDirection.values[data.direction!] : null,
      autoCloseDuration: Duration(milliseconds: data.autoCloseDuration ?? 4000),
      animationDuration: data.animationDuration != null
          ? Duration(milliseconds: data.animationDuration!)
          : null,
      animationType: UtilsMapping.animationTypeFromName(data.animationType),
      closeButtonShowType:
          CloseButtonShowType.values[data.closeButtonShowType ?? 0],
      useContext: data.useContext,
      showProgressBar: data.showProgressBar,
      closeOnClick: data.closeOnClick,
      pauseOnHover: data.pauseOnHover,
      dragToClose: data.dragToClose,
      applyBlurEffect: data.applyBlurEffect,
      showIcon: data.showIcon,
      icon: data.icon == null ? null : IconMapper.fromMap(data.icon!).iconModel,
    );
  }
}

class IconMapper {
  final IconModel iconModel;

  const IconMapper(this.iconModel);

  factory IconMapper.fromMap(String map) {
    final parsedMap = map.substring(1, map.length - 1).split(', ');

    final Map<String, dynamic> castedMap = {
      'name': parsedMap[0].split(': ')[1],
      'code_point': int.parse(parsedMap[1].split(': ')[1]),
      'font_family': parsedMap[2].split(': ')[1],
      'font_package': parsedMap[3].split(': ')[1],
      'match_text_direction': parsedMap[4].split(': ')[1] == 'true',
      'color': parsedMap[5].split(': ')[1],
    };

    final int codePoint = castedMap['code_point'];
    final String? fontFamily = castedMap['font_family'];
    final String? fontPackage = castedMap['font_package'];
    final bool matchTextDirection = castedMap['match_text_direction'] ?? false;
    final Color color =
        UtilsMapping.colorFromHex(castedMap['color']) ?? Colors.white;

    final icon = IconModel(
      name: castedMap['name'] ?? 'default_name',
      iconData: IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        matchTextDirection: matchTextDirection,
      ),
      color: color,
    );

    return IconMapper(icon);
  }

  String toMap() {
    final iconData = iconModel.iconData;
    final iconColor = iconModel.color;

    final iconDataMap = {
      'name': iconModel.name,
      'code_point': iconData.codePoint,
      'font_family': iconData.fontFamily,
      'font_package': iconData.fontPackage,
      'match_text_direction': iconData.matchTextDirection,
      'color': UtilsMapping.colorToHex(iconColor),
    };

    return iconDataMap.toString();
  }
}
