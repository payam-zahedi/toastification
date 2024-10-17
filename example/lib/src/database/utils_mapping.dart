import 'package:drift/drift.dart';
import 'package:example/src/database/database.dart';
import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

extension ToastDetailDrift on ToastDetail {
  ToastDetailsSchemaCompanion toCompanion(ToastDetail details) {
    return ToastDetailsSchemaCompanion(
      type: Value(details.type.index),
      style: Value(details.style.index),
      alignment: Value(_alignmentToString(details.alignment)),
      title: Value((details.title as Text).data),
      description: Value((details.description as Text).data),
      primaryColor: Value(_colorToHex(details.primaryColor)),
      backgroundColor: Value(_colorToHex(details.backgroundColor)),
      foregroundColor: Value(_colorToHex(details.foregroundColor)),
      iconColor: Value(_colorToHex(details.iconColor)),
      borderRadius: Value(_borderRadiusToString(details.borderRadius)),
      shadow: Value(details.shadow.index),
      direction: Value(details.direction?.index),
      autoCloseDuration:
          Value(details.autoCloseDuration?.inMilliseconds ?? 4000),
      animationDuration: Value(details.animationDuration?.inMilliseconds),
      animationType: Value(details.animationType.name),
      closeButtonShowType: Value(details.closeButtonShowType.index),
      useContext: Value(details.useContext),
      showProgressBar: Value(details.showProgressBar),
      closeOnClick: Value(details.closeOnClick),
      pauseOnHover: Value(details.pauseOnHover),
      dragToClose: Value(details.dragToClose),
      applyBlurEffect: Value(details.applyBlurEffect),
      showIcon: Value(details.showIcon),
      icon: Value(_iconToMap(details.icon)),
    );
  }

  static ToastDetail fromCompanion(ToastDetailsSchemaData? data) {
    if (data == null) {
      return ToastDetail(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        alignment: Alignment.topLeft,
        title: const Text('Component updates available.'),
        description: const Text('Component updates available.'),
        iconColor: Colors.white,
        borderRadius: BorderRadius.zero,
        shadow: ShadowOptions.none,
        direction: null,
        autoCloseDuration: const Duration(milliseconds: 4000),
        animationDuration: null,
        animationType: const BounceAnimationType(),
        closeButtonShowType: CloseButtonShowType.always,
        useContext: true,
        showProgressBar: false,
        closeOnClick: true,
        pauseOnHover: true,
        dragToClose: false,
        applyBlurEffect: false,
        showIcon: true,
        icon: null,
      );
    }
    return ToastDetail(
      type: ToastificationType.values[data.type],
      style: ToastificationStyle.values[data.style],
      alignment: _alignmentFromString(data.alignment),
      title: Text(data.title ?? 'Default Title'),
      description: Text(data.description ?? 'Default Description'),
      primaryColor: _colorFromHex(data.primaryColor),
      backgroundColor: _colorFromHex(data.backgroundColor),
      foregroundColor: _colorFromHex(data.foregroundColor),
      iconColor: _colorFromHex(data.iconColor),
      borderRadius: _borderRadiusFromString(data.borderRadius),
      shadow: ShadowOptions.values[data.shadow],
      direction:
          data.direction != null ? TextDirection.values[data.direction!] : null,
      autoCloseDuration: Duration(milliseconds: data.autoCloseDuration ?? 4000),
      animationDuration: data.animationDuration != null
          ? Duration(milliseconds: data.animationDuration!)
          : null,
      animationType: _animationTypeFromName(data.animationType),
      closeButtonShowType:
          CloseButtonShowType.values[data.closeButtonShowType ?? 0],
      useContext: data.useContext,
      showProgressBar: data.showProgressBar,
      closeOnClick: data.closeOnClick,
      pauseOnHover: data.pauseOnHover,
      dragToClose: data.dragToClose,
      applyBlurEffect: data.applyBlurEffect,
      showIcon: data.showIcon,
      icon: _iconFromMap(data.icon),
    );
  }

  static String? _iconToMap(IconModel? iconModel) {
    if (iconModel == null) return null;

    final iconData = iconModel.iconData;
    final iconColor = iconModel.color;

    final iconDataMap = {
      'name': iconModel.name,
      'code_point': iconData.codePoint,
      'font_family': iconData.fontFamily,
      'font_package': iconData.fontPackage,
      'match_text_direction': iconData.matchTextDirection,
      'color': _colorToHex(iconColor),
    };

    return iconDataMap.toString();
  }

  static IconModel? _iconFromMap(String? map) {
    if (map == null) return null;

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
    final Color color = _colorFromHex(castedMap['color']) ?? Colors.white;

    return IconModel(
      name: castedMap['name'] ?? 'default_name',
      iconData: IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        matchTextDirection: matchTextDirection,
      ),
      color: color,
    );
  }

  static String _alignmentToString(AlignmentGeometry alignment) {
    if (alignment == Alignment.topLeft) return 'topLeft';
    if (alignment == Alignment.topRight) return 'topRight';
    if (alignment == Alignment.topCenter) return 'topCenter';
    if (alignment == Alignment.center) return 'center';
    if (alignment == Alignment.centerLeft) return 'centerLeft';
    if (alignment == Alignment.centerRight) return 'centerRight';
    if (alignment == Alignment.bottomLeft) return 'bottomLeft';
    if (alignment == Alignment.bottomRight) return 'bottomRight';
    if (alignment == Alignment.bottomCenter) return 'bottomCenter';
    return 'topLeft'; 
  }

  static AnimationType _animationTypeFromName(String name) {
    switch (name) {
      case 'Bounce':
        return const BounceAnimationType();
      case 'Fade':
        return const FadeAnimationType();
      case 'Scale':
        return const ScaleAnimationType();
      default:
        return const BounceAnimationType();
    }
  }

  static AlignmentGeometry _alignmentFromString(String alignment) {
    switch (alignment) {
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'topCenter':
        return Alignment.topCenter;
      case 'center':
        return Alignment.center;
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'centerRight':
        return Alignment.centerRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      default:
        return Alignment.topLeft; 
    }
  }

  static String? _colorToHex(Color? color) {
    return color != null
        ? '#${color.value.toRadixString(16).padLeft(8, '0')}'
        : null;
  }

  static Color? _colorFromHex(String? hex) {
    if (hex == null) return null;
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  static String? _borderRadiusToString(BorderRadiusGeometry? borderRadius) {
    if (borderRadius is BorderRadius) {
      return '${borderRadius.topLeft.x},${borderRadius.topLeft.y},${borderRadius.bottomRight.x},${borderRadius.bottomRight.y}';
    }
    return null;
  }

  static BorderRadiusGeometry? _borderRadiusFromString(String? borderRadius) {
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
