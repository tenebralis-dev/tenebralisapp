// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relationship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RelationshipModel _$RelationshipModelFromJson(Map<String, dynamic> json) {
  return _RelationshipModel.fromJson(json);
}

/// @nodoc
mixin _$RelationshipModel {
  /// UUID primary key
  String get id => throw _privateConstructorUsedError;

  /// User ID (foreign key to profiles)
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;

  /// World ID (foreign key to worlds)
  @JsonKey(name: 'world_id')
  String get worldId => throw _privateConstructorUsedError;

  /// Target type: 'npc' | 'quest'
  @JsonKey(name: 'target_type')
  RelationshipTargetType get targetType => throw _privateConstructorUsedError;

  /// Target key (NPC key or quest key)
  @JsonKey(name: 'target_key')
  String get targetKey => throw _privateConstructorUsedError;

  /// Relationship value (affection level or quest progress)
  int get value => throw _privateConstructorUsedError;

  /// Additional state data
  Map<String, dynamic> get state => throw _privateConstructorUsedError;

  /// Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this RelationshipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RelationshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RelationshipModelCopyWith<RelationshipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationshipModelCopyWith<$Res> {
  factory $RelationshipModelCopyWith(
    RelationshipModel value,
    $Res Function(RelationshipModel) then,
  ) = _$RelationshipModelCopyWithImpl<$Res, RelationshipModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'target_type') RelationshipTargetType targetType,
    @JsonKey(name: 'target_key') String targetKey,
    int value,
    Map<String, dynamic> state,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$RelationshipModelCopyWithImpl<$Res, $Val extends RelationshipModel>
    implements $RelationshipModelCopyWith<$Res> {
  _$RelationshipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RelationshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? targetType = null,
    Object? targetKey = null,
    Object? value = null,
    Object? state = null,
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
            targetType: null == targetType
                ? _value.targetType
                : targetType // ignore: cast_nullable_to_non_nullable
                      as RelationshipTargetType,
            targetKey: null == targetKey
                ? _value.targetKey
                : targetKey // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RelationshipModelImplCopyWith<$Res>
    implements $RelationshipModelCopyWith<$Res> {
  factory _$$RelationshipModelImplCopyWith(
    _$RelationshipModelImpl value,
    $Res Function(_$RelationshipModelImpl) then,
  ) = __$$RelationshipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String worldId,
    @JsonKey(name: 'target_type') RelationshipTargetType targetType,
    @JsonKey(name: 'target_key') String targetKey,
    int value,
    Map<String, dynamic> state,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$RelationshipModelImplCopyWithImpl<$Res>
    extends _$RelationshipModelCopyWithImpl<$Res, _$RelationshipModelImpl>
    implements _$$RelationshipModelImplCopyWith<$Res> {
  __$$RelationshipModelImplCopyWithImpl(
    _$RelationshipModelImpl _value,
    $Res Function(_$RelationshipModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RelationshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = null,
    Object? targetType = null,
    Object? targetKey = null,
    Object? value = null,
    Object? state = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RelationshipModelImpl(
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
        targetType: null == targetType
            ? _value.targetType
            : targetType // ignore: cast_nullable_to_non_nullable
                  as RelationshipTargetType,
        targetKey: null == targetKey
            ? _value.targetKey
            : targetKey // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        state: null == state
            ? _value._state
            : state // ignore: cast_nullable_to_non_nullable
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
class _$RelationshipModelImpl implements _RelationshipModel {
  const _$RelationshipModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'world_id') required this.worldId,
    @JsonKey(name: 'target_type') required this.targetType,
    @JsonKey(name: 'target_key') required this.targetKey,
    this.value = 0,
    final Map<String, dynamic> state = const {},
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _state = state;

  factory _$RelationshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipModelImplFromJson(json);

  /// UUID primary key
  @override
  final String id;

  /// User ID (foreign key to profiles)
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// World ID (foreign key to worlds)
  @override
  @JsonKey(name: 'world_id')
  final String worldId;

  /// Target type: 'npc' | 'quest'
  @override
  @JsonKey(name: 'target_type')
  final RelationshipTargetType targetType;

  /// Target key (NPC key or quest key)
  @override
  @JsonKey(name: 'target_key')
  final String targetKey;

  /// Relationship value (affection level or quest progress)
  @override
  @JsonKey()
  final int value;

  /// Additional state data
  final Map<String, dynamic> _state;

  /// Additional state data
  @override
  @JsonKey()
  Map<String, dynamic> get state {
    if (_state is EqualUnmodifiableMapView) return _state;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_state);
  }

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RelationshipModel(id: $id, userId: $userId, worldId: $worldId, targetType: $targetType, targetKey: $targetKey, value: $value, state: $state, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.worldId, worldId) || other.worldId == worldId) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetKey, targetKey) ||
                other.targetKey == targetKey) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._state, _state) &&
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
    targetType,
    targetKey,
    value,
    const DeepCollectionEquality().hash(_state),
    createdAt,
    updatedAt,
  );

  /// Create a copy of RelationshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      __$$RelationshipModelImplCopyWithImpl<_$RelationshipModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipModelImplToJson(this);
  }
}

abstract class _RelationshipModel implements RelationshipModel {
  const factory _RelationshipModel({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'world_id') required final String worldId,
    @JsonKey(name: 'target_type')
    required final RelationshipTargetType targetType,
    @JsonKey(name: 'target_key') required final String targetKey,
    final int value,
    final Map<String, dynamic> state,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$RelationshipModelImpl;

  factory _RelationshipModel.fromJson(Map<String, dynamic> json) =
      _$RelationshipModelImpl.fromJson;

  /// UUID primary key
  @override
  String get id;

  /// User ID (foreign key to profiles)
  @override
  @JsonKey(name: 'user_id')
  String get userId;

  /// World ID (foreign key to worlds)
  @override
  @JsonKey(name: 'world_id')
  String get worldId;

  /// Target type: 'npc' | 'quest'
  @override
  @JsonKey(name: 'target_type')
  RelationshipTargetType get targetType;

  /// Target key (NPC key or quest key)
  @override
  @JsonKey(name: 'target_key')
  String get targetKey;

  /// Relationship value (affection level or quest progress)
  @override
  int get value;

  /// Additional state data
  @override
  Map<String, dynamic> get state;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of RelationshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestState _$QuestStateFromJson(Map<String, dynamic> json) {
  return _QuestState.fromJson(json);
}

/// @nodoc
mixin _$QuestState {
  /// Current quest status
  QuestStatus get status => throw _privateConstructorUsedError;

  /// Current objective index
  @JsonKey(name: 'current_objective')
  int get currentObjective => throw _privateConstructorUsedError;

  /// Completed objectives
  @JsonKey(name: 'completed_objectives')
  List<int> get completedObjectives => throw _privateConstructorUsedError;

  /// Quest-specific flags
  Map<String, dynamic> get flags => throw _privateConstructorUsedError;

  /// Started timestamp
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;

  /// Completed timestamp
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this QuestState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestStateCopyWith<QuestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestStateCopyWith<$Res> {
  factory $QuestStateCopyWith(
    QuestState value,
    $Res Function(QuestState) then,
  ) = _$QuestStateCopyWithImpl<$Res, QuestState>;
  @useResult
  $Res call({
    QuestStatus status,
    @JsonKey(name: 'current_objective') int currentObjective,
    @JsonKey(name: 'completed_objectives') List<int> completedObjectives,
    Map<String, dynamic> flags,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  });
}

/// @nodoc
class _$QuestStateCopyWithImpl<$Res, $Val extends QuestState>
    implements $QuestStateCopyWith<$Res> {
  _$QuestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentObjective = null,
    Object? completedObjectives = null,
    Object? flags = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QuestStatus,
            currentObjective: null == currentObjective
                ? _value.currentObjective
                : currentObjective // ignore: cast_nullable_to_non_nullable
                      as int,
            completedObjectives: null == completedObjectives
                ? _value.completedObjectives
                : completedObjectives // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            flags: null == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestStateImplCopyWith<$Res>
    implements $QuestStateCopyWith<$Res> {
  factory _$$QuestStateImplCopyWith(
    _$QuestStateImpl value,
    $Res Function(_$QuestStateImpl) then,
  ) = __$$QuestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    QuestStatus status,
    @JsonKey(name: 'current_objective') int currentObjective,
    @JsonKey(name: 'completed_objectives') List<int> completedObjectives,
    Map<String, dynamic> flags,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  });
}

/// @nodoc
class __$$QuestStateImplCopyWithImpl<$Res>
    extends _$QuestStateCopyWithImpl<$Res, _$QuestStateImpl>
    implements _$$QuestStateImplCopyWith<$Res> {
  __$$QuestStateImplCopyWithImpl(
    _$QuestStateImpl _value,
    $Res Function(_$QuestStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentObjective = null,
    Object? completedObjectives = null,
    Object? flags = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$QuestStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QuestStatus,
        currentObjective: null == currentObjective
            ? _value.currentObjective
            : currentObjective // ignore: cast_nullable_to_non_nullable
                  as int,
        completedObjectives: null == completedObjectives
            ? _value._completedObjectives
            : completedObjectives // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        flags: null == flags
            ? _value._flags
            : flags // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestStateImpl implements _QuestState {
  const _$QuestStateImpl({
    this.status = QuestStatus.notStarted,
    @JsonKey(name: 'current_objective') this.currentObjective = 0,
    @JsonKey(name: 'completed_objectives')
    final List<int> completedObjectives = const [],
    final Map<String, dynamic> flags = const {},
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
  }) : _completedObjectives = completedObjectives,
       _flags = flags;

  factory _$QuestStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestStateImplFromJson(json);

  /// Current quest status
  @override
  @JsonKey()
  final QuestStatus status;

  /// Current objective index
  @override
  @JsonKey(name: 'current_objective')
  final int currentObjective;

  /// Completed objectives
  final List<int> _completedObjectives;

  /// Completed objectives
  @override
  @JsonKey(name: 'completed_objectives')
  List<int> get completedObjectives {
    if (_completedObjectives is EqualUnmodifiableListView)
      return _completedObjectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedObjectives);
  }

  /// Quest-specific flags
  final Map<String, dynamic> _flags;

  /// Quest-specific flags
  @override
  @JsonKey()
  Map<String, dynamic> get flags {
    if (_flags is EqualUnmodifiableMapView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_flags);
  }

  /// Started timestamp
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;

  /// Completed timestamp
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  @override
  String toString() {
    return 'QuestState(status: $status, currentObjective: $currentObjective, completedObjectives: $completedObjectives, flags: $flags, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentObjective, currentObjective) ||
                other.currentObjective == currentObjective) &&
            const DeepCollectionEquality().equals(
              other._completedObjectives,
              _completedObjectives,
            ) &&
            const DeepCollectionEquality().equals(other._flags, _flags) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    currentObjective,
    const DeepCollectionEquality().hash(_completedObjectives),
    const DeepCollectionEquality().hash(_flags),
    startedAt,
    completedAt,
  );

  /// Create a copy of QuestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestStateImplCopyWith<_$QuestStateImpl> get copyWith =>
      __$$QuestStateImplCopyWithImpl<_$QuestStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestStateImplToJson(this);
  }
}

abstract class _QuestState implements QuestState {
  const factory _QuestState({
    final QuestStatus status,
    @JsonKey(name: 'current_objective') final int currentObjective,
    @JsonKey(name: 'completed_objectives') final List<int> completedObjectives,
    final Map<String, dynamic> flags,
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
  }) = _$QuestStateImpl;

  factory _QuestState.fromJson(Map<String, dynamic> json) =
      _$QuestStateImpl.fromJson;

  /// Current quest status
  @override
  QuestStatus get status;

  /// Current objective index
  @override
  @JsonKey(name: 'current_objective')
  int get currentObjective;

  /// Completed objectives
  @override
  @JsonKey(name: 'completed_objectives')
  List<int> get completedObjectives;

  /// Quest-specific flags
  @override
  Map<String, dynamic> get flags;

  /// Started timestamp
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;

  /// Completed timestamp
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;

  /// Create a copy of QuestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestStateImplCopyWith<_$QuestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AffectionState _$AffectionStateFromJson(Map<String, dynamic> json) {
  return _AffectionState.fromJson(json);
}

/// @nodoc
mixin _$AffectionState {
  /// Affection level (0-100)
  int get level => throw _privateConstructorUsedError;

  /// Relationship stage: 'stranger' | 'acquaintance' | 'friend' | 'close' | 'intimate'
  String get stage => throw _privateConstructorUsedError;

  /// Unlocked dialogue options
  @JsonKey(name: 'unlocked_dialogues')
  List<String> get unlockedDialogues => throw _privateConstructorUsedError;

  /// Gift history
  @JsonKey(name: 'gift_history')
  List<String> get giftHistory => throw _privateConstructorUsedError;

  /// Interaction count
  @JsonKey(name: 'interaction_count')
  int get interactionCount => throw _privateConstructorUsedError;

  /// Last interaction timestamp
  @JsonKey(name: 'last_interaction')
  DateTime? get lastInteraction => throw _privateConstructorUsedError;

  /// Serializes this AffectionState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AffectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AffectionStateCopyWith<AffectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AffectionStateCopyWith<$Res> {
  factory $AffectionStateCopyWith(
    AffectionState value,
    $Res Function(AffectionState) then,
  ) = _$AffectionStateCopyWithImpl<$Res, AffectionState>;
  @useResult
  $Res call({
    int level,
    String stage,
    @JsonKey(name: 'unlocked_dialogues') List<String> unlockedDialogues,
    @JsonKey(name: 'gift_history') List<String> giftHistory,
    @JsonKey(name: 'interaction_count') int interactionCount,
    @JsonKey(name: 'last_interaction') DateTime? lastInteraction,
  });
}

/// @nodoc
class _$AffectionStateCopyWithImpl<$Res, $Val extends AffectionState>
    implements $AffectionStateCopyWith<$Res> {
  _$AffectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AffectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? stage = null,
    Object? unlockedDialogues = null,
    Object? giftHistory = null,
    Object? interactionCount = null,
    Object? lastInteraction = freezed,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            stage: null == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as String,
            unlockedDialogues: null == unlockedDialogues
                ? _value.unlockedDialogues
                : unlockedDialogues // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            giftHistory: null == giftHistory
                ? _value.giftHistory
                : giftHistory // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            interactionCount: null == interactionCount
                ? _value.interactionCount
                : interactionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastInteraction: freezed == lastInteraction
                ? _value.lastInteraction
                : lastInteraction // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AffectionStateImplCopyWith<$Res>
    implements $AffectionStateCopyWith<$Res> {
  factory _$$AffectionStateImplCopyWith(
    _$AffectionStateImpl value,
    $Res Function(_$AffectionStateImpl) then,
  ) = __$$AffectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int level,
    String stage,
    @JsonKey(name: 'unlocked_dialogues') List<String> unlockedDialogues,
    @JsonKey(name: 'gift_history') List<String> giftHistory,
    @JsonKey(name: 'interaction_count') int interactionCount,
    @JsonKey(name: 'last_interaction') DateTime? lastInteraction,
  });
}

/// @nodoc
class __$$AffectionStateImplCopyWithImpl<$Res>
    extends _$AffectionStateCopyWithImpl<$Res, _$AffectionStateImpl>
    implements _$$AffectionStateImplCopyWith<$Res> {
  __$$AffectionStateImplCopyWithImpl(
    _$AffectionStateImpl _value,
    $Res Function(_$AffectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AffectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? stage = null,
    Object? unlockedDialogues = null,
    Object? giftHistory = null,
    Object? interactionCount = null,
    Object? lastInteraction = freezed,
  }) {
    return _then(
      _$AffectionStateImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        stage: null == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as String,
        unlockedDialogues: null == unlockedDialogues
            ? _value._unlockedDialogues
            : unlockedDialogues // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        giftHistory: null == giftHistory
            ? _value._giftHistory
            : giftHistory // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        interactionCount: null == interactionCount
            ? _value.interactionCount
            : interactionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastInteraction: freezed == lastInteraction
            ? _value.lastInteraction
            : lastInteraction // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AffectionStateImpl implements _AffectionState {
  const _$AffectionStateImpl({
    this.level = 0,
    this.stage = 'stranger',
    @JsonKey(name: 'unlocked_dialogues')
    final List<String> unlockedDialogues = const [],
    @JsonKey(name: 'gift_history') final List<String> giftHistory = const [],
    @JsonKey(name: 'interaction_count') this.interactionCount = 0,
    @JsonKey(name: 'last_interaction') this.lastInteraction,
  }) : _unlockedDialogues = unlockedDialogues,
       _giftHistory = giftHistory;

  factory _$AffectionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AffectionStateImplFromJson(json);

  /// Affection level (0-100)
  @override
  @JsonKey()
  final int level;

  /// Relationship stage: 'stranger' | 'acquaintance' | 'friend' | 'close' | 'intimate'
  @override
  @JsonKey()
  final String stage;

  /// Unlocked dialogue options
  final List<String> _unlockedDialogues;

  /// Unlocked dialogue options
  @override
  @JsonKey(name: 'unlocked_dialogues')
  List<String> get unlockedDialogues {
    if (_unlockedDialogues is EqualUnmodifiableListView)
      return _unlockedDialogues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlockedDialogues);
  }

  /// Gift history
  final List<String> _giftHistory;

  /// Gift history
  @override
  @JsonKey(name: 'gift_history')
  List<String> get giftHistory {
    if (_giftHistory is EqualUnmodifiableListView) return _giftHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_giftHistory);
  }

  /// Interaction count
  @override
  @JsonKey(name: 'interaction_count')
  final int interactionCount;

  /// Last interaction timestamp
  @override
  @JsonKey(name: 'last_interaction')
  final DateTime? lastInteraction;

  @override
  String toString() {
    return 'AffectionState(level: $level, stage: $stage, unlockedDialogues: $unlockedDialogues, giftHistory: $giftHistory, interactionCount: $interactionCount, lastInteraction: $lastInteraction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AffectionStateImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            const DeepCollectionEquality().equals(
              other._unlockedDialogues,
              _unlockedDialogues,
            ) &&
            const DeepCollectionEquality().equals(
              other._giftHistory,
              _giftHistory,
            ) &&
            (identical(other.interactionCount, interactionCount) ||
                other.interactionCount == interactionCount) &&
            (identical(other.lastInteraction, lastInteraction) ||
                other.lastInteraction == lastInteraction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    level,
    stage,
    const DeepCollectionEquality().hash(_unlockedDialogues),
    const DeepCollectionEquality().hash(_giftHistory),
    interactionCount,
    lastInteraction,
  );

  /// Create a copy of AffectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AffectionStateImplCopyWith<_$AffectionStateImpl> get copyWith =>
      __$$AffectionStateImplCopyWithImpl<_$AffectionStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AffectionStateImplToJson(this);
  }
}

abstract class _AffectionState implements AffectionState {
  const factory _AffectionState({
    final int level,
    final String stage,
    @JsonKey(name: 'unlocked_dialogues') final List<String> unlockedDialogues,
    @JsonKey(name: 'gift_history') final List<String> giftHistory,
    @JsonKey(name: 'interaction_count') final int interactionCount,
    @JsonKey(name: 'last_interaction') final DateTime? lastInteraction,
  }) = _$AffectionStateImpl;

  factory _AffectionState.fromJson(Map<String, dynamic> json) =
      _$AffectionStateImpl.fromJson;

  /// Affection level (0-100)
  @override
  int get level;

  /// Relationship stage: 'stranger' | 'acquaintance' | 'friend' | 'close' | 'intimate'
  @override
  String get stage;

  /// Unlocked dialogue options
  @override
  @JsonKey(name: 'unlocked_dialogues')
  List<String> get unlockedDialogues;

  /// Gift history
  @override
  @JsonKey(name: 'gift_history')
  List<String> get giftHistory;

  /// Interaction count
  @override
  @JsonKey(name: 'interaction_count')
  int get interactionCount;

  /// Last interaction timestamp
  @override
  @JsonKey(name: 'last_interaction')
  DateTime? get lastInteraction;

  /// Create a copy of AffectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AffectionStateImplCopyWith<_$AffectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
