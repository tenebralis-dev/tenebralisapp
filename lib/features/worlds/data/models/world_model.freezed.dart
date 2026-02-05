// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorldModel _$WorldModelFromJson(Map<String, dynamic> json) {
  return _WorldModel.fromJson(json);
}

/// @nodoc
mixin _$WorldModel {
  /// UUID primary key
  String get id => throw _privateConstructorUsedError;

  /// World name
  String get name => throw _privateConstructorUsedError;

  /// World genre (fantasy, sci-fi, modern, etc.)
  String get genre => throw _privateConstructorUsedError;

  /// World settings including AI prompts
  WorldSettings? get settings => throw _privateConstructorUsedError;

  /// Initial state when entering the world
  @JsonKey(name: 'initial_state')
  WorldInitialState? get initialState => throw _privateConstructorUsedError;

  /// World description
  String? get description => throw _privateConstructorUsedError;

  /// Cover image URL
  @JsonKey(name: 'cover_image')
  String? get coverImage => throw _privateConstructorUsedError;

  /// Whether the world is public
  @JsonKey(name: 'is_public')
  bool get isPublic => throw _privateConstructorUsedError;

  /// Creator user ID
  @JsonKey(name: 'creator_id')
  String? get creatorId => throw _privateConstructorUsedError;

  /// Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WorldModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldModelCopyWith<WorldModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldModelCopyWith<$Res> {
  factory $WorldModelCopyWith(
    WorldModel value,
    $Res Function(WorldModel) then,
  ) = _$WorldModelCopyWithImpl<$Res, WorldModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String genre,
    WorldSettings? settings,
    @JsonKey(name: 'initial_state') WorldInitialState? initialState,
    String? description,
    @JsonKey(name: 'cover_image') String? coverImage,
    @JsonKey(name: 'is_public') bool isPublic,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  $WorldSettingsCopyWith<$Res>? get settings;
  $WorldInitialStateCopyWith<$Res>? get initialState;
}

/// @nodoc
class _$WorldModelCopyWithImpl<$Res, $Val extends WorldModel>
    implements $WorldModelCopyWith<$Res> {
  _$WorldModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? genre = null,
    Object? settings = freezed,
    Object? initialState = freezed,
    Object? description = freezed,
    Object? coverImage = freezed,
    Object? isPublic = null,
    Object? creatorId = freezed,
    Object? createdAt = freezed,
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
            genre: null == genre
                ? _value.genre
                : genre // ignore: cast_nullable_to_non_nullable
                      as String,
            settings: freezed == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as WorldSettings?,
            initialState: freezed == initialState
                ? _value.initialState
                : initialState // ignore: cast_nullable_to_non_nullable
                      as WorldInitialState?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            creatorId: freezed == creatorId
                ? _value.creatorId
                : creatorId // ignore: cast_nullable_to_non_nullable
                      as String?,
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

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorldSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $WorldSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorldInitialStateCopyWith<$Res>? get initialState {
    if (_value.initialState == null) {
      return null;
    }

    return $WorldInitialStateCopyWith<$Res>(_value.initialState!, (value) {
      return _then(_value.copyWith(initialState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorldModelImplCopyWith<$Res>
    implements $WorldModelCopyWith<$Res> {
  factory _$$WorldModelImplCopyWith(
    _$WorldModelImpl value,
    $Res Function(_$WorldModelImpl) then,
  ) = __$$WorldModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String genre,
    WorldSettings? settings,
    @JsonKey(name: 'initial_state') WorldInitialState? initialState,
    String? description,
    @JsonKey(name: 'cover_image') String? coverImage,
    @JsonKey(name: 'is_public') bool isPublic,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  @override
  $WorldSettingsCopyWith<$Res>? get settings;
  @override
  $WorldInitialStateCopyWith<$Res>? get initialState;
}

/// @nodoc
class __$$WorldModelImplCopyWithImpl<$Res>
    extends _$WorldModelCopyWithImpl<$Res, _$WorldModelImpl>
    implements _$$WorldModelImplCopyWith<$Res> {
  __$$WorldModelImplCopyWithImpl(
    _$WorldModelImpl _value,
    $Res Function(_$WorldModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? genre = null,
    Object? settings = freezed,
    Object? initialState = freezed,
    Object? description = freezed,
    Object? coverImage = freezed,
    Object? isPublic = null,
    Object? creatorId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WorldModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        genre: null == genre
            ? _value.genre
            : genre // ignore: cast_nullable_to_non_nullable
                  as String,
        settings: freezed == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as WorldSettings?,
        initialState: freezed == initialState
            ? _value.initialState
            : initialState // ignore: cast_nullable_to_non_nullable
                  as WorldInitialState?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        creatorId: freezed == creatorId
            ? _value.creatorId
            : creatorId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$WorldModelImpl implements _WorldModel {
  const _$WorldModelImpl({
    required this.id,
    required this.name,
    required this.genre,
    this.settings,
    @JsonKey(name: 'initial_state') this.initialState,
    this.description,
    @JsonKey(name: 'cover_image') this.coverImage,
    @JsonKey(name: 'is_public') this.isPublic = false,
    @JsonKey(name: 'creator_id') this.creatorId,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$WorldModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldModelImplFromJson(json);

  /// UUID primary key
  @override
  final String id;

  /// World name
  @override
  final String name;

  /// World genre (fantasy, sci-fi, modern, etc.)
  @override
  final String genre;

  /// World settings including AI prompts
  @override
  final WorldSettings? settings;

  /// Initial state when entering the world
  @override
  @JsonKey(name: 'initial_state')
  final WorldInitialState? initialState;

  /// World description
  @override
  final String? description;

  /// Cover image URL
  @override
  @JsonKey(name: 'cover_image')
  final String? coverImage;

  /// Whether the world is public
  @override
  @JsonKey(name: 'is_public')
  final bool isPublic;

  /// Creator user ID
  @override
  @JsonKey(name: 'creator_id')
  final String? creatorId;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WorldModel(id: $id, name: $name, genre: $genre, settings: $settings, initialState: $initialState, description: $description, coverImage: $coverImage, isPublic: $isPublic, creatorId: $creatorId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.initialState, initialState) ||
                other.initialState == initialState) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
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
    name,
    genre,
    settings,
    initialState,
    description,
    coverImage,
    isPublic,
    creatorId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldModelImplCopyWith<_$WorldModelImpl> get copyWith =>
      __$$WorldModelImplCopyWithImpl<_$WorldModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldModelImplToJson(this);
  }
}

abstract class _WorldModel implements WorldModel {
  const factory _WorldModel({
    required final String id,
    required final String name,
    required final String genre,
    final WorldSettings? settings,
    @JsonKey(name: 'initial_state') final WorldInitialState? initialState,
    final String? description,
    @JsonKey(name: 'cover_image') final String? coverImage,
    @JsonKey(name: 'is_public') final bool isPublic,
    @JsonKey(name: 'creator_id') final String? creatorId,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$WorldModelImpl;

  factory _WorldModel.fromJson(Map<String, dynamic> json) =
      _$WorldModelImpl.fromJson;

  /// UUID primary key
  @override
  String get id;

  /// World name
  @override
  String get name;

  /// World genre (fantasy, sci-fi, modern, etc.)
  @override
  String get genre;

  /// World settings including AI prompts
  @override
  WorldSettings? get settings;

  /// Initial state when entering the world
  @override
  @JsonKey(name: 'initial_state')
  WorldInitialState? get initialState;

  /// World description
  @override
  String? get description;

  /// Cover image URL
  @override
  @JsonKey(name: 'cover_image')
  String? get coverImage;

  /// Whether the world is public
  @override
  @JsonKey(name: 'is_public')
  bool get isPublic;

  /// Creator user ID
  @override
  @JsonKey(name: 'creator_id')
  String? get creatorId;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of WorldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldModelImplCopyWith<_$WorldModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorldSettings _$WorldSettingsFromJson(Map<String, dynamic> json) {
  return _WorldSettings.fromJson(json);
}

/// @nodoc
mixin _$WorldSettings {
  /// System prompt for AI
  @JsonKey(name: 'system_prompt')
  String? get systemPrompt => throw _privateConstructorUsedError;

  /// World background/lore prompt
  @JsonKey(name: 'world_prompt')
  String? get worldPrompt => throw _privateConstructorUsedError;

  /// Style instructions for AI responses
  @JsonKey(name: 'style_prompt')
  String? get stylePrompt => throw _privateConstructorUsedError;

  /// Available NPCs in this world
  List<NpcConfig> get npcs => throw _privateConstructorUsedError;

  /// Available quests in this world
  List<QuestConfig> get quests => throw _privateConstructorUsedError;

  /// World rules and constraints
  List<String> get rules => throw _privateConstructorUsedError;

  /// Additional metadata
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this WorldSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorldSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldSettingsCopyWith<WorldSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldSettingsCopyWith<$Res> {
  factory $WorldSettingsCopyWith(
    WorldSettings value,
    $Res Function(WorldSettings) then,
  ) = _$WorldSettingsCopyWithImpl<$Res, WorldSettings>;
  @useResult
  $Res call({
    @JsonKey(name: 'system_prompt') String? systemPrompt,
    @JsonKey(name: 'world_prompt') String? worldPrompt,
    @JsonKey(name: 'style_prompt') String? stylePrompt,
    List<NpcConfig> npcs,
    List<QuestConfig> quests,
    List<String> rules,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$WorldSettingsCopyWithImpl<$Res, $Val extends WorldSettings>
    implements $WorldSettingsCopyWith<$Res> {
  _$WorldSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = freezed,
    Object? worldPrompt = freezed,
    Object? stylePrompt = freezed,
    Object? npcs = null,
    Object? quests = null,
    Object? rules = null,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            systemPrompt: freezed == systemPrompt
                ? _value.systemPrompt
                : systemPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            worldPrompt: freezed == worldPrompt
                ? _value.worldPrompt
                : worldPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            stylePrompt: freezed == stylePrompt
                ? _value.stylePrompt
                : stylePrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            npcs: null == npcs
                ? _value.npcs
                : npcs // ignore: cast_nullable_to_non_nullable
                      as List<NpcConfig>,
            quests: null == quests
                ? _value.quests
                : quests // ignore: cast_nullable_to_non_nullable
                      as List<QuestConfig>,
            rules: null == rules
                ? _value.rules
                : rules // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorldSettingsImplCopyWith<$Res>
    implements $WorldSettingsCopyWith<$Res> {
  factory _$$WorldSettingsImplCopyWith(
    _$WorldSettingsImpl value,
    $Res Function(_$WorldSettingsImpl) then,
  ) = __$$WorldSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'system_prompt') String? systemPrompt,
    @JsonKey(name: 'world_prompt') String? worldPrompt,
    @JsonKey(name: 'style_prompt') String? stylePrompt,
    List<NpcConfig> npcs,
    List<QuestConfig> quests,
    List<String> rules,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$WorldSettingsImplCopyWithImpl<$Res>
    extends _$WorldSettingsCopyWithImpl<$Res, _$WorldSettingsImpl>
    implements _$$WorldSettingsImplCopyWith<$Res> {
  __$$WorldSettingsImplCopyWithImpl(
    _$WorldSettingsImpl _value,
    $Res Function(_$WorldSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorldSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = freezed,
    Object? worldPrompt = freezed,
    Object? stylePrompt = freezed,
    Object? npcs = null,
    Object? quests = null,
    Object? rules = null,
    Object? metadata = null,
  }) {
    return _then(
      _$WorldSettingsImpl(
        systemPrompt: freezed == systemPrompt
            ? _value.systemPrompt
            : systemPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        worldPrompt: freezed == worldPrompt
            ? _value.worldPrompt
            : worldPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        stylePrompt: freezed == stylePrompt
            ? _value.stylePrompt
            : stylePrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        npcs: null == npcs
            ? _value._npcs
            : npcs // ignore: cast_nullable_to_non_nullable
                  as List<NpcConfig>,
        quests: null == quests
            ? _value._quests
            : quests // ignore: cast_nullable_to_non_nullable
                  as List<QuestConfig>,
        rules: null == rules
            ? _value._rules
            : rules // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorldSettingsImpl implements _WorldSettings {
  const _$WorldSettingsImpl({
    @JsonKey(name: 'system_prompt') this.systemPrompt,
    @JsonKey(name: 'world_prompt') this.worldPrompt,
    @JsonKey(name: 'style_prompt') this.stylePrompt,
    final List<NpcConfig> npcs = const [],
    final List<QuestConfig> quests = const [],
    final List<String> rules = const [],
    final Map<String, dynamic> metadata = const {},
  }) : _npcs = npcs,
       _quests = quests,
       _rules = rules,
       _metadata = metadata;

  factory _$WorldSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldSettingsImplFromJson(json);

  /// System prompt for AI
  @override
  @JsonKey(name: 'system_prompt')
  final String? systemPrompt;

  /// World background/lore prompt
  @override
  @JsonKey(name: 'world_prompt')
  final String? worldPrompt;

  /// Style instructions for AI responses
  @override
  @JsonKey(name: 'style_prompt')
  final String? stylePrompt;

  /// Available NPCs in this world
  final List<NpcConfig> _npcs;

  /// Available NPCs in this world
  @override
  @JsonKey()
  List<NpcConfig> get npcs {
    if (_npcs is EqualUnmodifiableListView) return _npcs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_npcs);
  }

  /// Available quests in this world
  final List<QuestConfig> _quests;

  /// Available quests in this world
  @override
  @JsonKey()
  List<QuestConfig> get quests {
    if (_quests is EqualUnmodifiableListView) return _quests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quests);
  }

  /// World rules and constraints
  final List<String> _rules;

  /// World rules and constraints
  @override
  @JsonKey()
  List<String> get rules {
    if (_rules is EqualUnmodifiableListView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rules);
  }

  /// Additional metadata
  final Map<String, dynamic> _metadata;

  /// Additional metadata
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'WorldSettings(systemPrompt: $systemPrompt, worldPrompt: $worldPrompt, stylePrompt: $stylePrompt, npcs: $npcs, quests: $quests, rules: $rules, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldSettingsImpl &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.worldPrompt, worldPrompt) ||
                other.worldPrompt == worldPrompt) &&
            (identical(other.stylePrompt, stylePrompt) ||
                other.stylePrompt == stylePrompt) &&
            const DeepCollectionEquality().equals(other._npcs, _npcs) &&
            const DeepCollectionEquality().equals(other._quests, _quests) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    systemPrompt,
    worldPrompt,
    stylePrompt,
    const DeepCollectionEquality().hash(_npcs),
    const DeepCollectionEquality().hash(_quests),
    const DeepCollectionEquality().hash(_rules),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of WorldSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldSettingsImplCopyWith<_$WorldSettingsImpl> get copyWith =>
      __$$WorldSettingsImplCopyWithImpl<_$WorldSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldSettingsImplToJson(this);
  }
}

abstract class _WorldSettings implements WorldSettings {
  const factory _WorldSettings({
    @JsonKey(name: 'system_prompt') final String? systemPrompt,
    @JsonKey(name: 'world_prompt') final String? worldPrompt,
    @JsonKey(name: 'style_prompt') final String? stylePrompt,
    final List<NpcConfig> npcs,
    final List<QuestConfig> quests,
    final List<String> rules,
    final Map<String, dynamic> metadata,
  }) = _$WorldSettingsImpl;

  factory _WorldSettings.fromJson(Map<String, dynamic> json) =
      _$WorldSettingsImpl.fromJson;

  /// System prompt for AI
  @override
  @JsonKey(name: 'system_prompt')
  String? get systemPrompt;

  /// World background/lore prompt
  @override
  @JsonKey(name: 'world_prompt')
  String? get worldPrompt;

  /// Style instructions for AI responses
  @override
  @JsonKey(name: 'style_prompt')
  String? get stylePrompt;

  /// Available NPCs in this world
  @override
  List<NpcConfig> get npcs;

  /// Available quests in this world
  @override
  List<QuestConfig> get quests;

  /// World rules and constraints
  @override
  List<String> get rules;

  /// Additional metadata
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of WorldSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldSettingsImplCopyWith<_$WorldSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NpcConfig _$NpcConfigFromJson(Map<String, dynamic> json) {
  return _NpcConfig.fromJson(json);
}

/// @nodoc
mixin _$NpcConfig {
  /// NPC unique key
  String get key => throw _privateConstructorUsedError;

  /// NPC display name
  String get name => throw _privateConstructorUsedError;

  /// NPC personality prompt
  String? get personality => throw _privateConstructorUsedError;

  /// NPC avatar URL
  String? get avatar => throw _privateConstructorUsedError;

  /// NPC role/occupation
  String? get role => throw _privateConstructorUsedError;

  /// Initial affection value
  int get initialAffection => throw _privateConstructorUsedError;

  /// Serializes this NpcConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NpcConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NpcConfigCopyWith<NpcConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NpcConfigCopyWith<$Res> {
  factory $NpcConfigCopyWith(NpcConfig value, $Res Function(NpcConfig) then) =
      _$NpcConfigCopyWithImpl<$Res, NpcConfig>;
  @useResult
  $Res call({
    String key,
    String name,
    String? personality,
    String? avatar,
    String? role,
    int initialAffection,
  });
}

/// @nodoc
class _$NpcConfigCopyWithImpl<$Res, $Val extends NpcConfig>
    implements $NpcConfigCopyWith<$Res> {
  _$NpcConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NpcConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? personality = freezed,
    Object? avatar = freezed,
    Object? role = freezed,
    Object? initialAffection = null,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            personality: freezed == personality
                ? _value.personality
                : personality // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            initialAffection: null == initialAffection
                ? _value.initialAffection
                : initialAffection // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NpcConfigImplCopyWith<$Res>
    implements $NpcConfigCopyWith<$Res> {
  factory _$$NpcConfigImplCopyWith(
    _$NpcConfigImpl value,
    $Res Function(_$NpcConfigImpl) then,
  ) = __$$NpcConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String key,
    String name,
    String? personality,
    String? avatar,
    String? role,
    int initialAffection,
  });
}

/// @nodoc
class __$$NpcConfigImplCopyWithImpl<$Res>
    extends _$NpcConfigCopyWithImpl<$Res, _$NpcConfigImpl>
    implements _$$NpcConfigImplCopyWith<$Res> {
  __$$NpcConfigImplCopyWithImpl(
    _$NpcConfigImpl _value,
    $Res Function(_$NpcConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NpcConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? personality = freezed,
    Object? avatar = freezed,
    Object? role = freezed,
    Object? initialAffection = null,
  }) {
    return _then(
      _$NpcConfigImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        personality: freezed == personality
            ? _value.personality
            : personality // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        initialAffection: null == initialAffection
            ? _value.initialAffection
            : initialAffection // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NpcConfigImpl implements _NpcConfig {
  const _$NpcConfigImpl({
    required this.key,
    required this.name,
    this.personality,
    this.avatar,
    this.role,
    this.initialAffection = 0,
  });

  factory _$NpcConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$NpcConfigImplFromJson(json);

  /// NPC unique key
  @override
  final String key;

  /// NPC display name
  @override
  final String name;

  /// NPC personality prompt
  @override
  final String? personality;

  /// NPC avatar URL
  @override
  final String? avatar;

  /// NPC role/occupation
  @override
  final String? role;

  /// Initial affection value
  @override
  @JsonKey()
  final int initialAffection;

  @override
  String toString() {
    return 'NpcConfig(key: $key, name: $name, personality: $personality, avatar: $avatar, role: $role, initialAffection: $initialAffection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NpcConfigImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.personality, personality) ||
                other.personality == personality) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.initialAffection, initialAffection) ||
                other.initialAffection == initialAffection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    key,
    name,
    personality,
    avatar,
    role,
    initialAffection,
  );

  /// Create a copy of NpcConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NpcConfigImplCopyWith<_$NpcConfigImpl> get copyWith =>
      __$$NpcConfigImplCopyWithImpl<_$NpcConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NpcConfigImplToJson(this);
  }
}

abstract class _NpcConfig implements NpcConfig {
  const factory _NpcConfig({
    required final String key,
    required final String name,
    final String? personality,
    final String? avatar,
    final String? role,
    final int initialAffection,
  }) = _$NpcConfigImpl;

  factory _NpcConfig.fromJson(Map<String, dynamic> json) =
      _$NpcConfigImpl.fromJson;

  /// NPC unique key
  @override
  String get key;

  /// NPC display name
  @override
  String get name;

  /// NPC personality prompt
  @override
  String? get personality;

  /// NPC avatar URL
  @override
  String? get avatar;

  /// NPC role/occupation
  @override
  String? get role;

  /// Initial affection value
  @override
  int get initialAffection;

  /// Create a copy of NpcConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NpcConfigImplCopyWith<_$NpcConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestConfig _$QuestConfigFromJson(Map<String, dynamic> json) {
  return _QuestConfig.fromJson(json);
}

/// @nodoc
mixin _$QuestConfig {
  /// Quest unique key
  String get key => throw _privateConstructorUsedError;

  /// Quest title
  String get title => throw _privateConstructorUsedError;

  /// Quest description
  String? get description => throw _privateConstructorUsedError;

  /// Quest type: 'main' | 'side' | 'daily'
  String get type => throw _privateConstructorUsedError;

  /// Quest objectives
  List<String> get objectives => throw _privateConstructorUsedError;

  /// Rewards for completing the quest
  Map<String, dynamic> get rewards => throw _privateConstructorUsedError;

  /// Serializes this QuestConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestConfigCopyWith<QuestConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestConfigCopyWith<$Res> {
  factory $QuestConfigCopyWith(
    QuestConfig value,
    $Res Function(QuestConfig) then,
  ) = _$QuestConfigCopyWithImpl<$Res, QuestConfig>;
  @useResult
  $Res call({
    String key,
    String title,
    String? description,
    String type,
    List<String> objectives,
    Map<String, dynamic> rewards,
  });
}

/// @nodoc
class _$QuestConfigCopyWithImpl<$Res, $Val extends QuestConfig>
    implements $QuestConfigCopyWith<$Res> {
  _$QuestConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? objectives = null,
    Object? rewards = null,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            objectives: null == objectives
                ? _value.objectives
                : objectives // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            rewards: null == rewards
                ? _value.rewards
                : rewards // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestConfigImplCopyWith<$Res>
    implements $QuestConfigCopyWith<$Res> {
  factory _$$QuestConfigImplCopyWith(
    _$QuestConfigImpl value,
    $Res Function(_$QuestConfigImpl) then,
  ) = __$$QuestConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String key,
    String title,
    String? description,
    String type,
    List<String> objectives,
    Map<String, dynamic> rewards,
  });
}

/// @nodoc
class __$$QuestConfigImplCopyWithImpl<$Res>
    extends _$QuestConfigCopyWithImpl<$Res, _$QuestConfigImpl>
    implements _$$QuestConfigImplCopyWith<$Res> {
  __$$QuestConfigImplCopyWithImpl(
    _$QuestConfigImpl _value,
    $Res Function(_$QuestConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? objectives = null,
    Object? rewards = null,
  }) {
    return _then(
      _$QuestConfigImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        objectives: null == objectives
            ? _value._objectives
            : objectives // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        rewards: null == rewards
            ? _value._rewards
            : rewards // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestConfigImpl implements _QuestConfig {
  const _$QuestConfigImpl({
    required this.key,
    required this.title,
    this.description,
    this.type = 'side',
    final List<String> objectives = const [],
    final Map<String, dynamic> rewards = const {},
  }) : _objectives = objectives,
       _rewards = rewards;

  factory _$QuestConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestConfigImplFromJson(json);

  /// Quest unique key
  @override
  final String key;

  /// Quest title
  @override
  final String title;

  /// Quest description
  @override
  final String? description;

  /// Quest type: 'main' | 'side' | 'daily'
  @override
  @JsonKey()
  final String type;

  /// Quest objectives
  final List<String> _objectives;

  /// Quest objectives
  @override
  @JsonKey()
  List<String> get objectives {
    if (_objectives is EqualUnmodifiableListView) return _objectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectives);
  }

  /// Rewards for completing the quest
  final Map<String, dynamic> _rewards;

  /// Rewards for completing the quest
  @override
  @JsonKey()
  Map<String, dynamic> get rewards {
    if (_rewards is EqualUnmodifiableMapView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rewards);
  }

  @override
  String toString() {
    return 'QuestConfig(key: $key, title: $title, description: $description, type: $type, objectives: $objectives, rewards: $rewards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestConfigImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._objectives,
              _objectives,
            ) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    key,
    title,
    description,
    type,
    const DeepCollectionEquality().hash(_objectives),
    const DeepCollectionEquality().hash(_rewards),
  );

  /// Create a copy of QuestConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestConfigImplCopyWith<_$QuestConfigImpl> get copyWith =>
      __$$QuestConfigImplCopyWithImpl<_$QuestConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestConfigImplToJson(this);
  }
}

abstract class _QuestConfig implements QuestConfig {
  const factory _QuestConfig({
    required final String key,
    required final String title,
    final String? description,
    final String type,
    final List<String> objectives,
    final Map<String, dynamic> rewards,
  }) = _$QuestConfigImpl;

  factory _QuestConfig.fromJson(Map<String, dynamic> json) =
      _$QuestConfigImpl.fromJson;

  /// Quest unique key
  @override
  String get key;

  /// Quest title
  @override
  String get title;

  /// Quest description
  @override
  String? get description;

  /// Quest type: 'main' | 'side' | 'daily'
  @override
  String get type;

  /// Quest objectives
  @override
  List<String> get objectives;

  /// Rewards for completing the quest
  @override
  Map<String, dynamic> get rewards;

  /// Create a copy of QuestConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestConfigImplCopyWith<_$QuestConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorldInitialState _$WorldInitialStateFromJson(Map<String, dynamic> json) {
  return _WorldInitialState.fromJson(json);
}

/// @nodoc
mixin _$WorldInitialState {
  /// Starting location/scene
  @JsonKey(name: 'starting_location')
  String? get startingLocation => throw _privateConstructorUsedError;

  /// Initial narrative text
  @JsonKey(name: 'opening_narrative')
  String? get openingNarrative => throw _privateConstructorUsedError;

  /// Initial available actions
  @JsonKey(name: 'initial_actions')
  List<String> get initialActions => throw _privateConstructorUsedError;

  /// Initial flags/variables
  Map<String, dynamic> get flags => throw _privateConstructorUsedError;

  /// Serializes this WorldInitialState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorldInitialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldInitialStateCopyWith<WorldInitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldInitialStateCopyWith<$Res> {
  factory $WorldInitialStateCopyWith(
    WorldInitialState value,
    $Res Function(WorldInitialState) then,
  ) = _$WorldInitialStateCopyWithImpl<$Res, WorldInitialState>;
  @useResult
  $Res call({
    @JsonKey(name: 'starting_location') String? startingLocation,
    @JsonKey(name: 'opening_narrative') String? openingNarrative,
    @JsonKey(name: 'initial_actions') List<String> initialActions,
    Map<String, dynamic> flags,
  });
}

/// @nodoc
class _$WorldInitialStateCopyWithImpl<$Res, $Val extends WorldInitialState>
    implements $WorldInitialStateCopyWith<$Res> {
  _$WorldInitialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldInitialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startingLocation = freezed,
    Object? openingNarrative = freezed,
    Object? initialActions = null,
    Object? flags = null,
  }) {
    return _then(
      _value.copyWith(
            startingLocation: freezed == startingLocation
                ? _value.startingLocation
                : startingLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
            openingNarrative: freezed == openingNarrative
                ? _value.openingNarrative
                : openingNarrative // ignore: cast_nullable_to_non_nullable
                      as String?,
            initialActions: null == initialActions
                ? _value.initialActions
                : initialActions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            flags: null == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorldInitialStateImplCopyWith<$Res>
    implements $WorldInitialStateCopyWith<$Res> {
  factory _$$WorldInitialStateImplCopyWith(
    _$WorldInitialStateImpl value,
    $Res Function(_$WorldInitialStateImpl) then,
  ) = __$$WorldInitialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'starting_location') String? startingLocation,
    @JsonKey(name: 'opening_narrative') String? openingNarrative,
    @JsonKey(name: 'initial_actions') List<String> initialActions,
    Map<String, dynamic> flags,
  });
}

/// @nodoc
class __$$WorldInitialStateImplCopyWithImpl<$Res>
    extends _$WorldInitialStateCopyWithImpl<$Res, _$WorldInitialStateImpl>
    implements _$$WorldInitialStateImplCopyWith<$Res> {
  __$$WorldInitialStateImplCopyWithImpl(
    _$WorldInitialStateImpl _value,
    $Res Function(_$WorldInitialStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorldInitialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startingLocation = freezed,
    Object? openingNarrative = freezed,
    Object? initialActions = null,
    Object? flags = null,
  }) {
    return _then(
      _$WorldInitialStateImpl(
        startingLocation: freezed == startingLocation
            ? _value.startingLocation
            : startingLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
        openingNarrative: freezed == openingNarrative
            ? _value.openingNarrative
            : openingNarrative // ignore: cast_nullable_to_non_nullable
                  as String?,
        initialActions: null == initialActions
            ? _value._initialActions
            : initialActions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        flags: null == flags
            ? _value._flags
            : flags // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorldInitialStateImpl implements _WorldInitialState {
  const _$WorldInitialStateImpl({
    @JsonKey(name: 'starting_location') this.startingLocation,
    @JsonKey(name: 'opening_narrative') this.openingNarrative,
    @JsonKey(name: 'initial_actions')
    final List<String> initialActions = const [],
    final Map<String, dynamic> flags = const {},
  }) : _initialActions = initialActions,
       _flags = flags;

  factory _$WorldInitialStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldInitialStateImplFromJson(json);

  /// Starting location/scene
  @override
  @JsonKey(name: 'starting_location')
  final String? startingLocation;

  /// Initial narrative text
  @override
  @JsonKey(name: 'opening_narrative')
  final String? openingNarrative;

  /// Initial available actions
  final List<String> _initialActions;

  /// Initial available actions
  @override
  @JsonKey(name: 'initial_actions')
  List<String> get initialActions {
    if (_initialActions is EqualUnmodifiableListView) return _initialActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialActions);
  }

  /// Initial flags/variables
  final Map<String, dynamic> _flags;

  /// Initial flags/variables
  @override
  @JsonKey()
  Map<String, dynamic> get flags {
    if (_flags is EqualUnmodifiableMapView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_flags);
  }

  @override
  String toString() {
    return 'WorldInitialState(startingLocation: $startingLocation, openingNarrative: $openingNarrative, initialActions: $initialActions, flags: $flags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldInitialStateImpl &&
            (identical(other.startingLocation, startingLocation) ||
                other.startingLocation == startingLocation) &&
            (identical(other.openingNarrative, openingNarrative) ||
                other.openingNarrative == openingNarrative) &&
            const DeepCollectionEquality().equals(
              other._initialActions,
              _initialActions,
            ) &&
            const DeepCollectionEquality().equals(other._flags, _flags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startingLocation,
    openingNarrative,
    const DeepCollectionEquality().hash(_initialActions),
    const DeepCollectionEquality().hash(_flags),
  );

  /// Create a copy of WorldInitialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldInitialStateImplCopyWith<_$WorldInitialStateImpl> get copyWith =>
      __$$WorldInitialStateImplCopyWithImpl<_$WorldInitialStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldInitialStateImplToJson(this);
  }
}

abstract class _WorldInitialState implements WorldInitialState {
  const factory _WorldInitialState({
    @JsonKey(name: 'starting_location') final String? startingLocation,
    @JsonKey(name: 'opening_narrative') final String? openingNarrative,
    @JsonKey(name: 'initial_actions') final List<String> initialActions,
    final Map<String, dynamic> flags,
  }) = _$WorldInitialStateImpl;

  factory _WorldInitialState.fromJson(Map<String, dynamic> json) =
      _$WorldInitialStateImpl.fromJson;

  /// Starting location/scene
  @override
  @JsonKey(name: 'starting_location')
  String? get startingLocation;

  /// Initial narrative text
  @override
  @JsonKey(name: 'opening_narrative')
  String? get openingNarrative;

  /// Initial available actions
  @override
  @JsonKey(name: 'initial_actions')
  List<String> get initialActions;

  /// Initial flags/variables
  @override
  Map<String, dynamic> get flags;

  /// Create a copy of WorldInitialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldInitialStateImplCopyWith<_$WorldInitialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
