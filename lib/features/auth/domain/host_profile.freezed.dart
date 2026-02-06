// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HostProfile _$HostProfileFromJson(Map<String, dynamic> json) {
  return _HostProfile.fromJson(json);
}

/// @nodoc
mixin _$HostProfile {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'system_level')
  int get systemLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'exp_points')
  int get expPoints => throw _privateConstructorUsedError;

  /// For backward-compat only: if any old data path still provides identity JSON.
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  UserIdentity? get legacyCurrentSession => throw _privateConstructorUsedError;

  /// For backward-compat only: preferences JSON from old profiles table.
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get legacyPreferences =>
      throw _privateConstructorUsedError;

  /// Serializes this HostProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HostProfileCopyWith<HostProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostProfileCopyWith<$Res> {
  factory $HostProfileCopyWith(
    HostProfile value,
    $Res Function(HostProfile) then,
  ) = _$HostProfileCopyWithImpl<$Res, HostProfile>;
  @useResult
  $Res call({
    String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'system_level') int systemLevel,
    @JsonKey(name: 'exp_points') int expPoints,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? legacyCurrentSession,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> legacyPreferences,
  });

  $UserIdentityCopyWith<$Res>? get legacyCurrentSession;
}

/// @nodoc
class _$HostProfileCopyWithImpl<$Res, $Val extends HostProfile>
    implements $HostProfileCopyWith<$Res> {
  _$HostProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? systemLevel = null,
    Object? expPoints = null,
    Object? legacyCurrentSession = freezed,
    Object? legacyPreferences = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemLevel: null == systemLevel
                ? _value.systemLevel
                : systemLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            expPoints: null == expPoints
                ? _value.expPoints
                : expPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            legacyCurrentSession: freezed == legacyCurrentSession
                ? _value.legacyCurrentSession
                : legacyCurrentSession // ignore: cast_nullable_to_non_nullable
                      as UserIdentity?,
            legacyPreferences: null == legacyPreferences
                ? _value.legacyPreferences
                : legacyPreferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserIdentityCopyWith<$Res>? get legacyCurrentSession {
    if (_value.legacyCurrentSession == null) {
      return null;
    }

    return $UserIdentityCopyWith<$Res>(_value.legacyCurrentSession!, (value) {
      return _then(_value.copyWith(legacyCurrentSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HostProfileImplCopyWith<$Res>
    implements $HostProfileCopyWith<$Res> {
  factory _$$HostProfileImplCopyWith(
    _$HostProfileImpl value,
    $Res Function(_$HostProfileImpl) then,
  ) = __$$HostProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'system_level') int systemLevel,
    @JsonKey(name: 'exp_points') int expPoints,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? legacyCurrentSession,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> legacyPreferences,
  });

  @override
  $UserIdentityCopyWith<$Res>? get legacyCurrentSession;
}

/// @nodoc
class __$$HostProfileImplCopyWithImpl<$Res>
    extends _$HostProfileCopyWithImpl<$Res, _$HostProfileImpl>
    implements _$$HostProfileImplCopyWith<$Res> {
  __$$HostProfileImplCopyWithImpl(
    _$HostProfileImpl _value,
    $Res Function(_$HostProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? bio = freezed,
    Object? systemLevel = null,
    Object? expPoints = null,
    Object? legacyCurrentSession = freezed,
    Object? legacyPreferences = null,
  }) {
    return _then(
      _$HostProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemLevel: null == systemLevel
            ? _value.systemLevel
            : systemLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        expPoints: null == expPoints
            ? _value.expPoints
            : expPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        legacyCurrentSession: freezed == legacyCurrentSession
            ? _value.legacyCurrentSession
            : legacyCurrentSession // ignore: cast_nullable_to_non_nullable
                  as UserIdentity?,
        legacyPreferences: null == legacyPreferences
            ? _value._legacyPreferences
            : legacyPreferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HostProfileImpl implements _HostProfile {
  const _$HostProfileImpl({
    required this.id,
    this.username,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    this.bio,
    @JsonKey(name: 'system_level') this.systemLevel = 1,
    @JsonKey(name: 'exp_points') this.expPoints = 0,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    this.legacyCurrentSession,
    @JsonKey(fromJson: _mapFromJson)
    final Map<String, dynamic> legacyPreferences = const {},
  }) : _legacyPreferences = legacyPreferences;

  factory _$HostProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$HostProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'system_level')
  final int systemLevel;
  @override
  @JsonKey(name: 'exp_points')
  final int expPoints;

  /// For backward-compat only: if any old data path still provides identity JSON.
  @override
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  final UserIdentity? legacyCurrentSession;

  /// For backward-compat only: preferences JSON from old profiles table.
  final Map<String, dynamic> _legacyPreferences;

  /// For backward-compat only: preferences JSON from old profiles table.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get legacyPreferences {
    if (_legacyPreferences is EqualUnmodifiableMapView)
      return _legacyPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_legacyPreferences);
  }

  @override
  String toString() {
    return 'HostProfile(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, bio: $bio, systemLevel: $systemLevel, expPoints: $expPoints, legacyCurrentSession: $legacyCurrentSession, legacyPreferences: $legacyPreferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.systemLevel, systemLevel) ||
                other.systemLevel == systemLevel) &&
            (identical(other.expPoints, expPoints) ||
                other.expPoints == expPoints) &&
            (identical(other.legacyCurrentSession, legacyCurrentSession) ||
                other.legacyCurrentSession == legacyCurrentSession) &&
            const DeepCollectionEquality().equals(
              other._legacyPreferences,
              _legacyPreferences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    displayName,
    avatarUrl,
    bio,
    systemLevel,
    expPoints,
    legacyCurrentSession,
    const DeepCollectionEquality().hash(_legacyPreferences),
  );

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HostProfileImplCopyWith<_$HostProfileImpl> get copyWith =>
      __$$HostProfileImplCopyWithImpl<_$HostProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HostProfileImplToJson(this);
  }
}

abstract class _HostProfile implements HostProfile {
  const factory _HostProfile({
    required final String id,
    final String? username,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    final String? bio,
    @JsonKey(name: 'system_level') final int systemLevel,
    @JsonKey(name: 'exp_points') final int expPoints,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    final UserIdentity? legacyCurrentSession,
    @JsonKey(fromJson: _mapFromJson)
    final Map<String, dynamic> legacyPreferences,
  }) = _$HostProfileImpl;

  factory _HostProfile.fromJson(Map<String, dynamic> json) =
      _$HostProfileImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'system_level')
  int get systemLevel;
  @override
  @JsonKey(name: 'exp_points')
  int get expPoints;

  /// For backward-compat only: if any old data path still provides identity JSON.
  @override
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  UserIdentity? get legacyCurrentSession;

  /// For backward-compat only: preferences JSON from old profiles table.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get legacyPreferences;

  /// Create a copy of HostProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HostProfileImplCopyWith<_$HostProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
