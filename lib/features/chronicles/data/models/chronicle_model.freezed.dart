// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chronicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChronicleModel _$ChronicleModelFromJson(Map<String, dynamic> json) {
  return _ChronicleModel.fromJson(json);
}

/// @nodoc
mixin _$ChronicleModel {
  /// UUID primary key
  String get id => throw _privateConstructorUsedError;

  /// User ID (foreign key to profiles)
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;

  /// World ID (nullable - some chronicles are global)
  @JsonKey(name: 'world_id')
  String? get worldId => throw _privateConstructorUsedError;

  /// Chronicle type: 'chat' | 'memo' | 'transaction'
  ChronicleType get type => throw _privateConstructorUsedError;

  /// Content varies by type
  ChronicleContent get content => throw _privateConstructorUsedError;

  /// Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChronicleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChronicleModelCopyWith<ChronicleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChronicleModelCopyWith<$Res> {
  factory $ChronicleModelCopyWith(
    ChronicleModel value,
    $Res Function(ChronicleModel) then,
  ) = _$ChronicleModelCopyWithImpl<$Res, ChronicleModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String? worldId,
    ChronicleType type,
    ChronicleContent content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  $ChronicleContentCopyWith<$Res> get content;
}

/// @nodoc
class _$ChronicleModelCopyWithImpl<$Res, $Val extends ChronicleModel>
    implements $ChronicleModelCopyWith<$Res> {
  _$ChronicleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = freezed,
    Object? type = null,
    Object? content = null,
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
            worldId: freezed == worldId
                ? _value.worldId
                : worldId // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ChronicleType,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as ChronicleContent,
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

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChronicleContentCopyWith<$Res> get content {
    return $ChronicleContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChronicleModelImplCopyWith<$Res>
    implements $ChronicleModelCopyWith<$Res> {
  factory _$$ChronicleModelImplCopyWith(
    _$ChronicleModelImpl value,
    $Res Function(_$ChronicleModelImpl) then,
  ) = __$$ChronicleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'world_id') String? worldId,
    ChronicleType type,
    ChronicleContent content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });

  @override
  $ChronicleContentCopyWith<$Res> get content;
}

/// @nodoc
class __$$ChronicleModelImplCopyWithImpl<$Res>
    extends _$ChronicleModelCopyWithImpl<$Res, _$ChronicleModelImpl>
    implements _$$ChronicleModelImplCopyWith<$Res> {
  __$$ChronicleModelImplCopyWithImpl(
    _$ChronicleModelImpl _value,
    $Res Function(_$ChronicleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? worldId = freezed,
    Object? type = null,
    Object? content = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ChronicleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        worldId: freezed == worldId
            ? _value.worldId
            : worldId // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ChronicleType,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as ChronicleContent,
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
class _$ChronicleModelImpl implements _ChronicleModel {
  const _$ChronicleModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'world_id') this.worldId,
    required this.type,
    required this.content,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$ChronicleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChronicleModelImplFromJson(json);

  /// UUID primary key
  @override
  final String id;

  /// User ID (foreign key to profiles)
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// World ID (nullable - some chronicles are global)
  @override
  @JsonKey(name: 'world_id')
  final String? worldId;

  /// Chronicle type: 'chat' | 'memo' | 'transaction'
  @override
  final ChronicleType type;

  /// Content varies by type
  @override
  final ChronicleContent content;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChronicleModel(id: $id, userId: $userId, worldId: $worldId, type: $type, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChronicleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.worldId, worldId) || other.worldId == worldId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
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
    type,
    content,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChronicleModelImplCopyWith<_$ChronicleModelImpl> get copyWith =>
      __$$ChronicleModelImplCopyWithImpl<_$ChronicleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChronicleModelImplToJson(this);
  }
}

abstract class _ChronicleModel implements ChronicleModel {
  const factory _ChronicleModel({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'world_id') final String? worldId,
    required final ChronicleType type,
    required final ChronicleContent content,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$ChronicleModelImpl;

  factory _ChronicleModel.fromJson(Map<String, dynamic> json) =
      _$ChronicleModelImpl.fromJson;

  /// UUID primary key
  @override
  String get id;

  /// User ID (foreign key to profiles)
  @override
  @JsonKey(name: 'user_id')
  String get userId;

  /// World ID (nullable - some chronicles are global)
  @override
  @JsonKey(name: 'world_id')
  String? get worldId;

  /// Chronicle type: 'chat' | 'memo' | 'transaction'
  @override
  ChronicleType get type;

  /// Content varies by type
  @override
  ChronicleContent get content;

  /// Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ChronicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChronicleModelImplCopyWith<_$ChronicleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChronicleContent _$ChronicleContentFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'chat':
      return ChatContent.fromJson(json);
    case 'memo':
      return MemoContent.fromJson(json);
    case 'transaction':
      return TransactionContent.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'ChronicleContent',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$ChronicleContent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )
    chat,
    required TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )
    memo,
    required TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )
    transaction,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult? Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult? Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatContent value) chat,
    required TResult Function(MemoContent value) memo,
    required TResult Function(TransactionContent value) transaction,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatContent value)? chat,
    TResult? Function(MemoContent value)? memo,
    TResult? Function(TransactionContent value)? transaction,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatContent value)? chat,
    TResult Function(MemoContent value)? memo,
    TResult Function(TransactionContent value)? transaction,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this ChronicleContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChronicleContentCopyWith<$Res> {
  factory $ChronicleContentCopyWith(
    ChronicleContent value,
    $Res Function(ChronicleContent) then,
  ) = _$ChronicleContentCopyWithImpl<$Res, ChronicleContent>;
}

/// @nodoc
class _$ChronicleContentCopyWithImpl<$Res, $Val extends ChronicleContent>
    implements $ChronicleContentCopyWith<$Res> {
  _$ChronicleContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatContentImplCopyWith<$Res> {
  factory _$$ChatContentImplCopyWith(
    _$ChatContentImpl value,
    $Res Function(_$ChatContentImpl) then,
  ) = __$$ChatContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String sender,
    String? npcKey,
    String message,
    List<SystemEvent> systemEvents,
    String? thought,
  });
}

/// @nodoc
class __$$ChatContentImplCopyWithImpl<$Res>
    extends _$ChronicleContentCopyWithImpl<$Res, _$ChatContentImpl>
    implements _$$ChatContentImplCopyWith<$Res> {
  __$$ChatContentImplCopyWithImpl(
    _$ChatContentImpl _value,
    $Res Function(_$ChatContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? npcKey = freezed,
    Object? message = null,
    Object? systemEvents = null,
    Object? thought = freezed,
  }) {
    return _then(
      _$ChatContentImpl(
        sender: null == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as String,
        npcKey: freezed == npcKey
            ? _value.npcKey
            : npcKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        systemEvents: null == systemEvents
            ? _value._systemEvents
            : systemEvents // ignore: cast_nullable_to_non_nullable
                  as List<SystemEvent>,
        thought: freezed == thought
            ? _value.thought
            : thought // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatContentImpl implements ChatContent {
  const _$ChatContentImpl({
    required this.sender,
    this.npcKey,
    required this.message,
    final List<SystemEvent> systemEvents = const [],
    this.thought,
    final String? $type,
  }) : _systemEvents = systemEvents,
       $type = $type ?? 'chat';

  factory _$ChatContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatContentImplFromJson(json);

  /// Message sender: 'user' | 'npc' | 'system'
  @override
  final String sender;

  /// NPC key if sender is NPC
  @override
  final String? npcKey;

  /// Message text
  @override
  final String message;

  /// System events triggered by this message
  final List<SystemEvent> _systemEvents;

  /// System events triggered by this message
  @override
  @JsonKey()
  List<SystemEvent> get systemEvents {
    if (_systemEvents is EqualUnmodifiableListView) return _systemEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_systemEvents);
  }

  /// AI thought process (hidden from user)
  @override
  final String? thought;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChronicleContent.chat(sender: $sender, npcKey: $npcKey, message: $message, systemEvents: $systemEvents, thought: $thought)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatContentImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.npcKey, npcKey) || other.npcKey == npcKey) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._systemEvents,
              _systemEvents,
            ) &&
            (identical(other.thought, thought) || other.thought == thought));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sender,
    npcKey,
    message,
    const DeepCollectionEquality().hash(_systemEvents),
    thought,
  );

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatContentImplCopyWith<_$ChatContentImpl> get copyWith =>
      __$$ChatContentImplCopyWithImpl<_$ChatContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )
    chat,
    required TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )
    memo,
    required TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )
    transaction,
  }) {
    return chat(sender, npcKey, message, systemEvents, thought);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult? Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult? Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
  }) {
    return chat?.call(sender, npcKey, message, systemEvents, thought);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(sender, npcKey, message, systemEvents, thought);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatContent value) chat,
    required TResult Function(MemoContent value) memo,
    required TResult Function(TransactionContent value) transaction,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatContent value)? chat,
    TResult? Function(MemoContent value)? memo,
    TResult? Function(TransactionContent value)? transaction,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatContent value)? chat,
    TResult Function(MemoContent value)? memo,
    TResult Function(TransactionContent value)? transaction,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatContentImplToJson(this);
  }
}

abstract class ChatContent implements ChronicleContent {
  const factory ChatContent({
    required final String sender,
    final String? npcKey,
    required final String message,
    final List<SystemEvent> systemEvents,
    final String? thought,
  }) = _$ChatContentImpl;

  factory ChatContent.fromJson(Map<String, dynamic> json) =
      _$ChatContentImpl.fromJson;

  /// Message sender: 'user' | 'npc' | 'system'
  String get sender;

  /// NPC key if sender is NPC
  String? get npcKey;

  /// Message text
  String get message;

  /// System events triggered by this message
  List<SystemEvent> get systemEvents;

  /// AI thought process (hidden from user)
  String? get thought;

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatContentImplCopyWith<_$ChatContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MemoContentImplCopyWith<$Res> {
  factory _$$MemoContentImplCopyWith(
    _$MemoContentImpl value,
    $Res Function(_$MemoContentImpl) then,
  ) = __$$MemoContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String body, List<String> tags, bool isPinned});
}

/// @nodoc
class __$$MemoContentImplCopyWithImpl<$Res>
    extends _$ChronicleContentCopyWithImpl<$Res, _$MemoContentImpl>
    implements _$$MemoContentImplCopyWith<$Res> {
  __$$MemoContentImplCopyWithImpl(
    _$MemoContentImpl _value,
    $Res Function(_$MemoContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? tags = null,
    Object? isPinned = null,
  }) {
    return _then(
      _$MemoContentImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoContentImpl implements MemoContent {
  const _$MemoContentImpl({
    required this.title,
    required this.body,
    final List<String> tags = const [],
    this.isPinned = false,
    final String? $type,
  }) : _tags = tags,
       $type = $type ?? 'memo';

  factory _$MemoContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoContentImplFromJson(json);

  /// Memo title
  @override
  final String title;

  /// Memo body text
  @override
  final String body;

  /// Tags for categorization
  final List<String> _tags;

  /// Tags for categorization
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Is pinned
  @override
  @JsonKey()
  final bool isPinned;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChronicleContent.memo(title: $title, body: $body, tags: $tags, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    body,
    const DeepCollectionEquality().hash(_tags),
    isPinned,
  );

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoContentImplCopyWith<_$MemoContentImpl> get copyWith =>
      __$$MemoContentImplCopyWithImpl<_$MemoContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )
    chat,
    required TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )
    memo,
    required TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )
    transaction,
  }) {
    return memo(title, body, tags, isPinned);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult? Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult? Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
  }) {
    return memo?.call(title, body, tags, isPinned);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(title, body, tags, isPinned);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatContent value) chat,
    required TResult Function(MemoContent value) memo,
    required TResult Function(TransactionContent value) transaction,
  }) {
    return memo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatContent value)? chat,
    TResult? Function(MemoContent value)? memo,
    TResult? Function(TransactionContent value)? transaction,
  }) {
    return memo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatContent value)? chat,
    TResult Function(MemoContent value)? memo,
    TResult Function(TransactionContent value)? transaction,
    required TResult orElse(),
  }) {
    if (memo != null) {
      return memo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoContentImplToJson(this);
  }
}

abstract class MemoContent implements ChronicleContent {
  const factory MemoContent({
    required final String title,
    required final String body,
    final List<String> tags,
    final bool isPinned,
  }) = _$MemoContentImpl;

  factory MemoContent.fromJson(Map<String, dynamic> json) =
      _$MemoContentImpl.fromJson;

  /// Memo title
  String get title;

  /// Memo body text
  String get body;

  /// Tags for categorization
  List<String> get tags;

  /// Is pinned
  bool get isPinned;

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoContentImplCopyWith<_$MemoContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionContentImplCopyWith<$Res> {
  factory _$$TransactionContentImplCopyWith(
    _$TransactionContentImpl value,
    $Res Function(_$TransactionContentImpl) then,
  ) = __$$TransactionContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String transactionType,
    int amount,
    String currencyType,
    String reason,
    String? referenceId,
  });
}

/// @nodoc
class __$$TransactionContentImplCopyWithImpl<$Res>
    extends _$ChronicleContentCopyWithImpl<$Res, _$TransactionContentImpl>
    implements _$$TransactionContentImplCopyWith<$Res> {
  __$$TransactionContentImplCopyWithImpl(
    _$TransactionContentImpl _value,
    $Res Function(_$TransactionContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionType = null,
    Object? amount = null,
    Object? currencyType = null,
    Object? reason = null,
    Object? referenceId = freezed,
  }) {
    return _then(
      _$TransactionContentImpl(
        transactionType: null == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        currencyType: null == currencyType
            ? _value.currencyType
            : currencyType // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionContentImpl implements TransactionContent {
  const _$TransactionContentImpl({
    required this.transactionType,
    required this.amount,
    this.currencyType = 'points',
    required this.reason,
    this.referenceId,
    final String? $type,
  }) : $type = $type ?? 'transaction';

  factory _$TransactionContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionContentImplFromJson(json);

  /// Transaction type: 'point_change' | 'item_purchase' | 'quest_reward'
  @override
  final String transactionType;

  /// Amount changed (positive or negative)
  @override
  final int amount;

  /// Currency or item type
  @override
  @JsonKey()
  final String currencyType;

  /// Reason for transaction
  @override
  final String reason;

  /// Reference ID (quest, item, etc.)
  @override
  final String? referenceId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ChronicleContent.transaction(transactionType: $transactionType, amount: $amount, currencyType: $currencyType, reason: $reason, referenceId: $referenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionContentImpl &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currencyType, currencyType) ||
                other.currencyType == currencyType) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    transactionType,
    amount,
    currencyType,
    reason,
    referenceId,
  );

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionContentImplCopyWith<_$TransactionContentImpl> get copyWith =>
      __$$TransactionContentImplCopyWithImpl<_$TransactionContentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )
    chat,
    required TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )
    memo,
    required TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )
    transaction,
  }) {
    return transaction(
      transactionType,
      amount,
      currencyType,
      reason,
      referenceId,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult? Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult? Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
  }) {
    return transaction?.call(
      transactionType,
      amount,
      currencyType,
      reason,
      referenceId,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String sender,
      String? npcKey,
      String message,
      List<SystemEvent> systemEvents,
      String? thought,
    )?
    chat,
    TResult Function(
      String title,
      String body,
      List<String> tags,
      bool isPinned,
    )?
    memo,
    TResult Function(
      String transactionType,
      int amount,
      String currencyType,
      String reason,
      String? referenceId,
    )?
    transaction,
    required TResult orElse(),
  }) {
    if (transaction != null) {
      return transaction(
        transactionType,
        amount,
        currencyType,
        reason,
        referenceId,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatContent value) chat,
    required TResult Function(MemoContent value) memo,
    required TResult Function(TransactionContent value) transaction,
  }) {
    return transaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatContent value)? chat,
    TResult? Function(MemoContent value)? memo,
    TResult? Function(TransactionContent value)? transaction,
  }) {
    return transaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatContent value)? chat,
    TResult Function(MemoContent value)? memo,
    TResult Function(TransactionContent value)? transaction,
    required TResult orElse(),
  }) {
    if (transaction != null) {
      return transaction(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionContentImplToJson(this);
  }
}

abstract class TransactionContent implements ChronicleContent {
  const factory TransactionContent({
    required final String transactionType,
    required final int amount,
    final String currencyType,
    required final String reason,
    final String? referenceId,
  }) = _$TransactionContentImpl;

  factory TransactionContent.fromJson(Map<String, dynamic> json) =
      _$TransactionContentImpl.fromJson;

  /// Transaction type: 'point_change' | 'item_purchase' | 'quest_reward'
  String get transactionType;

  /// Amount changed (positive or negative)
  int get amount;

  /// Currency or item type
  String get currencyType;

  /// Reason for transaction
  String get reason;

  /// Reference ID (quest, item, etc.)
  String? get referenceId;

  /// Create a copy of ChronicleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionContentImplCopyWith<_$TransactionContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SystemEvent _$SystemEventFromJson(Map<String, dynamic> json) {
  return _SystemEvent.fromJson(json);
}

/// @nodoc
mixin _$SystemEvent {
  /// Event type: 'point_change' | 'update_quest' | 'update_affection' | etc.
  String get type => throw _privateConstructorUsedError;

  /// Event-specific data
  int? get amount => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'quest_id')
  String? get questId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'npc_key')
  String? get npcKey => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;

  /// Generic metadata
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this SystemEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemEventCopyWith<SystemEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemEventCopyWith<$Res> {
  factory $SystemEventCopyWith(
    SystemEvent value,
    $Res Function(SystemEvent) then,
  ) = _$SystemEventCopyWithImpl<$Res, SystemEvent>;
  @useResult
  $Res call({
    String type,
    int? amount,
    String? reason,
    @JsonKey(name: 'quest_id') String? questId,
    String? status,
    @JsonKey(name: 'npc_key') String? npcKey,
    int? value,
    Map<String, dynamic> data,
  });
}

/// @nodoc
class _$SystemEventCopyWithImpl<$Res, $Val extends SystemEvent>
    implements $SystemEventCopyWith<$Res> {
  _$SystemEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = freezed,
    Object? reason = freezed,
    Object? questId = freezed,
    Object? status = freezed,
    Object? npcKey = freezed,
    Object? value = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            questId: freezed == questId
                ? _value.questId
                : questId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            npcKey: freezed == npcKey
                ? _value.npcKey
                : npcKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SystemEventImplCopyWith<$Res>
    implements $SystemEventCopyWith<$Res> {
  factory _$$SystemEventImplCopyWith(
    _$SystemEventImpl value,
    $Res Function(_$SystemEventImpl) then,
  ) = __$$SystemEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    int? amount,
    String? reason,
    @JsonKey(name: 'quest_id') String? questId,
    String? status,
    @JsonKey(name: 'npc_key') String? npcKey,
    int? value,
    Map<String, dynamic> data,
  });
}

/// @nodoc
class __$$SystemEventImplCopyWithImpl<$Res>
    extends _$SystemEventCopyWithImpl<$Res, _$SystemEventImpl>
    implements _$$SystemEventImplCopyWith<$Res> {
  __$$SystemEventImplCopyWithImpl(
    _$SystemEventImpl _value,
    $Res Function(_$SystemEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SystemEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = freezed,
    Object? reason = freezed,
    Object? questId = freezed,
    Object? status = freezed,
    Object? npcKey = freezed,
    Object? value = freezed,
    Object? data = null,
  }) {
    return _then(
      _$SystemEventImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        questId: freezed == questId
            ? _value.questId
            : questId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        npcKey: freezed == npcKey
            ? _value.npcKey
            : npcKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemEventImpl implements _SystemEvent {
  const _$SystemEventImpl({
    required this.type,
    this.amount,
    this.reason,
    @JsonKey(name: 'quest_id') this.questId,
    this.status,
    @JsonKey(name: 'npc_key') this.npcKey,
    this.value,
    final Map<String, dynamic> data = const {},
  }) : _data = data;

  factory _$SystemEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemEventImplFromJson(json);

  /// Event type: 'point_change' | 'update_quest' | 'update_affection' | etc.
  @override
  final String type;

  /// Event-specific data
  @override
  final int? amount;
  @override
  final String? reason;
  @override
  @JsonKey(name: 'quest_id')
  final String? questId;
  @override
  final String? status;
  @override
  @JsonKey(name: 'npc_key')
  final String? npcKey;
  @override
  final int? value;

  /// Generic metadata
  final Map<String, dynamic> _data;

  /// Generic metadata
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'SystemEvent(type: $type, amount: $amount, reason: $reason, questId: $questId, status: $status, npcKey: $npcKey, value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.questId, questId) || other.questId == questId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.npcKey, npcKey) || other.npcKey == npcKey) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    amount,
    reason,
    questId,
    status,
    npcKey,
    value,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of SystemEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemEventImplCopyWith<_$SystemEventImpl> get copyWith =>
      __$$SystemEventImplCopyWithImpl<_$SystemEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemEventImplToJson(this);
  }
}

abstract class _SystemEvent implements SystemEvent {
  const factory _SystemEvent({
    required final String type,
    final int? amount,
    final String? reason,
    @JsonKey(name: 'quest_id') final String? questId,
    final String? status,
    @JsonKey(name: 'npc_key') final String? npcKey,
    final int? value,
    final Map<String, dynamic> data,
  }) = _$SystemEventImpl;

  factory _SystemEvent.fromJson(Map<String, dynamic> json) =
      _$SystemEventImpl.fromJson;

  /// Event type: 'point_change' | 'update_quest' | 'update_affection' | etc.
  @override
  String get type;

  /// Event-specific data
  @override
  int? get amount;
  @override
  String? get reason;
  @override
  @JsonKey(name: 'quest_id')
  String? get questId;
  @override
  String? get status;
  @override
  @JsonKey(name: 'npc_key')
  String? get npcKey;
  @override
  int? get value;

  /// Generic metadata
  @override
  Map<String, dynamic> get data;

  /// Create a copy of SystemEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemEventImplCopyWith<_$SystemEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
