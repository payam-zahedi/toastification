// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ToastDetailsSchemaTable extends ToastDetailsSchema
    with TableInfo<$ToastDetailsSchemaTable, ToastDetailsSchemaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToastDetailsSchemaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<int> style = GeneratedColumn<int>(
      'style', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _alignmentMeta =
      const VerificationMeta('alignment');
  @override
  late final GeneratedColumn<String> alignment = GeneratedColumn<String>(
      'alignment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _primaryColorMeta =
      const VerificationMeta('primaryColor');
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
      'primary_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backgroundColorMeta =
      const VerificationMeta('backgroundColor');
  @override
  late final GeneratedColumn<String> backgroundColor = GeneratedColumn<String>(
      'background_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _foregroundColorMeta =
      const VerificationMeta('foregroundColor');
  @override
  late final GeneratedColumn<String> foregroundColor = GeneratedColumn<String>(
      'foreground_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconColorMeta =
      const VerificationMeta('iconColor');
  @override
  late final GeneratedColumn<String> iconColor = GeneratedColumn<String>(
      'icon_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _borderRadiusMeta =
      const VerificationMeta('borderRadius');
  @override
  late final GeneratedColumn<String> borderRadius = GeneratedColumn<String>(
      'border_radius', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _shadowMeta = const VerificationMeta('shadow');
  @override
  late final GeneratedColumn<int> shadow = GeneratedColumn<int>(
      'shadow', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<int> direction = GeneratedColumn<int>(
      'direction', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _autoCloseDurationMeta =
      const VerificationMeta('autoCloseDuration');
  @override
  late final GeneratedColumn<int> autoCloseDuration = GeneratedColumn<int>(
      'auto_close_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _animationDurationMeta =
      const VerificationMeta('animationDuration');
  @override
  late final GeneratedColumn<int> animationDuration = GeneratedColumn<int>(
      'animation_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _animationTypeMeta =
      const VerificationMeta('animationType');
  @override
  late final GeneratedColumn<String> animationType = GeneratedColumn<String>(
      'animation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _closeButtonShowTypeMeta =
      const VerificationMeta('closeButtonShowType');
  @override
  late final GeneratedColumn<int> closeButtonShowType = GeneratedColumn<int>(
      'close_button_show_type', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _useContextMeta =
      const VerificationMeta('useContext');
  @override
  late final GeneratedColumn<bool> useContext = GeneratedColumn<bool>(
      'use_context', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("use_context" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showProgressBarMeta =
      const VerificationMeta('showProgressBar');
  @override
  late final GeneratedColumn<bool> showProgressBar = GeneratedColumn<bool>(
      'show_progress_bar', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_progress_bar" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _closeOnClickMeta =
      const VerificationMeta('closeOnClick');
  @override
  late final GeneratedColumn<bool> closeOnClick = GeneratedColumn<bool>(
      'close_on_click', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("close_on_click" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _pauseOnHoverMeta =
      const VerificationMeta('pauseOnHover');
  @override
  late final GeneratedColumn<bool> pauseOnHover = GeneratedColumn<bool>(
      'pause_on_hover', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pause_on_hover" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dragToCloseMeta =
      const VerificationMeta('dragToClose');
  @override
  late final GeneratedColumn<bool> dragToClose = GeneratedColumn<bool>(
      'drag_to_close', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("drag_to_close" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _applyBlurEffectMeta =
      const VerificationMeta('applyBlurEffect');
  @override
  late final GeneratedColumn<bool> applyBlurEffect = GeneratedColumn<bool>(
      'apply_blur_effect', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("apply_blur_effect" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _showIconMeta =
      const VerificationMeta('showIcon');
  @override
  late final GeneratedColumn<bool> showIcon = GeneratedColumn<bool>(
      'show_icon', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("show_icon" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        style,
        alignment,
        title,
        description,
        icon,
        primaryColor,
        backgroundColor,
        foregroundColor,
        iconColor,
        borderRadius,
        shadow,
        direction,
        autoCloseDuration,
        animationDuration,
        animationType,
        closeButtonShowType,
        useContext,
        showProgressBar,
        closeOnClick,
        pauseOnHover,
        dragToClose,
        applyBlurEffect,
        showIcon
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'toast_details_schema';
  @override
  VerificationContext validateIntegrity(
      Insertable<ToastDetailsSchemaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('style')) {
      context.handle(
          _styleMeta, style.isAcceptableOrUnknown(data['style']!, _styleMeta));
    } else if (isInserting) {
      context.missing(_styleMeta);
    }
    if (data.containsKey('alignment')) {
      context.handle(_alignmentMeta,
          alignment.isAcceptableOrUnknown(data['alignment']!, _alignmentMeta));
    } else if (isInserting) {
      context.missing(_alignmentMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('primary_color')) {
      context.handle(
          _primaryColorMeta,
          primaryColor.isAcceptableOrUnknown(
              data['primary_color']!, _primaryColorMeta));
    }
    if (data.containsKey('background_color')) {
      context.handle(
          _backgroundColorMeta,
          backgroundColor.isAcceptableOrUnknown(
              data['background_color']!, _backgroundColorMeta));
    }
    if (data.containsKey('foreground_color')) {
      context.handle(
          _foregroundColorMeta,
          foregroundColor.isAcceptableOrUnknown(
              data['foreground_color']!, _foregroundColorMeta));
    }
    if (data.containsKey('icon_color')) {
      context.handle(_iconColorMeta,
          iconColor.isAcceptableOrUnknown(data['icon_color']!, _iconColorMeta));
    }
    if (data.containsKey('border_radius')) {
      context.handle(
          _borderRadiusMeta,
          borderRadius.isAcceptableOrUnknown(
              data['border_radius']!, _borderRadiusMeta));
    }
    if (data.containsKey('shadow')) {
      context.handle(_shadowMeta,
          shadow.isAcceptableOrUnknown(data['shadow']!, _shadowMeta));
    } else if (isInserting) {
      context.missing(_shadowMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    }
    if (data.containsKey('auto_close_duration')) {
      context.handle(
          _autoCloseDurationMeta,
          autoCloseDuration.isAcceptableOrUnknown(
              data['auto_close_duration']!, _autoCloseDurationMeta));
    }
    if (data.containsKey('animation_duration')) {
      context.handle(
          _animationDurationMeta,
          animationDuration.isAcceptableOrUnknown(
              data['animation_duration']!, _animationDurationMeta));
    }
    if (data.containsKey('animation_type')) {
      context.handle(
          _animationTypeMeta,
          animationType.isAcceptableOrUnknown(
              data['animation_type']!, _animationTypeMeta));
    } else if (isInserting) {
      context.missing(_animationTypeMeta);
    }
    if (data.containsKey('close_button_show_type')) {
      context.handle(
          _closeButtonShowTypeMeta,
          closeButtonShowType.isAcceptableOrUnknown(
              data['close_button_show_type']!, _closeButtonShowTypeMeta));
    }
    if (data.containsKey('use_context')) {
      context.handle(
          _useContextMeta,
          useContext.isAcceptableOrUnknown(
              data['use_context']!, _useContextMeta));
    }
    if (data.containsKey('show_progress_bar')) {
      context.handle(
          _showProgressBarMeta,
          showProgressBar.isAcceptableOrUnknown(
              data['show_progress_bar']!, _showProgressBarMeta));
    }
    if (data.containsKey('close_on_click')) {
      context.handle(
          _closeOnClickMeta,
          closeOnClick.isAcceptableOrUnknown(
              data['close_on_click']!, _closeOnClickMeta));
    }
    if (data.containsKey('pause_on_hover')) {
      context.handle(
          _pauseOnHoverMeta,
          pauseOnHover.isAcceptableOrUnknown(
              data['pause_on_hover']!, _pauseOnHoverMeta));
    }
    if (data.containsKey('drag_to_close')) {
      context.handle(
          _dragToCloseMeta,
          dragToClose.isAcceptableOrUnknown(
              data['drag_to_close']!, _dragToCloseMeta));
    }
    if (data.containsKey('apply_blur_effect')) {
      context.handle(
          _applyBlurEffectMeta,
          applyBlurEffect.isAcceptableOrUnknown(
              data['apply_blur_effect']!, _applyBlurEffectMeta));
    }
    if (data.containsKey('show_icon')) {
      context.handle(_showIconMeta,
          showIcon.isAcceptableOrUnknown(data['show_icon']!, _showIconMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ToastDetailsSchemaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ToastDetailsSchemaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      style: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}style'])!,
      alignment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alignment'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      primaryColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_color']),
      backgroundColor: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}background_color']),
      foregroundColor: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}foreground_color']),
      iconColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_color']),
      borderRadius: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}border_radius']),
      shadow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shadow'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}direction']),
      autoCloseDuration: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}auto_close_duration']),
      animationDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}animation_duration']),
      animationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animation_type'])!,
      closeButtonShowType: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}close_button_show_type']),
      useContext: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_context'])!,
      showProgressBar: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_progress_bar'])!,
      closeOnClick: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}close_on_click'])!,
      pauseOnHover: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pause_on_hover'])!,
      dragToClose: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}drag_to_close'])!,
      applyBlurEffect: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}apply_blur_effect'])!,
      showIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_icon'])!,
    );
  }

  @override
  $ToastDetailsSchemaTable createAlias(String alias) {
    return $ToastDetailsSchemaTable(attachedDatabase, alias);
  }
}

class ToastDetailsSchemaData extends DataClass
    implements Insertable<ToastDetailsSchemaData> {
  final int id;
  final int type;
  final int style;
  final String alignment;
  final String? title;
  final String? description;
  final String? icon;
  final String? primaryColor;
  final String? backgroundColor;
  final String? foregroundColor;
  final String? iconColor;
  final String? borderRadius;
  final int shadow;
  final int? direction;
  final int? autoCloseDuration;
  final int? animationDuration;
  final String animationType;
  final int? closeButtonShowType;
  final bool useContext;
  final bool showProgressBar;
  final bool closeOnClick;
  final bool pauseOnHover;
  final bool dragToClose;
  final bool applyBlurEffect;
  final bool showIcon;
  const ToastDetailsSchemaData(
      {required this.id,
      required this.type,
      required this.style,
      required this.alignment,
      this.title,
      this.description,
      this.icon,
      this.primaryColor,
      this.backgroundColor,
      this.foregroundColor,
      this.iconColor,
      this.borderRadius,
      required this.shadow,
      this.direction,
      this.autoCloseDuration,
      this.animationDuration,
      required this.animationType,
      this.closeButtonShowType,
      required this.useContext,
      required this.showProgressBar,
      required this.closeOnClick,
      required this.pauseOnHover,
      required this.dragToClose,
      required this.applyBlurEffect,
      required this.showIcon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<int>(type);
    map['style'] = Variable<int>(style);
    map['alignment'] = Variable<String>(alignment);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || primaryColor != null) {
      map['primary_color'] = Variable<String>(primaryColor);
    }
    if (!nullToAbsent || backgroundColor != null) {
      map['background_color'] = Variable<String>(backgroundColor);
    }
    if (!nullToAbsent || foregroundColor != null) {
      map['foreground_color'] = Variable<String>(foregroundColor);
    }
    if (!nullToAbsent || iconColor != null) {
      map['icon_color'] = Variable<String>(iconColor);
    }
    if (!nullToAbsent || borderRadius != null) {
      map['border_radius'] = Variable<String>(borderRadius);
    }
    map['shadow'] = Variable<int>(shadow);
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<int>(direction);
    }
    if (!nullToAbsent || autoCloseDuration != null) {
      map['auto_close_duration'] = Variable<int>(autoCloseDuration);
    }
    if (!nullToAbsent || animationDuration != null) {
      map['animation_duration'] = Variable<int>(animationDuration);
    }
    map['animation_type'] = Variable<String>(animationType);
    if (!nullToAbsent || closeButtonShowType != null) {
      map['close_button_show_type'] = Variable<int>(closeButtonShowType);
    }
    map['use_context'] = Variable<bool>(useContext);
    map['show_progress_bar'] = Variable<bool>(showProgressBar);
    map['close_on_click'] = Variable<bool>(closeOnClick);
    map['pause_on_hover'] = Variable<bool>(pauseOnHover);
    map['drag_to_close'] = Variable<bool>(dragToClose);
    map['apply_blur_effect'] = Variable<bool>(applyBlurEffect);
    map['show_icon'] = Variable<bool>(showIcon);
    return map;
  }

  ToastDetailsSchemaCompanion toCompanion(bool nullToAbsent) {
    return ToastDetailsSchemaCompanion(
      id: Value(id),
      type: Value(type),
      style: Value(style),
      alignment: Value(alignment),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      primaryColor: primaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryColor),
      backgroundColor: backgroundColor == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundColor),
      foregroundColor: foregroundColor == null && nullToAbsent
          ? const Value.absent()
          : Value(foregroundColor),
      iconColor: iconColor == null && nullToAbsent
          ? const Value.absent()
          : Value(iconColor),
      borderRadius: borderRadius == null && nullToAbsent
          ? const Value.absent()
          : Value(borderRadius),
      shadow: Value(shadow),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      autoCloseDuration: autoCloseDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(autoCloseDuration),
      animationDuration: animationDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(animationDuration),
      animationType: Value(animationType),
      closeButtonShowType: closeButtonShowType == null && nullToAbsent
          ? const Value.absent()
          : Value(closeButtonShowType),
      useContext: Value(useContext),
      showProgressBar: Value(showProgressBar),
      closeOnClick: Value(closeOnClick),
      pauseOnHover: Value(pauseOnHover),
      dragToClose: Value(dragToClose),
      applyBlurEffect: Value(applyBlurEffect),
      showIcon: Value(showIcon),
    );
  }

  factory ToastDetailsSchemaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToastDetailsSchemaData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      style: serializer.fromJson<int>(json['style']),
      alignment: serializer.fromJson<String>(json['alignment']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      primaryColor: serializer.fromJson<String?>(json['primaryColor']),
      backgroundColor: serializer.fromJson<String?>(json['backgroundColor']),
      foregroundColor: serializer.fromJson<String?>(json['foregroundColor']),
      iconColor: serializer.fromJson<String?>(json['iconColor']),
      borderRadius: serializer.fromJson<String?>(json['borderRadius']),
      shadow: serializer.fromJson<int>(json['shadow']),
      direction: serializer.fromJson<int?>(json['direction']),
      autoCloseDuration: serializer.fromJson<int?>(json['autoCloseDuration']),
      animationDuration: serializer.fromJson<int?>(json['animationDuration']),
      animationType: serializer.fromJson<String>(json['animationType']),
      closeButtonShowType:
          serializer.fromJson<int?>(json['closeButtonShowType']),
      useContext: serializer.fromJson<bool>(json['useContext']),
      showProgressBar: serializer.fromJson<bool>(json['showProgressBar']),
      closeOnClick: serializer.fromJson<bool>(json['closeOnClick']),
      pauseOnHover: serializer.fromJson<bool>(json['pauseOnHover']),
      dragToClose: serializer.fromJson<bool>(json['dragToClose']),
      applyBlurEffect: serializer.fromJson<bool>(json['applyBlurEffect']),
      showIcon: serializer.fromJson<bool>(json['showIcon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(type),
      'style': serializer.toJson<int>(style),
      'alignment': serializer.toJson<String>(alignment),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String?>(icon),
      'primaryColor': serializer.toJson<String?>(primaryColor),
      'backgroundColor': serializer.toJson<String?>(backgroundColor),
      'foregroundColor': serializer.toJson<String?>(foregroundColor),
      'iconColor': serializer.toJson<String?>(iconColor),
      'borderRadius': serializer.toJson<String?>(borderRadius),
      'shadow': serializer.toJson<int>(shadow),
      'direction': serializer.toJson<int?>(direction),
      'autoCloseDuration': serializer.toJson<int?>(autoCloseDuration),
      'animationDuration': serializer.toJson<int?>(animationDuration),
      'animationType': serializer.toJson<String>(animationType),
      'closeButtonShowType': serializer.toJson<int?>(closeButtonShowType),
      'useContext': serializer.toJson<bool>(useContext),
      'showProgressBar': serializer.toJson<bool>(showProgressBar),
      'closeOnClick': serializer.toJson<bool>(closeOnClick),
      'pauseOnHover': serializer.toJson<bool>(pauseOnHover),
      'dragToClose': serializer.toJson<bool>(dragToClose),
      'applyBlurEffect': serializer.toJson<bool>(applyBlurEffect),
      'showIcon': serializer.toJson<bool>(showIcon),
    };
  }

  ToastDetailsSchemaData copyWith(
          {int? id,
          int? type,
          int? style,
          String? alignment,
          Value<String?> title = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> icon = const Value.absent(),
          Value<String?> primaryColor = const Value.absent(),
          Value<String?> backgroundColor = const Value.absent(),
          Value<String?> foregroundColor = const Value.absent(),
          Value<String?> iconColor = const Value.absent(),
          Value<String?> borderRadius = const Value.absent(),
          int? shadow,
          Value<int?> direction = const Value.absent(),
          Value<int?> autoCloseDuration = const Value.absent(),
          Value<int?> animationDuration = const Value.absent(),
          String? animationType,
          Value<int?> closeButtonShowType = const Value.absent(),
          bool? useContext,
          bool? showProgressBar,
          bool? closeOnClick,
          bool? pauseOnHover,
          bool? dragToClose,
          bool? applyBlurEffect,
          bool? showIcon}) =>
      ToastDetailsSchemaData(
        id: id ?? this.id,
        type: type ?? this.type,
        style: style ?? this.style,
        alignment: alignment ?? this.alignment,
        title: title.present ? title.value : this.title,
        description: description.present ? description.value : this.description,
        icon: icon.present ? icon.value : this.icon,
        primaryColor:
            primaryColor.present ? primaryColor.value : this.primaryColor,
        backgroundColor: backgroundColor.present
            ? backgroundColor.value
            : this.backgroundColor,
        foregroundColor: foregroundColor.present
            ? foregroundColor.value
            : this.foregroundColor,
        iconColor: iconColor.present ? iconColor.value : this.iconColor,
        borderRadius:
            borderRadius.present ? borderRadius.value : this.borderRadius,
        shadow: shadow ?? this.shadow,
        direction: direction.present ? direction.value : this.direction,
        autoCloseDuration: autoCloseDuration.present
            ? autoCloseDuration.value
            : this.autoCloseDuration,
        animationDuration: animationDuration.present
            ? animationDuration.value
            : this.animationDuration,
        animationType: animationType ?? this.animationType,
        closeButtonShowType: closeButtonShowType.present
            ? closeButtonShowType.value
            : this.closeButtonShowType,
        useContext: useContext ?? this.useContext,
        showProgressBar: showProgressBar ?? this.showProgressBar,
        closeOnClick: closeOnClick ?? this.closeOnClick,
        pauseOnHover: pauseOnHover ?? this.pauseOnHover,
        dragToClose: dragToClose ?? this.dragToClose,
        applyBlurEffect: applyBlurEffect ?? this.applyBlurEffect,
        showIcon: showIcon ?? this.showIcon,
      );
  ToastDetailsSchemaData copyWithCompanion(ToastDetailsSchemaCompanion data) {
    return ToastDetailsSchemaData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      style: data.style.present ? data.style.value : this.style,
      alignment: data.alignment.present ? data.alignment.value : this.alignment,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      backgroundColor: data.backgroundColor.present
          ? data.backgroundColor.value
          : this.backgroundColor,
      foregroundColor: data.foregroundColor.present
          ? data.foregroundColor.value
          : this.foregroundColor,
      iconColor: data.iconColor.present ? data.iconColor.value : this.iconColor,
      borderRadius: data.borderRadius.present
          ? data.borderRadius.value
          : this.borderRadius,
      shadow: data.shadow.present ? data.shadow.value : this.shadow,
      direction: data.direction.present ? data.direction.value : this.direction,
      autoCloseDuration: data.autoCloseDuration.present
          ? data.autoCloseDuration.value
          : this.autoCloseDuration,
      animationDuration: data.animationDuration.present
          ? data.animationDuration.value
          : this.animationDuration,
      animationType: data.animationType.present
          ? data.animationType.value
          : this.animationType,
      closeButtonShowType: data.closeButtonShowType.present
          ? data.closeButtonShowType.value
          : this.closeButtonShowType,
      useContext:
          data.useContext.present ? data.useContext.value : this.useContext,
      showProgressBar: data.showProgressBar.present
          ? data.showProgressBar.value
          : this.showProgressBar,
      closeOnClick: data.closeOnClick.present
          ? data.closeOnClick.value
          : this.closeOnClick,
      pauseOnHover: data.pauseOnHover.present
          ? data.pauseOnHover.value
          : this.pauseOnHover,
      dragToClose:
          data.dragToClose.present ? data.dragToClose.value : this.dragToClose,
      applyBlurEffect: data.applyBlurEffect.present
          ? data.applyBlurEffect.value
          : this.applyBlurEffect,
      showIcon: data.showIcon.present ? data.showIcon.value : this.showIcon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ToastDetailsSchemaData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('style: $style, ')
          ..write('alignment: $alignment, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('foregroundColor: $foregroundColor, ')
          ..write('iconColor: $iconColor, ')
          ..write('borderRadius: $borderRadius, ')
          ..write('shadow: $shadow, ')
          ..write('direction: $direction, ')
          ..write('autoCloseDuration: $autoCloseDuration, ')
          ..write('animationDuration: $animationDuration, ')
          ..write('animationType: $animationType, ')
          ..write('closeButtonShowType: $closeButtonShowType, ')
          ..write('useContext: $useContext, ')
          ..write('showProgressBar: $showProgressBar, ')
          ..write('closeOnClick: $closeOnClick, ')
          ..write('pauseOnHover: $pauseOnHover, ')
          ..write('dragToClose: $dragToClose, ')
          ..write('applyBlurEffect: $applyBlurEffect, ')
          ..write('showIcon: $showIcon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        type,
        style,
        alignment,
        title,
        description,
        icon,
        primaryColor,
        backgroundColor,
        foregroundColor,
        iconColor,
        borderRadius,
        shadow,
        direction,
        autoCloseDuration,
        animationDuration,
        animationType,
        closeButtonShowType,
        useContext,
        showProgressBar,
        closeOnClick,
        pauseOnHover,
        dragToClose,
        applyBlurEffect,
        showIcon
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToastDetailsSchemaData &&
          other.id == this.id &&
          other.type == this.type &&
          other.style == this.style &&
          other.alignment == this.alignment &&
          other.title == this.title &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.primaryColor == this.primaryColor &&
          other.backgroundColor == this.backgroundColor &&
          other.foregroundColor == this.foregroundColor &&
          other.iconColor == this.iconColor &&
          other.borderRadius == this.borderRadius &&
          other.shadow == this.shadow &&
          other.direction == this.direction &&
          other.autoCloseDuration == this.autoCloseDuration &&
          other.animationDuration == this.animationDuration &&
          other.animationType == this.animationType &&
          other.closeButtonShowType == this.closeButtonShowType &&
          other.useContext == this.useContext &&
          other.showProgressBar == this.showProgressBar &&
          other.closeOnClick == this.closeOnClick &&
          other.pauseOnHover == this.pauseOnHover &&
          other.dragToClose == this.dragToClose &&
          other.applyBlurEffect == this.applyBlurEffect &&
          other.showIcon == this.showIcon);
}

class ToastDetailsSchemaCompanion
    extends UpdateCompanion<ToastDetailsSchemaData> {
  final Value<int> id;
  final Value<int> type;
  final Value<int> style;
  final Value<String> alignment;
  final Value<String?> title;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<String?> primaryColor;
  final Value<String?> backgroundColor;
  final Value<String?> foregroundColor;
  final Value<String?> iconColor;
  final Value<String?> borderRadius;
  final Value<int> shadow;
  final Value<int?> direction;
  final Value<int?> autoCloseDuration;
  final Value<int?> animationDuration;
  final Value<String> animationType;
  final Value<int?> closeButtonShowType;
  final Value<bool> useContext;
  final Value<bool> showProgressBar;
  final Value<bool> closeOnClick;
  final Value<bool> pauseOnHover;
  final Value<bool> dragToClose;
  final Value<bool> applyBlurEffect;
  final Value<bool> showIcon;
  const ToastDetailsSchemaCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.style = const Value.absent(),
    this.alignment = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.foregroundColor = const Value.absent(),
    this.iconColor = const Value.absent(),
    this.borderRadius = const Value.absent(),
    this.shadow = const Value.absent(),
    this.direction = const Value.absent(),
    this.autoCloseDuration = const Value.absent(),
    this.animationDuration = const Value.absent(),
    this.animationType = const Value.absent(),
    this.closeButtonShowType = const Value.absent(),
    this.useContext = const Value.absent(),
    this.showProgressBar = const Value.absent(),
    this.closeOnClick = const Value.absent(),
    this.pauseOnHover = const Value.absent(),
    this.dragToClose = const Value.absent(),
    this.applyBlurEffect = const Value.absent(),
    this.showIcon = const Value.absent(),
  });
  ToastDetailsSchemaCompanion.insert({
    this.id = const Value.absent(),
    required int type,
    required int style,
    required String alignment,
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.foregroundColor = const Value.absent(),
    this.iconColor = const Value.absent(),
    this.borderRadius = const Value.absent(),
    required int shadow,
    this.direction = const Value.absent(),
    this.autoCloseDuration = const Value.absent(),
    this.animationDuration = const Value.absent(),
    required String animationType,
    this.closeButtonShowType = const Value.absent(),
    this.useContext = const Value.absent(),
    this.showProgressBar = const Value.absent(),
    this.closeOnClick = const Value.absent(),
    this.pauseOnHover = const Value.absent(),
    this.dragToClose = const Value.absent(),
    this.applyBlurEffect = const Value.absent(),
    this.showIcon = const Value.absent(),
  })  : type = Value(type),
        style = Value(style),
        alignment = Value(alignment),
        shadow = Value(shadow),
        animationType = Value(animationType);
  static Insertable<ToastDetailsSchemaData> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<int>? style,
    Expression<String>? alignment,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? primaryColor,
    Expression<String>? backgroundColor,
    Expression<String>? foregroundColor,
    Expression<String>? iconColor,
    Expression<String>? borderRadius,
    Expression<int>? shadow,
    Expression<int>? direction,
    Expression<int>? autoCloseDuration,
    Expression<int>? animationDuration,
    Expression<String>? animationType,
    Expression<int>? closeButtonShowType,
    Expression<bool>? useContext,
    Expression<bool>? showProgressBar,
    Expression<bool>? closeOnClick,
    Expression<bool>? pauseOnHover,
    Expression<bool>? dragToClose,
    Expression<bool>? applyBlurEffect,
    Expression<bool>? showIcon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (style != null) 'style': style,
      if (alignment != null) 'alignment': alignment,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (backgroundColor != null) 'background_color': backgroundColor,
      if (foregroundColor != null) 'foreground_color': foregroundColor,
      if (iconColor != null) 'icon_color': iconColor,
      if (borderRadius != null) 'border_radius': borderRadius,
      if (shadow != null) 'shadow': shadow,
      if (direction != null) 'direction': direction,
      if (autoCloseDuration != null) 'auto_close_duration': autoCloseDuration,
      if (animationDuration != null) 'animation_duration': animationDuration,
      if (animationType != null) 'animation_type': animationType,
      if (closeButtonShowType != null)
        'close_button_show_type': closeButtonShowType,
      if (useContext != null) 'use_context': useContext,
      if (showProgressBar != null) 'show_progress_bar': showProgressBar,
      if (closeOnClick != null) 'close_on_click': closeOnClick,
      if (pauseOnHover != null) 'pause_on_hover': pauseOnHover,
      if (dragToClose != null) 'drag_to_close': dragToClose,
      if (applyBlurEffect != null) 'apply_blur_effect': applyBlurEffect,
      if (showIcon != null) 'show_icon': showIcon,
    });
  }

  ToastDetailsSchemaCompanion copyWith(
      {Value<int>? id,
      Value<int>? type,
      Value<int>? style,
      Value<String>? alignment,
      Value<String?>? title,
      Value<String?>? description,
      Value<String?>? icon,
      Value<String?>? primaryColor,
      Value<String?>? backgroundColor,
      Value<String?>? foregroundColor,
      Value<String?>? iconColor,
      Value<String?>? borderRadius,
      Value<int>? shadow,
      Value<int?>? direction,
      Value<int?>? autoCloseDuration,
      Value<int?>? animationDuration,
      Value<String>? animationType,
      Value<int?>? closeButtonShowType,
      Value<bool>? useContext,
      Value<bool>? showProgressBar,
      Value<bool>? closeOnClick,
      Value<bool>? pauseOnHover,
      Value<bool>? dragToClose,
      Value<bool>? applyBlurEffect,
      Value<bool>? showIcon}) {
    return ToastDetailsSchemaCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      style: style ?? this.style,
      alignment: alignment ?? this.alignment,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      iconColor: iconColor ?? this.iconColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shadow: shadow ?? this.shadow,
      direction: direction ?? this.direction,
      autoCloseDuration: autoCloseDuration ?? this.autoCloseDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      animationType: animationType ?? this.animationType,
      closeButtonShowType: closeButtonShowType ?? this.closeButtonShowType,
      useContext: useContext ?? this.useContext,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      closeOnClick: closeOnClick ?? this.closeOnClick,
      pauseOnHover: pauseOnHover ?? this.pauseOnHover,
      dragToClose: dragToClose ?? this.dragToClose,
      applyBlurEffect: applyBlurEffect ?? this.applyBlurEffect,
      showIcon: showIcon ?? this.showIcon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (style.present) {
      map['style'] = Variable<int>(style.value);
    }
    if (alignment.present) {
      map['alignment'] = Variable<String>(alignment.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (backgroundColor.present) {
      map['background_color'] = Variable<String>(backgroundColor.value);
    }
    if (foregroundColor.present) {
      map['foreground_color'] = Variable<String>(foregroundColor.value);
    }
    if (iconColor.present) {
      map['icon_color'] = Variable<String>(iconColor.value);
    }
    if (borderRadius.present) {
      map['border_radius'] = Variable<String>(borderRadius.value);
    }
    if (shadow.present) {
      map['shadow'] = Variable<int>(shadow.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(direction.value);
    }
    if (autoCloseDuration.present) {
      map['auto_close_duration'] = Variable<int>(autoCloseDuration.value);
    }
    if (animationDuration.present) {
      map['animation_duration'] = Variable<int>(animationDuration.value);
    }
    if (animationType.present) {
      map['animation_type'] = Variable<String>(animationType.value);
    }
    if (closeButtonShowType.present) {
      map['close_button_show_type'] = Variable<int>(closeButtonShowType.value);
    }
    if (useContext.present) {
      map['use_context'] = Variable<bool>(useContext.value);
    }
    if (showProgressBar.present) {
      map['show_progress_bar'] = Variable<bool>(showProgressBar.value);
    }
    if (closeOnClick.present) {
      map['close_on_click'] = Variable<bool>(closeOnClick.value);
    }
    if (pauseOnHover.present) {
      map['pause_on_hover'] = Variable<bool>(pauseOnHover.value);
    }
    if (dragToClose.present) {
      map['drag_to_close'] = Variable<bool>(dragToClose.value);
    }
    if (applyBlurEffect.present) {
      map['apply_blur_effect'] = Variable<bool>(applyBlurEffect.value);
    }
    if (showIcon.present) {
      map['show_icon'] = Variable<bool>(showIcon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToastDetailsSchemaCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('style: $style, ')
          ..write('alignment: $alignment, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('foregroundColor: $foregroundColor, ')
          ..write('iconColor: $iconColor, ')
          ..write('borderRadius: $borderRadius, ')
          ..write('shadow: $shadow, ')
          ..write('direction: $direction, ')
          ..write('autoCloseDuration: $autoCloseDuration, ')
          ..write('animationDuration: $animationDuration, ')
          ..write('animationType: $animationType, ')
          ..write('closeButtonShowType: $closeButtonShowType, ')
          ..write('useContext: $useContext, ')
          ..write('showProgressBar: $showProgressBar, ')
          ..write('closeOnClick: $closeOnClick, ')
          ..write('pauseOnHover: $pauseOnHover, ')
          ..write('dragToClose: $dragToClose, ')
          ..write('applyBlurEffect: $applyBlurEffect, ')
          ..write('showIcon: $showIcon')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ToastDetailsSchemaTable toastDetailsSchema =
      $ToastDetailsSchemaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [toastDetailsSchema];
}

typedef $$ToastDetailsSchemaTableCreateCompanionBuilder
    = ToastDetailsSchemaCompanion Function({
  Value<int> id,
  required int type,
  required int style,
  required String alignment,
  Value<String?> title,
  Value<String?> description,
  Value<String?> icon,
  Value<String?> primaryColor,
  Value<String?> backgroundColor,
  Value<String?> foregroundColor,
  Value<String?> iconColor,
  Value<String?> borderRadius,
  required int shadow,
  Value<int?> direction,
  Value<int?> autoCloseDuration,
  Value<int?> animationDuration,
  required String animationType,
  Value<int?> closeButtonShowType,
  Value<bool> useContext,
  Value<bool> showProgressBar,
  Value<bool> closeOnClick,
  Value<bool> pauseOnHover,
  Value<bool> dragToClose,
  Value<bool> applyBlurEffect,
  Value<bool> showIcon,
});
typedef $$ToastDetailsSchemaTableUpdateCompanionBuilder
    = ToastDetailsSchemaCompanion Function({
  Value<int> id,
  Value<int> type,
  Value<int> style,
  Value<String> alignment,
  Value<String?> title,
  Value<String?> description,
  Value<String?> icon,
  Value<String?> primaryColor,
  Value<String?> backgroundColor,
  Value<String?> foregroundColor,
  Value<String?> iconColor,
  Value<String?> borderRadius,
  Value<int> shadow,
  Value<int?> direction,
  Value<int?> autoCloseDuration,
  Value<int?> animationDuration,
  Value<String> animationType,
  Value<int?> closeButtonShowType,
  Value<bool> useContext,
  Value<bool> showProgressBar,
  Value<bool> closeOnClick,
  Value<bool> pauseOnHover,
  Value<bool> dragToClose,
  Value<bool> applyBlurEffect,
  Value<bool> showIcon,
});

class $$ToastDetailsSchemaTableFilterComposer
    extends Composer<_$AppDatabase, $ToastDetailsSchemaTable> {
  $$ToastDetailsSchemaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get style => $composableBuilder(
      column: $table.style, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alignment => $composableBuilder(
      column: $table.alignment, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backgroundColor => $composableBuilder(
      column: $table.backgroundColor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foregroundColor => $composableBuilder(
      column: $table.foregroundColor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconColor => $composableBuilder(
      column: $table.iconColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get borderRadius => $composableBuilder(
      column: $table.borderRadius, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shadow => $composableBuilder(
      column: $table.shadow, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get autoCloseDuration => $composableBuilder(
      column: $table.autoCloseDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get animationDuration => $composableBuilder(
      column: $table.animationDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get animationType => $composableBuilder(
      column: $table.animationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get closeButtonShowType => $composableBuilder(
      column: $table.closeButtonShowType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useContext => $composableBuilder(
      column: $table.useContext, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showProgressBar => $composableBuilder(
      column: $table.showProgressBar,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get closeOnClick => $composableBuilder(
      column: $table.closeOnClick, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pauseOnHover => $composableBuilder(
      column: $table.pauseOnHover, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get dragToClose => $composableBuilder(
      column: $table.dragToClose, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get applyBlurEffect => $composableBuilder(
      column: $table.applyBlurEffect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showIcon => $composableBuilder(
      column: $table.showIcon, builder: (column) => ColumnFilters(column));
}

class $$ToastDetailsSchemaTableOrderingComposer
    extends Composer<_$AppDatabase, $ToastDetailsSchemaTable> {
  $$ToastDetailsSchemaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get style => $composableBuilder(
      column: $table.style, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alignment => $composableBuilder(
      column: $table.alignment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backgroundColor => $composableBuilder(
      column: $table.backgroundColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foregroundColor => $composableBuilder(
      column: $table.foregroundColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconColor => $composableBuilder(
      column: $table.iconColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get borderRadius => $composableBuilder(
      column: $table.borderRadius,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shadow => $composableBuilder(
      column: $table.shadow, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get autoCloseDuration => $composableBuilder(
      column: $table.autoCloseDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get animationDuration => $composableBuilder(
      column: $table.animationDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get animationType => $composableBuilder(
      column: $table.animationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get closeButtonShowType => $composableBuilder(
      column: $table.closeButtonShowType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useContext => $composableBuilder(
      column: $table.useContext, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showProgressBar => $composableBuilder(
      column: $table.showProgressBar,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get closeOnClick => $composableBuilder(
      column: $table.closeOnClick,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pauseOnHover => $composableBuilder(
      column: $table.pauseOnHover,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get dragToClose => $composableBuilder(
      column: $table.dragToClose, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get applyBlurEffect => $composableBuilder(
      column: $table.applyBlurEffect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showIcon => $composableBuilder(
      column: $table.showIcon, builder: (column) => ColumnOrderings(column));
}

class $$ToastDetailsSchemaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ToastDetailsSchemaTable> {
  $$ToastDetailsSchemaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get alignment =>
      $composableBuilder(column: $table.alignment, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get primaryColor => $composableBuilder(
      column: $table.primaryColor, builder: (column) => column);

  GeneratedColumn<String> get backgroundColor => $composableBuilder(
      column: $table.backgroundColor, builder: (column) => column);

  GeneratedColumn<String> get foregroundColor => $composableBuilder(
      column: $table.foregroundColor, builder: (column) => column);

  GeneratedColumn<String> get iconColor =>
      $composableBuilder(column: $table.iconColor, builder: (column) => column);

  GeneratedColumn<String> get borderRadius => $composableBuilder(
      column: $table.borderRadius, builder: (column) => column);

  GeneratedColumn<int> get shadow =>
      $composableBuilder(column: $table.shadow, builder: (column) => column);

  GeneratedColumn<int> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get autoCloseDuration => $composableBuilder(
      column: $table.autoCloseDuration, builder: (column) => column);

  GeneratedColumn<int> get animationDuration => $composableBuilder(
      column: $table.animationDuration, builder: (column) => column);

  GeneratedColumn<String> get animationType => $composableBuilder(
      column: $table.animationType, builder: (column) => column);

  GeneratedColumn<int> get closeButtonShowType => $composableBuilder(
      column: $table.closeButtonShowType, builder: (column) => column);

  GeneratedColumn<bool> get useContext => $composableBuilder(
      column: $table.useContext, builder: (column) => column);

  GeneratedColumn<bool> get showProgressBar => $composableBuilder(
      column: $table.showProgressBar, builder: (column) => column);

  GeneratedColumn<bool> get closeOnClick => $composableBuilder(
      column: $table.closeOnClick, builder: (column) => column);

  GeneratedColumn<bool> get pauseOnHover => $composableBuilder(
      column: $table.pauseOnHover, builder: (column) => column);

  GeneratedColumn<bool> get dragToClose => $composableBuilder(
      column: $table.dragToClose, builder: (column) => column);

  GeneratedColumn<bool> get applyBlurEffect => $composableBuilder(
      column: $table.applyBlurEffect, builder: (column) => column);

  GeneratedColumn<bool> get showIcon =>
      $composableBuilder(column: $table.showIcon, builder: (column) => column);
}

class $$ToastDetailsSchemaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ToastDetailsSchemaTable,
    ToastDetailsSchemaData,
    $$ToastDetailsSchemaTableFilterComposer,
    $$ToastDetailsSchemaTableOrderingComposer,
    $$ToastDetailsSchemaTableAnnotationComposer,
    $$ToastDetailsSchemaTableCreateCompanionBuilder,
    $$ToastDetailsSchemaTableUpdateCompanionBuilder,
    (
      ToastDetailsSchemaData,
      BaseReferences<_$AppDatabase, $ToastDetailsSchemaTable,
          ToastDetailsSchemaData>
    ),
    ToastDetailsSchemaData,
    PrefetchHooks Function()> {
  $$ToastDetailsSchemaTableTableManager(
      _$AppDatabase db, $ToastDetailsSchemaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToastDetailsSchemaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToastDetailsSchemaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToastDetailsSchemaTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<int> style = const Value.absent(),
            Value<String> alignment = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> primaryColor = const Value.absent(),
            Value<String?> backgroundColor = const Value.absent(),
            Value<String?> foregroundColor = const Value.absent(),
            Value<String?> iconColor = const Value.absent(),
            Value<String?> borderRadius = const Value.absent(),
            Value<int> shadow = const Value.absent(),
            Value<int?> direction = const Value.absent(),
            Value<int?> autoCloseDuration = const Value.absent(),
            Value<int?> animationDuration = const Value.absent(),
            Value<String> animationType = const Value.absent(),
            Value<int?> closeButtonShowType = const Value.absent(),
            Value<bool> useContext = const Value.absent(),
            Value<bool> showProgressBar = const Value.absent(),
            Value<bool> closeOnClick = const Value.absent(),
            Value<bool> pauseOnHover = const Value.absent(),
            Value<bool> dragToClose = const Value.absent(),
            Value<bool> applyBlurEffect = const Value.absent(),
            Value<bool> showIcon = const Value.absent(),
          }) =>
              ToastDetailsSchemaCompanion(
            id: id,
            type: type,
            style: style,
            alignment: alignment,
            title: title,
            description: description,
            icon: icon,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            iconColor: iconColor,
            borderRadius: borderRadius,
            shadow: shadow,
            direction: direction,
            autoCloseDuration: autoCloseDuration,
            animationDuration: animationDuration,
            animationType: animationType,
            closeButtonShowType: closeButtonShowType,
            useContext: useContext,
            showProgressBar: showProgressBar,
            closeOnClick: closeOnClick,
            pauseOnHover: pauseOnHover,
            dragToClose: dragToClose,
            applyBlurEffect: applyBlurEffect,
            showIcon: showIcon,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int type,
            required int style,
            required String alignment,
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> primaryColor = const Value.absent(),
            Value<String?> backgroundColor = const Value.absent(),
            Value<String?> foregroundColor = const Value.absent(),
            Value<String?> iconColor = const Value.absent(),
            Value<String?> borderRadius = const Value.absent(),
            required int shadow,
            Value<int?> direction = const Value.absent(),
            Value<int?> autoCloseDuration = const Value.absent(),
            Value<int?> animationDuration = const Value.absent(),
            required String animationType,
            Value<int?> closeButtonShowType = const Value.absent(),
            Value<bool> useContext = const Value.absent(),
            Value<bool> showProgressBar = const Value.absent(),
            Value<bool> closeOnClick = const Value.absent(),
            Value<bool> pauseOnHover = const Value.absent(),
            Value<bool> dragToClose = const Value.absent(),
            Value<bool> applyBlurEffect = const Value.absent(),
            Value<bool> showIcon = const Value.absent(),
          }) =>
              ToastDetailsSchemaCompanion.insert(
            id: id,
            type: type,
            style: style,
            alignment: alignment,
            title: title,
            description: description,
            icon: icon,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            iconColor: iconColor,
            borderRadius: borderRadius,
            shadow: shadow,
            direction: direction,
            autoCloseDuration: autoCloseDuration,
            animationDuration: animationDuration,
            animationType: animationType,
            closeButtonShowType: closeButtonShowType,
            useContext: useContext,
            showProgressBar: showProgressBar,
            closeOnClick: closeOnClick,
            pauseOnHover: pauseOnHover,
            dragToClose: dragToClose,
            applyBlurEffect: applyBlurEffect,
            showIcon: showIcon,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ToastDetailsSchemaTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ToastDetailsSchemaTable,
    ToastDetailsSchemaData,
    $$ToastDetailsSchemaTableFilterComposer,
    $$ToastDetailsSchemaTableOrderingComposer,
    $$ToastDetailsSchemaTableAnnotationComposer,
    $$ToastDetailsSchemaTableCreateCompanionBuilder,
    $$ToastDetailsSchemaTableUpdateCompanionBuilder,
    (
      ToastDetailsSchemaData,
      BaseReferences<_$AppDatabase, $ToastDetailsSchemaTable,
          ToastDetailsSchemaData>
    ),
    ToastDetailsSchemaData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ToastDetailsSchemaTableTableManager get toastDetailsSchema =>
      $$ToastDetailsSchemaTableTableManager(_db, _db.toastDetailsSchema);
}
