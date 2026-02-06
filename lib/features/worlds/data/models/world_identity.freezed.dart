// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorldIdentity _$WorldIdentityFromJson(Map<String, dynamic> json) {
  return _WorldIdentity.fromJson(json);
}

/// @nodoc
mixin _$WorldIdentity {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'world_id')
  String get worldId => throw _privateConstructorUsedError;
  @JsonKey(name: 'identity_name')
  String get identityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_identity_text')
  String? get promptIdentityText => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_data_json')
  Map<String, dynamic> get roleDataJson => throw _privateConstructorUsedError;
  @JsonKey(name: 'persona_json')
  Map<String, dynamic> get personaJson => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WorldIdentity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorldIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldIdentityCopyWith<WorldIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldIdentityCopyWith<$Res> {
  factory $WorldIdentityCopyWith(
    WorldIdentity value,
    $Res Function(WorldIdentity) then,
  ) = _$WorldIdentityCopyWithImpl<$Res, WorldIdentity>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'identity_name') String identityName,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'prompt_identity_text') String? promptIdentityText,
    @JsonKey(name: 'role_data_json') Map<String, dynamic> roleDataJson,
    @JsonKey(name: 'persona_json') Map<String, dynamic> personaJson,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$WorldIdentityCopyWithImpl<$Res, $Val extends WorldIdentity>
    implements $WorldIdentityCopyWith<$Res> {
  _$WorldIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? identityName = null,
    Object? isActive = null,
    Object? promptIdentityText = freezed,
    Object? roleDataJson = null,
    Object? personaJson = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            worldId: null == worldId
                ? _value.worldId
                : worldId // ignore: cast_nullable_to_non_nullable
                      as String,
            identityName: null == identityName
                ? _value.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            promptIdentityText: freezed == promptIdentityText
                ? _value.promptIdentityText
                : promptIdentityText // ignore: cast_nullable_to_non_nullable
                      as String?,
            roleDataJson: null == roleDataJson
                ? _value.roleDataJson
                : roleDataJson // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            personaJson: null == personaJson
                ? _value.personaJson
                : personaJson // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorldIdentityImplCopyWith<$Res>
    implements $WorldIdentityCopyWith<$Res> {
  factory _$$WorldIdentityImplCopyWith(
    _$WorldIdentityImpl value,
    $Res Function(_$WorldIdentityImpl) then,
  ) = __$$WorldIdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'identity_name') String identityName,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'prompt_identity_text') String? promptIdentityText,
    @JsonKey(name: 'role_data_json') Map<String, dynamic> roleDataJson,
    @JsonKey(name: 'persona_json') Map<String, dynamic> personaJson,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WorldIdentityImplCopyWithImpl<$Res>
    extends _$WorldIdentityCopyWithImpl<$Res, _$WorldIdentityImpl>
    implements _$$WorldIdentityImplCopyWith<$Res> {
  __$$WorldIdentityImplCopyWithImpl(
    _$WorldIdentityImpl _value,
    $Res Function(_$WorldIdentityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorldIdentity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? identityName = null,
    Object? isActive = null,
    Object? promptIdentityText = freezed,
    Object? roleDataJson = null,
    Object? personaJson = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WorldIdentityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        worldId: null == worldId
            ? _value.worldId
            : worldId // ignore: cast_nullable_to_non_nullable
                  as String,
        identityName: null == identityName
            ? _value.identityName
            : identityName // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        promptIdentityText: freezed == promptIdentityText
            ? _value.promptIdentityText
            : promptIdentityText // ignore: cast_nullable_to_non_nullable
                  as String?,
        roleDataJson: null == roleDataJson
            ? _value._roleDataJson
            : roleDataJson // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        personaJson: null == personaJson
            ? _value._personaJson
            : personaJson // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$WorldIdentityImpl implements _WorldIdentity {
  const _$WorldIdentityImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'world_id') required this.worldId,
    @JsonKey(name: 'identity_name') required this.identityName,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'prompt_identity_text') this.promptIdentityText,
    @JsonKey(name: 'role_data_json')
    final Map<String, dynamic> roleDataJson = const {},
    @JsonKey(name: 'persona_json')
    final Map<String, dynamic> personaJson = const {},
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _roleDataJson = roleDataJson,
       _personaJson = personaJson;

  factory _$WorldIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldIdentityImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'world_id')
  final String worldId;
  @override
  @JsonKey(name: 'identity_name')
  final String identityName;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'prompt_identity_text')
  final String? promptIdentityText;
  final Map<String, dynamic> _roleDataJson;
  @override
  @JsonKey(name: 'role_data_json')
  Map<String, dynamic> get roleDataJson {
    if (_roleDataJson is EqualUnmodifiableMapView) return _roleDataJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roleDataJson);
  }

  final Map<String, dynamic> _personaJson;
  @override
  @JsonKey(name: 'persona_json')
  Map<String, dynamic> get personaJson {
    if (_personaJson is EqualUnmodifiableMapView) return _personaJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_personaJson);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WorldIdentity(id: $id, userId: $userId, worldId: $worldId, identityName: $identityName, isActive: $isActive, promptIdentityText: $promptIdentityText, roleDataJson: $roleDataJson, personaJson: $personaJson, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldIdentityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.worldId, worldId) || other.worldId == worldId) &&
            (identical(other.identityName, identityName) ||
                other.identityName == identityName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.promptIdentityText, promptIdentityText) ||
                other.promptIdentityText == promptIdentityText) &&
            const DeepCollectionEquality().equals(
              other._roleDataJson,
              _roleDataJson,
            ) &&
            const DeepCollectionEquality().equals(
              other._personaJson,
              _personaJson,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    worldId,
    identityName,
    isActive,
    promptIdentityText,
    const DeepCollectionEquality().hash(_roleDataJson),
    const DeepCollectionEquality().hash(_personaJson),
    createdAt,
    updatedAt,
  );

  /// Create a copy of WorldIdentity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldIdentityImplCopyWith<_$WorldIdentityImpl> get copyWith =>
      __$$WorldIdentityImplCopyWithImpl<_$WorldIdentityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldIdentityImplToJson(this);
  }
}

abstract class _WorldIdentity implements WorldIdentity {
  const factory _WorldIdentity({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'world_id') required final String worldId,
    @JsonKey(name: 'identity_name') required final String identityName,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'prompt_identity_text') final String? promptIdentityText,
    @JsonKey(name: 'role_data_json') final Map<String, dynamic> roleDataJson,
    @JsonKey(name: 'persona_json') final Map<String, dynamic> personaJson,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$WorldIdentityImpl;

  factory _WorldIdentity.fromJson(Map<String, dynamic> json) =
      _$WorldIdentityImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'world_id')
  String get worldId;
  @override
  @JsonKey(name: 'identity_name')
  String get identityName;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'prompt_identity_text')
  String? get promptIdentityText;
  @override
  @JsonKey(name: 'role_data_json')
  Map<String, dynamic> get roleDataJson;
  @override
  @JsonKey(name: 'persona_json')
  Map<String, dynamic> get personaJson;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of WorldIdentity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldIdentityImplCopyWith<_$WorldIdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
