// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

World _$WorldFromJson(Map<String, dynamic> json) {
  return _World.fromJson(json);
}

/// @nodoc
mixin _$World {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: _colUserId)
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived_at')
  DateTime? get archivedAt => throw _privateConstructorUsedError;
  @JsonKey(name: _colCreatedAt)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: _colUpdatedAt)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this World to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of World
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldCopyWith<World> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldCopyWith<$Res> {
  factory $WorldCopyWith(World value, $Res Function(World) then) =
      _$WorldCopyWithImpl<$Res, World>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: _colUserId) String userId,
    String name,
    String? description,
    String? slug,
    @JsonKey(name: 'archived_at') DateTime? archivedAt,
    @JsonKey(name: _colCreatedAt) DateTime? createdAt,
    @JsonKey(name: _colUpdatedAt) DateTime? updatedAt,
  });
}

/// @nodoc
class _$WorldCopyWithImpl<$Res, $Val extends World>
    implements $WorldCopyWith<$Res> {
  _$WorldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of World
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? slug = freezed,
    Object? archivedAt = freezed,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            archivedAt: freezed == archivedAt
                ? _value.archivedAt
                : archivedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$WorldImplCopyWith<$Res> implements $WorldCopyWith<$Res> {
  factory _$$WorldImplCopyWith(
    _$WorldImpl value,
    $Res Function(_$WorldImpl) then,
  ) = __$$WorldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: _colUserId) String userId,
    String name,
    String? description,
    String? slug,
    @JsonKey(name: 'archived_at') DateTime? archivedAt,
    @JsonKey(name: _colCreatedAt) DateTime? createdAt,
    @JsonKey(name: _colUpdatedAt) DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WorldImplCopyWithImpl<$Res>
    extends _$WorldCopyWithImpl<$Res, _$WorldImpl>
    implements _$$WorldImplCopyWith<$Res> {
  __$$WorldImplCopyWithImpl(
    _$WorldImpl _value,
    $Res Function(_$WorldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of World
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? slug = freezed,
    Object? archivedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WorldImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        archivedAt: freezed == archivedAt
            ? _value.archivedAt
            : archivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$WorldImpl implements _World {
  const _$WorldImpl({
    required this.id,
    @JsonKey(name: _colUserId) required this.userId,
    required this.name,
    this.description,
    this.slug,
    @JsonKey(name: 'archived_at') this.archivedAt,
    @JsonKey(name: _colCreatedAt) this.createdAt,
    @JsonKey(name: _colUpdatedAt) this.updatedAt,
  });

  factory _$WorldImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: _colUserId)
  final String userId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? slug;
  @override
  @JsonKey(name: 'archived_at')
  final DateTime? archivedAt;
  @override
  @JsonKey(name: _colCreatedAt)
  final DateTime? createdAt;
  @override
  @JsonKey(name: _colUpdatedAt)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'World(id: $id, userId: $userId, name: $name, description: $description, slug: $slug, archivedAt: $archivedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.archivedAt, archivedAt) ||
                other.archivedAt == archivedAt) &&
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
    name,
    description,
    slug,
    archivedAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of World
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldImplCopyWith<_$WorldImpl> get copyWith =>
      __$$WorldImplCopyWithImpl<_$WorldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldImplToJson(this);
  }
}

abstract class _World implements World {
  const factory _World({
    required final String id,
    @JsonKey(name: _colUserId) required final String userId,
    required final String name,
    final String? description,
    final String? slug,
    @JsonKey(name: 'archived_at') final DateTime? archivedAt,
    @JsonKey(name: _colCreatedAt) final DateTime? createdAt,
    @JsonKey(name: _colUpdatedAt) final DateTime? updatedAt,
  }) = _$WorldImpl;

  factory _World.fromJson(Map<String, dynamic> json) = _$WorldImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: _colUserId)
  String get userId;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get slug;
  @override
  @JsonKey(name: 'archived_at')
  DateTime? get archivedAt;
  @override
  @JsonKey(name: _colCreatedAt)
  DateTime? get createdAt;
  @override
  @JsonKey(name: _colUpdatedAt)
  DateTime? get updatedAt;

  /// Create a copy of World
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldImplCopyWith<_$WorldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
