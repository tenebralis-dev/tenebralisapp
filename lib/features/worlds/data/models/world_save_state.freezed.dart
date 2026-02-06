// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_save_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorldSaveState _$WorldSaveStateFromJson(Map<String, dynamic> json) {
  return _WorldSaveState.fromJson(json);
}

/// @nodoc
mixin _$WorldSaveState {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'world_id')
  String get worldId => throw _privateConstructorUsedError;
  @JsonKey(name: 'identity_id')
  String get identityId => throw _privateConstructorUsedError;
  int get slot => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get chapter => throw _privateConstructorUsedError;
  String? get stage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_progress_text')
  String? get promptProgressText => throw _privateConstructorUsedError;
  @JsonKey(name: 'state_json', fromJson: _mapFromJson)
  Map<String, dynamic> get stateJson => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_played_at')
  DateTime? get lastPlayedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WorldSaveState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorldSaveState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldSaveStateCopyWith<WorldSaveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldSaveStateCopyWith<$Res> {
  factory $WorldSaveStateCopyWith(
    WorldSaveState value,
    $Res Function(WorldSaveState) then,
  ) = _$WorldSaveStateCopyWithImpl<$Res, WorldSaveState>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'identity_id') String identityId,
    int slot,
    String? title,
    String? summary,
    String? chapter,
    String? stage,
    @JsonKey(name: 'prompt_progress_text') String? promptProgressText,
    @JsonKey(name: 'state_json', fromJson: _mapFromJson)
    Map<String, dynamic> stateJson,
    @JsonKey(name: 'last_played_at') DateTime? lastPlayedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$WorldSaveStateCopyWithImpl<$Res, $Val extends WorldSaveState>
    implements $WorldSaveStateCopyWith<$Res> {
  _$WorldSaveStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldSaveState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? identityId = null,
    Object? slot = null,
    Object? title = freezed,
    Object? summary = freezed,
    Object? chapter = freezed,
    Object? stage = freezed,
    Object? promptProgressText = freezed,
    Object? stateJson = null,
    Object? lastPlayedAt = freezed,
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
            identityId: null == identityId
                ? _value.identityId
                : identityId // ignore: cast_nullable_to_non_nullable
                      as String,
            slot: null == slot
                ? _value.slot
                : slot // ignore: cast_nullable_to_non_nullable
                      as int,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            chapter: freezed == chapter
                ? _value.chapter
                : chapter // ignore: cast_nullable_to_non_nullable
                      as String?,
            stage: freezed == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as String?,
            promptProgressText: freezed == promptProgressText
                ? _value.promptProgressText
                : promptProgressText // ignore: cast_nullable_to_non_nullable
                      as String?,
            stateJson: null == stateJson
                ? _value.stateJson
                : stateJson // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            lastPlayedAt: freezed == lastPlayedAt
                ? _value.lastPlayedAt
                : lastPlayedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WorldSaveStateImplCopyWith<$Res>
    implements $WorldSaveStateCopyWith<$Res> {
  factory _$$WorldSaveStateImplCopyWith(
    _$WorldSaveStateImpl value,
    $Res Function(_$WorldSaveStateImpl) then,
  ) = __$$WorldSaveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'identity_id') String identityId,
    int slot,
    String? title,
    String? summary,
    String? chapter,
    String? stage,
    @JsonKey(name: 'prompt_progress_text') String? promptProgressText,
    @JsonKey(name: 'state_json', fromJson: _mapFromJson)
    Map<String, dynamic> stateJson,
    @JsonKey(name: 'last_played_at') DateTime? lastPlayedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WorldSaveStateImplCopyWithImpl<$Res>
    extends _$WorldSaveStateCopyWithImpl<$Res, _$WorldSaveStateImpl>
    implements _$$WorldSaveStateImplCopyWith<$Res> {
  __$$WorldSaveStateImplCopyWithImpl(
    _$WorldSaveStateImpl _value,
    $Res Function(_$WorldSaveStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorldSaveState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? identityId = null,
    Object? slot = null,
    Object? title = freezed,
    Object? summary = freezed,
    Object? chapter = freezed,
    Object? stage = freezed,
    Object? promptProgressText = freezed,
    Object? stateJson = null,
    Object? lastPlayedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WorldSaveStateImpl(
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
        identityId: null == identityId
            ? _value.identityId
            : identityId // ignore: cast_nullable_to_non_nullable
                  as String,
        slot: null == slot
            ? _value.slot
            : slot // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        chapter: freezed == chapter
            ? _value.chapter
            : chapter // ignore: cast_nullable_to_non_nullable
                  as String?,
        stage: freezed == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as String?,
        promptProgressText: freezed == promptProgressText
            ? _value.promptProgressText
            : promptProgressText // ignore: cast_nullable_to_non_nullable
                  as String?,
        stateJson: null == stateJson
            ? _value._stateJson
            : stateJson // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        lastPlayedAt: freezed == lastPlayedAt
            ? _value.lastPlayedAt
            : lastPlayedAt // ignore: cast_nullable_to_non_nullable
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
class _$WorldSaveStateImpl implements _WorldSaveState {
  const _$WorldSaveStateImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'world_id') required this.worldId,
    @JsonKey(name: 'identity_id') required this.identityId,
    required this.slot,
    this.title,
    this.summary,
    this.chapter,
    this.stage,
    @JsonKey(name: 'prompt_progress_text') this.promptProgressText,
    @JsonKey(name: 'state_json', fromJson: _mapFromJson)
    final Map<String, dynamic> stateJson = const {},
    @JsonKey(name: 'last_played_at') this.lastPlayedAt,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _stateJson = stateJson;

  factory _$WorldSaveStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldSaveStateImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'world_id')
  final String worldId;
  @override
  @JsonKey(name: 'identity_id')
  final String identityId;
  @override
  final int slot;
  @override
  final String? title;
  @override
  final String? summary;
  @override
  final String? chapter;
  @override
  final String? stage;
  @override
  @JsonKey(name: 'prompt_progress_text')
  final String? promptProgressText;
  final Map<String, dynamic> _stateJson;
  @override
  @JsonKey(name: 'state_json', fromJson: _mapFromJson)
  Map<String, dynamic> get stateJson {
    if (_stateJson is EqualUnmodifiableMapView) return _stateJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stateJson);
  }

  @override
  @JsonKey(name: 'last_played_at')
  final DateTime? lastPlayedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WorldSaveState(id: $id, userId: $userId, worldId: $worldId, identityId: $identityId, slot: $slot, title: $title, summary: $summary, chapter: $chapter, stage: $stage, promptProgressText: $promptProgressText, stateJson: $stateJson, lastPlayedAt: $lastPlayedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldSaveStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.worldId, worldId) || other.worldId == worldId) &&
            (identical(other.identityId, identityId) ||
                other.identityId == identityId) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.promptProgressText, promptProgressText) ||
                other.promptProgressText == promptProgressText) &&
            const DeepCollectionEquality().equals(
              other._stateJson,
              _stateJson,
            ) &&
            (identical(other.lastPlayedAt, lastPlayedAt) ||
                other.lastPlayedAt == lastPlayedAt) &&
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
    identityId,
    slot,
    title,
    summary,
    chapter,
    stage,
    promptProgressText,
    const DeepCollectionEquality().hash(_stateJson),
    lastPlayedAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of WorldSaveState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldSaveStateImplCopyWith<_$WorldSaveStateImpl> get copyWith =>
      __$$WorldSaveStateImplCopyWithImpl<_$WorldSaveStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldSaveStateImplToJson(this);
  }
}

abstract class _WorldSaveState implements WorldSaveState {
  const factory _WorldSaveState({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'world_id') required final String worldId,
    @JsonKey(name: 'identity_id') required final String identityId,
    required final int slot,
    final String? title,
    final String? summary,
    final String? chapter,
    final String? stage,
    @JsonKey(name: 'prompt_progress_text') final String? promptProgressText,
    @JsonKey(name: 'state_json', fromJson: _mapFromJson)
    final Map<String, dynamic> stateJson,
    @JsonKey(name: 'last_played_at') final DateTime? lastPlayedAt,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$WorldSaveStateImpl;

  factory _WorldSaveState.fromJson(Map<String, dynamic> json) =
      _$WorldSaveStateImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'world_id')
  String get worldId;
  @override
  @JsonKey(name: 'identity_id')
  String get identityId;
  @override
  int get slot;
  @override
  String? get title;
  @override
  String? get summary;
  @override
  String? get chapter;
  @override
  String? get stage;
  @override
  @JsonKey(name: 'prompt_progress_text')
  String? get promptProgressText;
  @override
  @JsonKey(name: 'state_json', fromJson: _mapFromJson)
  Map<String, dynamic> get stateJson;
  @override
  @JsonKey(name: 'last_played_at')
  DateTime? get lastPlayedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of WorldSaveState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldSaveStateImplCopyWith<_$WorldSaveStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
