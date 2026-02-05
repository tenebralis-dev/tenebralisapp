// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ThemePreset _$ThemePresetFromJson(Map<String, dynamic> json) {
  return _ThemePreset.fromJson(json);
}

/// @nodoc
mixin _$ThemePreset {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Theme preset schema version.
  ///
  /// - 1: legacy single color set (ThemePresetColors).
  /// - 2: new tokens with separate light/dark.
  int get schemaVersion => throw _privateConstructorUsedError;

  /// Tokens for light mode.
  ThemeTokens get lightTokens => throw _privateConstructorUsedError;

  /// Tokens for dark mode.
  ThemeTokens get darkTokens => throw _privateConstructorUsedError;
  bool get syncEnabled => throw _privateConstructorUsedError;
  bool get pendingSync => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ThemePreset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePresetCopyWith<ThemePreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePresetCopyWith<$Res> {
  factory $ThemePresetCopyWith(
    ThemePreset value,
    $Res Function(ThemePreset) then,
  ) = _$ThemePresetCopyWithImpl<$Res, ThemePreset>;
  @useResult
  $Res call({
    String id,
    String name,
    int schemaVersion,
    ThemeTokens lightTokens,
    ThemeTokens darkTokens,
    bool syncEnabled,
    bool pendingSync,
    DateTime? updatedAt,
  });

  $ThemeTokensCopyWith<$Res> get lightTokens;
  $ThemeTokensCopyWith<$Res> get darkTokens;
}

/// @nodoc
class _$ThemePresetCopyWithImpl<$Res, $Val extends ThemePreset>
    implements $ThemePresetCopyWith<$Res> {
  _$ThemePresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? schemaVersion = null,
    Object? lightTokens = null,
    Object? darkTokens = null,
    Object? syncEnabled = null,
    Object? pendingSync = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            schemaVersion: null == schemaVersion
                ? _value.schemaVersion
                : schemaVersion // ignore: cast_nullable_to_non_nullable
                      as int,
            lightTokens: null == lightTokens
                ? _value.lightTokens
                : lightTokens // ignore: cast_nullable_to_non_nullable
                      as ThemeTokens,
            darkTokens: null == darkTokens
                ? _value.darkTokens
                : darkTokens // ignore: cast_nullable_to_non_nullable
                      as ThemeTokens,
            syncEnabled: null == syncEnabled
                ? _value.syncEnabled
                : syncEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            pendingSync: null == pendingSync
                ? _value.pendingSync
                : pendingSync // ignore: cast_nullable_to_non_nullable
                      as bool,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeTokensCopyWith<$Res> get lightTokens {
    return $ThemeTokensCopyWith<$Res>(_value.lightTokens, (value) {
      return _then(_value.copyWith(lightTokens: value) as $Val);
    });
  }

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeTokensCopyWith<$Res> get darkTokens {
    return $ThemeTokensCopyWith<$Res>(_value.darkTokens, (value) {
      return _then(_value.copyWith(darkTokens: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThemePresetImplCopyWith<$Res>
    implements $ThemePresetCopyWith<$Res> {
  factory _$$ThemePresetImplCopyWith(
    _$ThemePresetImpl value,
    $Res Function(_$ThemePresetImpl) then,
  ) = __$$ThemePresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int schemaVersion,
    ThemeTokens lightTokens,
    ThemeTokens darkTokens,
    bool syncEnabled,
    bool pendingSync,
    DateTime? updatedAt,
  });

  @override
  $ThemeTokensCopyWith<$Res> get lightTokens;
  @override
  $ThemeTokensCopyWith<$Res> get darkTokens;
}

/// @nodoc
class __$$ThemePresetImplCopyWithImpl<$Res>
    extends _$ThemePresetCopyWithImpl<$Res, _$ThemePresetImpl>
    implements _$$ThemePresetImplCopyWith<$Res> {
  __$$ThemePresetImplCopyWithImpl(
    _$ThemePresetImpl _value,
    $Res Function(_$ThemePresetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? schemaVersion = null,
    Object? lightTokens = null,
    Object? darkTokens = null,
    Object? syncEnabled = null,
    Object? pendingSync = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ThemePresetImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        schemaVersion: null == schemaVersion
            ? _value.schemaVersion
            : schemaVersion // ignore: cast_nullable_to_non_nullable
                  as int,
        lightTokens: null == lightTokens
            ? _value.lightTokens
            : lightTokens // ignore: cast_nullable_to_non_nullable
                  as ThemeTokens,
        darkTokens: null == darkTokens
            ? _value.darkTokens
            : darkTokens // ignore: cast_nullable_to_non_nullable
                  as ThemeTokens,
        syncEnabled: null == syncEnabled
            ? _value.syncEnabled
            : syncEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        pendingSync: null == pendingSync
            ? _value.pendingSync
            : pendingSync // ignore: cast_nullable_to_non_nullable
                  as bool,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemePresetImpl implements _ThemePreset {
  const _$ThemePresetImpl({
    required this.id,
    required this.name,
    this.schemaVersion = 2,
    required this.lightTokens,
    required this.darkTokens,
    this.syncEnabled = false,
    this.pendingSync = false,
    this.updatedAt,
  });

  factory _$ThemePresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePresetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  /// Theme preset schema version.
  ///
  /// - 1: legacy single color set (ThemePresetColors).
  /// - 2: new tokens with separate light/dark.
  @override
  @JsonKey()
  final int schemaVersion;

  /// Tokens for light mode.
  @override
  final ThemeTokens lightTokens;

  /// Tokens for dark mode.
  @override
  final ThemeTokens darkTokens;
  @override
  @JsonKey()
  final bool syncEnabled;
  @override
  @JsonKey()
  final bool pendingSync;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ThemePreset(id: $id, name: $name, schemaVersion: $schemaVersion, lightTokens: $lightTokens, darkTokens: $darkTokens, syncEnabled: $syncEnabled, pendingSync: $pendingSync, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePresetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.lightTokens, lightTokens) ||
                other.lightTokens == lightTokens) &&
            (identical(other.darkTokens, darkTokens) ||
                other.darkTokens == darkTokens) &&
            (identical(other.syncEnabled, syncEnabled) ||
                other.syncEnabled == syncEnabled) &&
            (identical(other.pendingSync, pendingSync) ||
                other.pendingSync == pendingSync) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    schemaVersion,
    lightTokens,
    darkTokens,
    syncEnabled,
    pendingSync,
    updatedAt,
  );

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePresetImplCopyWith<_$ThemePresetImpl> get copyWith =>
      __$$ThemePresetImplCopyWithImpl<_$ThemePresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePresetImplToJson(this);
  }
}

abstract class _ThemePreset implements ThemePreset {
  const factory _ThemePreset({
    required final String id,
    required final String name,
    final int schemaVersion,
    required final ThemeTokens lightTokens,
    required final ThemeTokens darkTokens,
    final bool syncEnabled,
    final bool pendingSync,
    final DateTime? updatedAt,
  }) = _$ThemePresetImpl;

  factory _ThemePreset.fromJson(Map<String, dynamic> json) =
      _$ThemePresetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Theme preset schema version.
  ///
  /// - 1: legacy single color set (ThemePresetColors).
  /// - 2: new tokens with separate light/dark.
  @override
  int get schemaVersion;

  /// Tokens for light mode.
  @override
  ThemeTokens get lightTokens;

  /// Tokens for dark mode.
  @override
  ThemeTokens get darkTokens;
  @override
  bool get syncEnabled;
  @override
  bool get pendingSync;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePresetImplCopyWith<_$ThemePresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThemePresetColors _$ThemePresetColorsFromJson(Map<String, dynamic> json) {
  return _ThemePresetColors.fromJson(json);
}

/// @nodoc
mixin _$ThemePresetColors {
  String get primary => throw _privateConstructorUsedError;
  String get secondary => throw _privateConstructorUsedError;
  String get background => throw _privateConstructorUsedError;
  String get surface => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get success => throw _privateConstructorUsedError;
  String? get warning => throw _privateConstructorUsedError;

  /// Serializes this ThemePresetColors to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePresetColors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePresetColorsCopyWith<ThemePresetColors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePresetColorsCopyWith<$Res> {
  factory $ThemePresetColorsCopyWith(
    ThemePresetColors value,
    $Res Function(ThemePresetColors) then,
  ) = _$ThemePresetColorsCopyWithImpl<$Res, ThemePresetColors>;
  @useResult
  $Res call({
    String primary,
    String secondary,
    String background,
    String surface,
    String text,
    String? error,
    String? success,
    String? warning,
  });
}

/// @nodoc
class _$ThemePresetColorsCopyWithImpl<$Res, $Val extends ThemePresetColors>
    implements $ThemePresetColorsCopyWith<$Res> {
  _$ThemePresetColorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePresetColors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? secondary = null,
    Object? background = null,
    Object? surface = null,
    Object? text = null,
    Object? error = freezed,
    Object? success = freezed,
    Object? warning = freezed,
  }) {
    return _then(
      _value.copyWith(
            primary: null == primary
                ? _value.primary
                : primary // ignore: cast_nullable_to_non_nullable
                      as String,
            secondary: null == secondary
                ? _value.secondary
                : secondary // ignore: cast_nullable_to_non_nullable
                      as String,
            background: null == background
                ? _value.background
                : background // ignore: cast_nullable_to_non_nullable
                      as String,
            surface: null == surface
                ? _value.surface
                : surface // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            success: freezed == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as String?,
            warning: freezed == warning
                ? _value.warning
                : warning // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemePresetColorsImplCopyWith<$Res>
    implements $ThemePresetColorsCopyWith<$Res> {
  factory _$$ThemePresetColorsImplCopyWith(
    _$ThemePresetColorsImpl value,
    $Res Function(_$ThemePresetColorsImpl) then,
  ) = __$$ThemePresetColorsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String primary,
    String secondary,
    String background,
    String surface,
    String text,
    String? error,
    String? success,
    String? warning,
  });
}

/// @nodoc
class __$$ThemePresetColorsImplCopyWithImpl<$Res>
    extends _$ThemePresetColorsCopyWithImpl<$Res, _$ThemePresetColorsImpl>
    implements _$$ThemePresetColorsImplCopyWith<$Res> {
  __$$ThemePresetColorsImplCopyWithImpl(
    _$ThemePresetColorsImpl _value,
    $Res Function(_$ThemePresetColorsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemePresetColors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? secondary = null,
    Object? background = null,
    Object? surface = null,
    Object? text = null,
    Object? error = freezed,
    Object? success = freezed,
    Object? warning = freezed,
  }) {
    return _then(
      _$ThemePresetColorsImpl(
        primary: null == primary
            ? _value.primary
            : primary // ignore: cast_nullable_to_non_nullable
                  as String,
        secondary: null == secondary
            ? _value.secondary
            : secondary // ignore: cast_nullable_to_non_nullable
                  as String,
        background: null == background
            ? _value.background
            : background // ignore: cast_nullable_to_non_nullable
                  as String,
        surface: null == surface
            ? _value.surface
            : surface // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        success: freezed == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as String?,
        warning: freezed == warning
            ? _value.warning
            : warning // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemePresetColorsImpl implements _ThemePresetColors {
  const _$ThemePresetColorsImpl({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.text,
    this.error,
    this.success,
    this.warning,
  });

  factory _$ThemePresetColorsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePresetColorsImplFromJson(json);

  @override
  final String primary;
  @override
  final String secondary;
  @override
  final String background;
  @override
  final String surface;
  @override
  final String text;
  @override
  final String? error;
  @override
  final String? success;
  @override
  final String? warning;

  @override
  String toString() {
    return 'ThemePresetColors(primary: $primary, secondary: $secondary, background: $background, surface: $surface, text: $text, error: $error, success: $success, warning: $warning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePresetColorsImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.warning, warning) || other.warning == warning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    primary,
    secondary,
    background,
    surface,
    text,
    error,
    success,
    warning,
  );

  /// Create a copy of ThemePresetColors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePresetColorsImplCopyWith<_$ThemePresetColorsImpl> get copyWith =>
      __$$ThemePresetColorsImplCopyWithImpl<_$ThemePresetColorsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePresetColorsImplToJson(this);
  }
}

abstract class _ThemePresetColors implements ThemePresetColors {
  const factory _ThemePresetColors({
    required final String primary,
    required final String secondary,
    required final String background,
    required final String surface,
    required final String text,
    final String? error,
    final String? success,
    final String? warning,
  }) = _$ThemePresetColorsImpl;

  factory _ThemePresetColors.fromJson(Map<String, dynamic> json) =
      _$ThemePresetColorsImpl.fromJson;

  @override
  String get primary;
  @override
  String get secondary;
  @override
  String get background;
  @override
  String get surface;
  @override
  String get text;
  @override
  String? get error;
  @override
  String? get success;
  @override
  String? get warning;

  /// Create a copy of ThemePresetColors
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePresetColorsImplCopyWith<_$ThemePresetColorsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
