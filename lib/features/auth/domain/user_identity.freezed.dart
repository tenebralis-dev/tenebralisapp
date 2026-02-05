// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserIdentity _$UserIdentityFromJson(Map<String, dynamic> json) {
  return _UserIdentity.fromJson(json);
}

/// @nodoc
mixin _$UserIdentity {
  /// Current world id.
  @JsonKey(name: 'world_id')
  String? get worldId => throw _privateConstructorUsedError;

  /// Role name shown in UI.
  @JsonKey(name: 'role_name')
  String get roleName => throw _privateConstructorUsedError;

  /// Title / epithet.
  @JsonKey(name: 'role_title')
  String get roleTitle => throw _privateConstructorUsedError;

  /// Simple status bars such as HP/MP.
  @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
  Map<String, int> get statusBars => throw _privateConstructorUsedError;

  /// Serializes this UserIdentity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserIdentityCopyWith<UserIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserIdentityCopyWith<$Res> {
  factory $UserIdentityCopyWith(
    UserIdentity value,
    $Res Function(UserIdentity) then,
  ) = _$UserIdentityCopyWithImpl<$Res, UserIdentity>;
  @useResult
  $Res call({
    @JsonKey(name: 'world_id') String? worldId,
    @JsonKey(name: 'role_name') String roleName,
    @JsonKey(name: 'role_title') String roleTitle,
    @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
    Map<String, int> statusBars,
  });
}

/// @nodoc
class _$UserIdentityCopyWithImpl<$Res, $Val extends UserIdentity>
    implements $UserIdentityCopyWith<$Res> {
  _$UserIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worldId = freezed,
    Object? roleName = null,
    Object? roleTitle = null,
    Object? statusBars = null,
  }) {
    return _then(
      _value.copyWith(
            worldId: freezed == worldId
                ? _value.worldId
                : worldId // ignore: cast_nullable_to_non_nullable
                      as String?,
            roleName: null == roleName
                ? _value.roleName
                : roleName // ignore: cast_nullable_to_non_nullable
                      as String,
            roleTitle: null == roleTitle
                ? _value.roleTitle
                : roleTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            statusBars: null == statusBars
                ? _value.statusBars
                : statusBars // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserIdentityImplCopyWith<$Res>
    implements $UserIdentityCopyWith<$Res> {
  factory _$$UserIdentityImplCopyWith(
    _$UserIdentityImpl value,
    $Res Function(_$UserIdentityImpl) then,
  ) = __$$UserIdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'world_id') String? worldId,
    @JsonKey(name: 'role_name') String roleName,
    @JsonKey(name: 'role_title') String roleTitle,
    @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
    Map<String, int> statusBars,
  });
}

/// @nodoc
class __$$UserIdentityImplCopyWithImpl<$Res>
    extends _$UserIdentityCopyWithImpl<$Res, _$UserIdentityImpl>
    implements _$$UserIdentityImplCopyWith<$Res> {
  __$$UserIdentityImplCopyWithImpl(
    _$UserIdentityImpl _value,
    $Res Function(_$UserIdentityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worldId = freezed,
    Object? roleName = null,
    Object? roleTitle = null,
    Object? statusBars = null,
  }) {
    return _then(
      _$UserIdentityImpl(
        worldId: freezed == worldId
            ? _value.worldId
            : worldId // ignore: cast_nullable_to_non_nullable
                  as String?,
        roleName: null == roleName
            ? _value.roleName
            : roleName // ignore: cast_nullable_to_non_nullable
                  as String,
        roleTitle: null == roleTitle
            ? _value.roleTitle
            : roleTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        statusBars: null == statusBars
            ? _value._statusBars
            : statusBars // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserIdentityImpl implements _UserIdentity {
  const _$UserIdentityImpl({
    @JsonKey(name: 'world_id') this.worldId,
    @JsonKey(name: 'role_name') this.roleName = 'Unknown',
    @JsonKey(name: 'role_title') this.roleTitle = '',
    @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
    final Map<String, int> statusBars = const {},
  }) : _statusBars = statusBars;

  factory _$UserIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserIdentityImplFromJson(json);

  /// Current world id.
  @override
  @JsonKey(name: 'world_id')
  final String? worldId;

  /// Role name shown in UI.
  @override
  @JsonKey(name: 'role_name')
  final String roleName;

  /// Title / epithet.
  @override
  @JsonKey(name: 'role_title')
  final String roleTitle;

  /// Simple status bars such as HP/MP.
  final Map<String, int> _statusBars;

  /// Simple status bars such as HP/MP.
  @override
  @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
  Map<String, int> get statusBars {
    if (_statusBars is EqualUnmodifiableMapView) return _statusBars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statusBars);
  }

  @override
  String toString() {
    return 'UserIdentity(worldId: $worldId, roleName: $roleName, roleTitle: $roleTitle, statusBars: $statusBars)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserIdentityImpl &&
            (identical(other.worldId, worldId) || other.worldId == worldId) &&
            (identical(other.roleName, roleName) ||
                other.roleName == roleName) &&
            (identical(other.roleTitle, roleTitle) ||
                other.roleTitle == roleTitle) &&
            const DeepCollectionEquality().equals(
              other._statusBars,
              _statusBars,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    worldId,
    roleName,
    roleTitle,
    const DeepCollectionEquality().hash(_statusBars),
  );

  /// Create a copy of UserIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserIdentityImplCopyWith<_$UserIdentityImpl> get copyWith =>
      __$$UserIdentityImplCopyWithImpl<_$UserIdentityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserIdentityImplToJson(this);
  }
}

abstract class _UserIdentity implements UserIdentity {
  const factory _UserIdentity({
    @JsonKey(name: 'world_id') final String? worldId,
    @JsonKey(name: 'role_name') final String roleName,
    @JsonKey(name: 'role_title') final String roleTitle,
    @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
    final Map<String, int> statusBars,
  }) = _$UserIdentityImpl;

  factory _UserIdentity.fromJson(Map<String, dynamic> json) =
      _$UserIdentityImpl.fromJson;

  /// Current world id.
  @override
  @JsonKey(name: 'world_id')
  String? get worldId;

  /// Role name shown in UI.
  @override
  @JsonKey(name: 'role_name')
  String get roleName;

  /// Title / epithet.
  @override
  @JsonKey(name: 'role_title')
  String get roleTitle;

  /// Simple status bars such as HP/MP.
  @override
  @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
  Map<String, int> get statusBars;

  /// Create a copy of UserIdentity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserIdentityImplCopyWith<_$UserIdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
