// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'global_points')
  int get globalPoints => throw _privateConstructorUsedError;

  /// Arbitrary preferences JSON.
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// Inventory JSON object.
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get inventory => throw _privateConstructorUsedError;

  /// Identity stored in `profiles.current_session`.
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  UserIdentity? get currentSession => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'global_points') int globalPoints,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> preferences,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> inventory,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? currentSession,
  });

  $UserIdentityCopyWith<$Res>? get currentSession;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalPoints = null,
    Object? preferences = null,
    Object? inventory = null,
    Object? currentSession = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            globalPoints: null == globalPoints
                ? _value.globalPoints
                : globalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            inventory: null == inventory
                ? _value.inventory
                : inventory // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            currentSession: freezed == currentSession
                ? _value.currentSession
                : currentSession // ignore: cast_nullable_to_non_nullable
                      as UserIdentity?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserIdentityCopyWith<$Res>? get currentSession {
    if (_value.currentSession == null) {
      return null;
    }

    return $UserIdentityCopyWith<$Res>(_value.currentSession!, (value) {
      return _then(_value.copyWith(currentSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'global_points') int globalPoints,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> preferences,
    @JsonKey(fromJson: _mapFromJson) Map<String, dynamic> inventory,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? currentSession,
  });

  @override
  $UserIdentityCopyWith<$Res>? get currentSession;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalPoints = null,
    Object? preferences = null,
    Object? inventory = null,
    Object? currentSession = freezed,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        globalPoints: null == globalPoints
            ? _value.globalPoints
            : globalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        preferences: null == preferences
            ? _value._preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        inventory: null == inventory
            ? _value._inventory
            : inventory // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        currentSession: freezed == currentSession
            ? _value.currentSession
            : currentSession // ignore: cast_nullable_to_non_nullable
                  as UserIdentity?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    @JsonKey(name: 'global_points') this.globalPoints = 0,
    @JsonKey(fromJson: _mapFromJson)
    final Map<String, dynamic> preferences = const {},
    @JsonKey(fromJson: _mapFromJson)
    final Map<String, dynamic> inventory = const {},
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    this.currentSession,
  }) : _preferences = preferences,
       _inventory = inventory;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'global_points')
  final int globalPoints;

  /// Arbitrary preferences JSON.
  final Map<String, dynamic> _preferences;

  /// Arbitrary preferences JSON.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  /// Inventory JSON object.
  final Map<String, dynamic> _inventory;

  /// Inventory JSON object.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get inventory {
    if (_inventory is EqualUnmodifiableMapView) return _inventory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_inventory);
  }

  /// Identity stored in `profiles.current_session`.
  @override
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  final UserIdentity? currentSession;

  @override
  String toString() {
    return 'UserProfile(id: $id, globalPoints: $globalPoints, preferences: $preferences, inventory: $inventory, currentSession: $currentSession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.globalPoints, globalPoints) ||
                other.globalPoints == globalPoints) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ) &&
            const DeepCollectionEquality().equals(
              other._inventory,
              _inventory,
            ) &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    globalPoints,
    const DeepCollectionEquality().hash(_preferences),
    const DeepCollectionEquality().hash(_inventory),
    currentSession,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    @JsonKey(name: 'global_points') final int globalPoints,
    @JsonKey(fromJson: _mapFromJson) final Map<String, dynamic> preferences,
    @JsonKey(fromJson: _mapFromJson) final Map<String, dynamic> inventory,
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    final UserIdentity? currentSession,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'global_points')
  int get globalPoints;

  /// Arbitrary preferences JSON.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get preferences;

  /// Inventory JSON object.
  @override
  @JsonKey(fromJson: _mapFromJson)
  Map<String, dynamic> get inventory;

  /// Identity stored in `profiles.current_session`.
  @override
  @JsonKey(name: 'current_session', fromJson: _identityFromJson)
  UserIdentity? get currentSession;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
