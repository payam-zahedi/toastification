import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/icon_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:toastification/toastification.dart';

part 'toast_detail_ui_state.freezed.dart';

enum ShadowOptions {
  none(name: 'none', title: 'None', shadow: []),
  lowMode(
      name: 'lowModeShadow', title: 'Low mode shadow', shadow: lowModeShadow),
  highMode(
      name: 'highModeShadow',
      title: 'High mode shadow',
      shadow: highModeShadow);

  const ShadowOptions({
    required this.name,
    required this.title,
    required this.shadow,
  });

  final String name;
  final String title;
  final List<BoxShadow> shadow;
}

@freezed
class ToastDetail with _$ToastDetail {
  factory ToastDetail({
    @Default(ToastificationType.success) ToastificationType type,
    @Default(ToastificationStyle.flat) ToastificationStyle style,
    @Default(Alignment.topLeft) AlignmentGeometry alignment,
    @Default(Text('Component updates available.')) Widget? title,
    @Default(Text('Component updates available.')) Widget? description,
    IconModel? icon,
    Color? primaryColor,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? iconColor,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    @Default(ShadowOptions.none) ShadowOptions shadow,
    TextDirection? direction,
    @Default(Duration(seconds: 4)) Duration? autoCloseDuration,
    Duration? animationDuration,
    @Default(BounceAnimationType()) AnimationType animationType,
    @Default(CloseButtonShowType.always)
    CloseButtonShowType closeButtonShowType,
    @Default(true) bool useContext,
    @Default(false) bool showProgressBar,
    @Default(true) bool closeOnClick,
    @Default(true) bool pauseOnHover,
    @Default(false) bool dragToClose,
    @Default(false) bool applyBlurEffect,
    @Default(true) bool showIcon,
  }) = _ToastDetail;
}

extension ToastDetailSerialization on ToastDetail {
  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'style': style.index,
      'alignment': _alignmentToString(alignment),
      'title': (title as Text).data,
      'description': (description as Text).data,
      'primaryColor': _colorToHex(primaryColor),
      'backgroundColor': _colorToHex(backgroundColor),
      'foregroundColor': _colorToHex(foregroundColor),
      'iconColor': _colorToHex(iconColor),
      'borderRadius': _borderRadiusToString(borderRadius),
      'shadow': shadow.index,
      'direction': direction?.index,
      'autoCloseDuration': autoCloseDuration?.inMilliseconds ?? 4000,
      'animationDuration': animationDuration?.inMilliseconds,
      'animationType': animationType.name,
      'closeButtonShowType': closeButtonShowType.index,
      'useContext': useContext,
      'showProgressBar': showProgressBar,
      'closeOnClick': closeOnClick,
      'pauseOnHover': pauseOnHover,
      'dragToClose': dragToClose,
      'applyBlurEffect': applyBlurEffect,
      'showIcon': showIcon,
      'icon': _iconToMap(icon),
    };
  }

  static ToastDetail fromMap(Map<String, dynamic> map) {
    return ToastDetail(
      type: ToastificationType.values[map['type']],
      style: ToastificationStyle.values[map['style']],
      alignment: _alignmentFromString(map['alignment']),
      title: Text(map['title'] ?? 'Default Title'),
      description: Text(map['description'] ?? 'Default Description'),
      primaryColor: _colorFromHex(map['primaryColor']),
      backgroundColor: _colorFromHex(map['backgroundColor']),
      foregroundColor: _colorFromHex(map['foregroundColor']),
      iconColor: _colorFromHex(map['iconColor']),
      borderRadius: _borderRadiusFromString(map['borderRadius']),
      shadow: ShadowOptions.values[map['shadow']],
      direction: map['direction'] != null
          ? TextDirection.values[map['direction']]
          : null,
      autoCloseDuration: Duration(milliseconds: map['autoCloseDuration']),
      animationDuration: map['animationDuration'] != null
          ? Duration(milliseconds: map['animationDuration'])
          : null,
      animationType: _animationTypeFromName(map['animationType']),
      closeButtonShowType:
          CloseButtonShowType.values[map['closeButtonShowType']],
      useContext: map['useContext'],
      showProgressBar: map['showProgressBar'],
      closeOnClick: map['closeOnClick'],
      pauseOnHover: map['pauseOnHover'],
      dragToClose: map['dragToClose'],
      applyBlurEffect: map['applyBlurEffect'],
      showIcon: map['showIcon'],
      icon: _iconFromMap(map['icon']),
    );
  }

  static Map<String, dynamic>? _iconToMap(IconModel? iconModel) {
    if (iconModel == null) return null;

    final iconData = iconModel.iconData;
    final iconColor = iconModel.color;

    return {
      'name': iconModel.name,
      'code_point': iconData.codePoint,
      'font_family': iconData.fontFamily,
      'font_package': iconData.fontPackage,
      'match_text_direction': iconData.matchTextDirection,
      'color': _colorToHex(iconColor),
    };
  }

  static IconModel? _iconFromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    final castedMap = Map<String, dynamic>.from(map);

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
    return 'topLeft'; // Default case
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
        return Alignment.topLeft; // Default case
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
