// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
  Map<String, dynamic> get uiConfig => throw _privateConstructorUsedError;
  @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
  Map<String, dynamic> get systemPreferences =>
      throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
    UserSettings value,
    $Res Function(UserSettings) then,
  ) = _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
    Map<String, dynamic> uiConfig,
    @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
    Map<String, dynamic> systemPreferences,
  });
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? uiConfig = null,
    Object? systemPreferences = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            uiConfig: null == uiConfig
                ? _value.uiConfig
                : uiConfig // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            systemPreferences: null == systemPreferences
                ? _value.systemPreferences
                : systemPreferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
    _$UserSettingsImpl value,
    $Res Function(_$UserSettingsImpl) then,
  ) = __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
    Map<String, dynamic> uiConfig,
    @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
    Map<String, dynamic> systemPreferences,
  });
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
    _$UserSettingsImpl _value,
    $Res Function(_$UserSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? uiConfig = null,
    Object? systemPreferences = null,
  }) {
    return _then(
      _$UserSettingsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        uiConfig: null == uiConfig
            ? _value._uiConfig
            : uiConfig // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        systemPreferences: null == systemPreferences
            ? _value._systemPreferences
            : systemPreferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
    final Map<String, dynamic> uiConfig = const {},
    @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
    final Map<String, dynamic> systemPreferences = const {},
  }) : _uiConfig = uiConfig,
       _systemPreferences = systemPreferences;

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  final Map<String, dynamic> _uiConfig;
  @override
  @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
  Map<String, dynamic> get uiConfig {
    if (_uiConfig is EqualUnmodifiableMapView) return _uiConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_uiConfig);
  }

  final Map<String, dynamic> _systemPreferences;
  @override
  @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
  Map<String, dynamic> get systemPreferences {
    if (_systemPreferences is EqualUnmodifiableMapView)
      return _systemPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_systemPreferences);
  }

  @override
  String toString() {
    return 'UserSettings(userId: $userId, uiConfig: $uiConfig, systemPreferences: $systemPreferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._uiConfig, _uiConfig) &&
            const DeepCollectionEquality().equals(
              other._systemPreferences,
              _systemPreferences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    const DeepCollectionEquality().hash(_uiConfig),
    const DeepCollectionEquality().hash(_systemPreferences),
  );

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(this);
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
    final Map<String, dynamic> uiConfig,
    @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
    final Map<String, dynamic> systemPreferences,
  }) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'ui_config', fromJson: _mapFromJson)
  Map<String, dynamic> get uiConfig;
  @override
  @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
  Map<String, dynamic> get systemPreferences;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
