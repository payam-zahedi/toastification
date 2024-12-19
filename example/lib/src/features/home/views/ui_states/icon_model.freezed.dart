// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IconModel {
  String get name => throw _privateConstructorUsedError;
  IconData get iconData => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  /// Create a copy of IconModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IconModelCopyWith<IconModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IconModelCopyWith<$Res> {
  factory $IconModelCopyWith(IconModel value, $Res Function(IconModel) then) =
      _$IconModelCopyWithImpl<$Res, IconModel>;
  @useResult
  $Res call({String name, IconData iconData, Color color});
}

/// @nodoc
class _$IconModelCopyWithImpl<$Res, $Val extends IconModel>
    implements $IconModelCopyWith<$Res> {
  _$IconModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IconModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? iconData = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: null == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IconModelImplCopyWith<$Res>
    implements $IconModelCopyWith<$Res> {
  factory _$$IconModelImplCopyWith(
          _$IconModelImpl value, $Res Function(_$IconModelImpl) then) =
      __$$IconModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, IconData iconData, Color color});
}

/// @nodoc
class __$$IconModelImplCopyWithImpl<$Res>
    extends _$IconModelCopyWithImpl<$Res, _$IconModelImpl>
    implements _$$IconModelImplCopyWith<$Res> {
  __$$IconModelImplCopyWithImpl(
      _$IconModelImpl _value, $Res Function(_$IconModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IconModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? iconData = null,
    Object? color = null,
  }) {
    return _then(_$IconModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconData: null == iconData
          ? _value.iconData
          : iconData // ignore: cast_nullable_to_non_nullable
              as IconData,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$IconModelImpl implements _IconModel {
  _$IconModelImpl(
      {required this.name, required this.iconData, this.color = Colors.white});

  @override
  final String name;
  @override
  final IconData iconData;
  @override
  @JsonKey()
  final Color color;

  @override
  String toString() {
    return 'IconModel(name: $name, iconData: $iconData, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IconModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconData, iconData) ||
                other.iconData == iconData) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, iconData, color);

  /// Create a copy of IconModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IconModelImplCopyWith<_$IconModelImpl> get copyWith =>
      __$$IconModelImplCopyWithImpl<_$IconModelImpl>(this, _$identity);
}

abstract class _IconModel implements IconModel {
  factory _IconModel(
      {required final String name,
      required final IconData iconData,
      final Color color}) = _$IconModelImpl;

  @override
  String get name;
  @override
  IconData get iconData;
  @override
  Color get color;

  /// Create a copy of IconModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IconModelImplCopyWith<_$IconModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
