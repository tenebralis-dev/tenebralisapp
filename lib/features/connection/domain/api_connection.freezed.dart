// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiConnectionBase _$ApiConnectionBaseFromJson(Map<String, dynamic> json) {
  return _ApiConnectionBase.fromJson(json);
}

/// @nodoc
mixin _$ApiConnectionBase {
  String get name => throw _privateConstructorUsedError;
  ApiServiceType get serviceType => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get defaultModel => throw _privateConstructorUsedError;
  String? get systemPrompt => throw _privateConstructorUsedError;
  Map<String, dynamic> get params => throw _privateConstructorUsedError;
  Map<String, dynamic> get headersTemplate =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ApiConnectionBase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiConnectionBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiConnectionBaseCopyWith<ApiConnectionBase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiConnectionBaseCopyWith<$Res> {
  factory $ApiConnectionBaseCopyWith(
    ApiConnectionBase value,
    $Res Function(ApiConnectionBase) then,
  ) = _$ApiConnectionBaseCopyWithImpl<$Res, ApiConnectionBase>;
  @useResult
  $Res call({
    String name,
    ApiServiceType serviceType,
    String baseUrl,
    bool isActive,
    String? defaultModel,
    String? systemPrompt,
    Map<String, dynamic> params,
    Map<String, dynamic> headersTemplate,
    Map<String, dynamic> config,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ApiConnectionBaseCopyWithImpl<$Res, $Val extends ApiConnectionBase>
    implements $ApiConnectionBaseCopyWith<$Res> {
  _$ApiConnectionBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiConnectionBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? serviceType = null,
    Object? baseUrl = null,
    Object? isActive = null,
    Object? defaultModel = freezed,
    Object? systemPrompt = freezed,
    Object? params = null,
    Object? headersTemplate = null,
    Object? config = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceType: null == serviceType
                ? _value.serviceType
                : serviceType // ignore: cast_nullable_to_non_nullable
                      as ApiServiceType,
            baseUrl: null == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            defaultModel: freezed == defaultModel
                ? _value.defaultModel
                : defaultModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemPrompt: freezed == systemPrompt
                ? _value.systemPrompt
                : systemPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            params: null == params
                ? _value.params
                : params // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            headersTemplate: null == headersTemplate
                ? _value.headersTemplate
                : headersTemplate // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            config: null == config
                ? _value.config
                : config // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
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
abstract class _$$ApiConnectionBaseImplCopyWith<$Res>
    implements $ApiConnectionBaseCopyWith<$Res> {
  factory _$$ApiConnectionBaseImplCopyWith(
    _$ApiConnectionBaseImpl value,
    $Res Function(_$ApiConnectionBaseImpl) then,
  ) = __$$ApiConnectionBaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    ApiServiceType serviceType,
    String baseUrl,
    bool isActive,
    String? defaultModel,
    String? systemPrompt,
    Map<String, dynamic> params,
    Map<String, dynamic> headersTemplate,
    Map<String, dynamic> config,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ApiConnectionBaseImplCopyWithImpl<$Res>
    extends _$ApiConnectionBaseCopyWithImpl<$Res, _$ApiConnectionBaseImpl>
    implements _$$ApiConnectionBaseImplCopyWith<$Res> {
  __$$ApiConnectionBaseImplCopyWithImpl(
    _$ApiConnectionBaseImpl _value,
    $Res Function(_$ApiConnectionBaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiConnectionBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? serviceType = null,
    Object? baseUrl = null,
    Object? isActive = null,
    Object? defaultModel = freezed,
    Object? systemPrompt = freezed,
    Object? params = null,
    Object? headersTemplate = null,
    Object? config = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ApiConnectionBaseImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceType: null == serviceType
            ? _value.serviceType
            : serviceType // ignore: cast_nullable_to_non_nullable
                  as ApiServiceType,
        baseUrl: null == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        defaultModel: freezed == defaultModel
            ? _value.defaultModel
            : defaultModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemPrompt: freezed == systemPrompt
            ? _value.systemPrompt
            : systemPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        params: null == params
            ? _value._params
            : params // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        headersTemplate: null == headersTemplate
            ? _value._headersTemplate
            : headersTemplate // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        config: null == config
            ? _value._config
            : config // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
class _$ApiConnectionBaseImpl implements _ApiConnectionBase {
  const _$ApiConnectionBaseImpl({
    required this.name,
    required this.serviceType,
    required this.baseUrl,
    this.isActive = true,
    this.defaultModel,
    this.systemPrompt,
    final Map<String, dynamic> params = const <String, dynamic>{},
    final Map<String, dynamic> headersTemplate = const <String, dynamic>{},
    final Map<String, dynamic> config = const <String, dynamic>{},
    this.updatedAt,
  }) : _params = params,
       _headersTemplate = headersTemplate,
       _config = config;

  factory _$ApiConnectionBaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiConnectionBaseImplFromJson(json);

  @override
  final String name;
  @override
  final ApiServiceType serviceType;
  @override
  final String baseUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? defaultModel;
  @override
  final String? systemPrompt;
  final Map<String, dynamic> _params;
  @override
  @JsonKey()
  Map<String, dynamic> get params {
    if (_params is EqualUnmodifiableMapView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_params);
  }

  final Map<String, dynamic> _headersTemplate;
  @override
  @JsonKey()
  Map<String, dynamic> get headersTemplate {
    if (_headersTemplate is EqualUnmodifiableMapView) return _headersTemplate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headersTemplate);
  }

  final Map<String, dynamic> _config;
  @override
  @JsonKey()
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ApiConnectionBase(name: $name, serviceType: $serviceType, baseUrl: $baseUrl, isActive: $isActive, defaultModel: $defaultModel, systemPrompt: $systemPrompt, params: $params, headersTemplate: $headersTemplate, config: $config, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiConnectionBaseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.defaultModel, defaultModel) ||
                other.defaultModel == defaultModel) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            const DeepCollectionEquality().equals(other._params, _params) &&
            const DeepCollectionEquality().equals(
              other._headersTemplate,
              _headersTemplate,
            ) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    serviceType,
    baseUrl,
    isActive,
    defaultModel,
    systemPrompt,
    const DeepCollectionEquality().hash(_params),
    const DeepCollectionEquality().hash(_headersTemplate),
    const DeepCollectionEquality().hash(_config),
    updatedAt,
  );

  /// Create a copy of ApiConnectionBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiConnectionBaseImplCopyWith<_$ApiConnectionBaseImpl> get copyWith =>
      __$$ApiConnectionBaseImplCopyWithImpl<_$ApiConnectionBaseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiConnectionBaseImplToJson(this);
  }
}

abstract class _ApiConnectionBase implements ApiConnectionBase {
  const factory _ApiConnectionBase({
    required final String name,
    required final ApiServiceType serviceType,
    required final String baseUrl,
    final bool isActive,
    final String? defaultModel,
    final String? systemPrompt,
    final Map<String, dynamic> params,
    final Map<String, dynamic> headersTemplate,
    final Map<String, dynamic> config,
    final DateTime? updatedAt,
  }) = _$ApiConnectionBaseImpl;

  factory _ApiConnectionBase.fromJson(Map<String, dynamic> json) =
      _$ApiConnectionBaseImpl.fromJson;

  @override
  String get name;
  @override
  ApiServiceType get serviceType;
  @override
  String get baseUrl;
  @override
  bool get isActive;
  @override
  String? get defaultModel;
  @override
  String? get systemPrompt;
  @override
  Map<String, dynamic> get params;
  @override
  Map<String, dynamic> get headersTemplate;
  @override
  Map<String, dynamic> get config;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ApiConnectionBase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiConnectionBaseImplCopyWith<_$ApiConnectionBaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CloudApiConnection _$CloudApiConnectionFromJson(Map<String, dynamic> json) {
  return _CloudApiConnection.fromJson(json);
}

/// @nodoc
mixin _$CloudApiConnection {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  ApiConnectionBase get base => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CloudApiConnection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudApiConnectionCopyWith<CloudApiConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudApiConnectionCopyWith<$Res> {
  factory $CloudApiConnectionCopyWith(
    CloudApiConnection value,
    $Res Function(CloudApiConnection) then,
  ) = _$CloudApiConnectionCopyWithImpl<$Res, CloudApiConnection>;
  @useResult
  $Res call({
    String id,
    String userId,
    ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $ApiConnectionBaseCopyWith<$Res> get base;
}

/// @nodoc
class _$CloudApiConnectionCopyWithImpl<$Res, $Val extends CloudApiConnection>
    implements $CloudApiConnectionCopyWith<$Res> {
  _$CloudApiConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? base = null,
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
            base: null == base
                ? _value.base
                : base // ignore: cast_nullable_to_non_nullable
                      as ApiConnectionBase,
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

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiConnectionBaseCopyWith<$Res> get base {
    return $ApiConnectionBaseCopyWith<$Res>(_value.base, (value) {
      return _then(_value.copyWith(base: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CloudApiConnectionImplCopyWith<$Res>
    implements $CloudApiConnectionCopyWith<$Res> {
  factory _$$CloudApiConnectionImplCopyWith(
    _$CloudApiConnectionImpl value,
    $Res Function(_$CloudApiConnectionImpl) then,
  ) = __$$CloudApiConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $ApiConnectionBaseCopyWith<$Res> get base;
}

/// @nodoc
class __$$CloudApiConnectionImplCopyWithImpl<$Res>
    extends _$CloudApiConnectionCopyWithImpl<$Res, _$CloudApiConnectionImpl>
    implements _$$CloudApiConnectionImplCopyWith<$Res> {
  __$$CloudApiConnectionImplCopyWithImpl(
    _$CloudApiConnectionImpl _value,
    $Res Function(_$CloudApiConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? base = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$CloudApiConnectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        base: null == base
            ? _value.base
            : base // ignore: cast_nullable_to_non_nullable
                  as ApiConnectionBase,
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
class _$CloudApiConnectionImpl implements _CloudApiConnection {
  const _$CloudApiConnectionImpl({
    required this.id,
    required this.userId,
    required this.base,
    this.createdAt,
    this.updatedAt,
  });

  factory _$CloudApiConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloudApiConnectionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final ApiConnectionBase base;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CloudApiConnection(id: $id, userId: $userId, base: $base, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloudApiConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, base, createdAt, updatedAt);

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloudApiConnectionImplCopyWith<_$CloudApiConnectionImpl> get copyWith =>
      __$$CloudApiConnectionImplCopyWithImpl<_$CloudApiConnectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CloudApiConnectionImplToJson(this);
  }
}

abstract class _CloudApiConnection implements CloudApiConnection {
  const factory _CloudApiConnection({
    required final String id,
    required final String userId,
    required final ApiConnectionBase base,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$CloudApiConnectionImpl;

  factory _CloudApiConnection.fromJson(Map<String, dynamic> json) =
      _$CloudApiConnectionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  ApiConnectionBase get base;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of CloudApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloudApiConnectionImplCopyWith<_$CloudApiConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocalApiConnection _$LocalApiConnectionFromJson(Map<String, dynamic> json) {
  return _LocalApiConnection.fromJson(json);
}

/// @nodoc
mixin _$LocalApiConnection {
  String get localId => throw _privateConstructorUsedError;
  ApiConnectionBase get base => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Optional: track provenance for UI hints.
  String? get copiedFromCloudId => throw _privateConstructorUsedError;

  /// Serializes this LocalApiConnection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalApiConnectionCopyWith<LocalApiConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalApiConnectionCopyWith<$Res> {
  factory $LocalApiConnectionCopyWith(
    LocalApiConnection value,
    $Res Function(LocalApiConnection) then,
  ) = _$LocalApiConnectionCopyWithImpl<$Res, LocalApiConnection>;
  @useResult
  $Res call({
    String localId,
    ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? copiedFromCloudId,
  });

  $ApiConnectionBaseCopyWith<$Res> get base;
}

/// @nodoc
class _$LocalApiConnectionCopyWithImpl<$Res, $Val extends LocalApiConnection>
    implements $LocalApiConnectionCopyWith<$Res> {
  _$LocalApiConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? base = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? copiedFromCloudId = freezed,
  }) {
    return _then(
      _value.copyWith(
            localId: null == localId
                ? _value.localId
                : localId // ignore: cast_nullable_to_non_nullable
                      as String,
            base: null == base
                ? _value.base
                : base // ignore: cast_nullable_to_non_nullable
                      as ApiConnectionBase,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            copiedFromCloudId: freezed == copiedFromCloudId
                ? _value.copiedFromCloudId
                : copiedFromCloudId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiConnectionBaseCopyWith<$Res> get base {
    return $ApiConnectionBaseCopyWith<$Res>(_value.base, (value) {
      return _then(_value.copyWith(base: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocalApiConnectionImplCopyWith<$Res>
    implements $LocalApiConnectionCopyWith<$Res> {
  factory _$$LocalApiConnectionImplCopyWith(
    _$LocalApiConnectionImpl value,
    $Res Function(_$LocalApiConnectionImpl) then,
  ) = __$$LocalApiConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String localId,
    ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? copiedFromCloudId,
  });

  @override
  $ApiConnectionBaseCopyWith<$Res> get base;
}

/// @nodoc
class __$$LocalApiConnectionImplCopyWithImpl<$Res>
    extends _$LocalApiConnectionCopyWithImpl<$Res, _$LocalApiConnectionImpl>
    implements _$$LocalApiConnectionImplCopyWith<$Res> {
  __$$LocalApiConnectionImplCopyWithImpl(
    _$LocalApiConnectionImpl _value,
    $Res Function(_$LocalApiConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? base = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? copiedFromCloudId = freezed,
  }) {
    return _then(
      _$LocalApiConnectionImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                  as String,
        base: null == base
            ? _value.base
            : base // ignore: cast_nullable_to_non_nullable
                  as ApiConnectionBase,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        copiedFromCloudId: freezed == copiedFromCloudId
            ? _value.copiedFromCloudId
            : copiedFromCloudId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalApiConnectionImpl implements _LocalApiConnection {
  const _$LocalApiConnectionImpl({
    required this.localId,
    required this.base,
    this.createdAt,
    this.updatedAt,
    this.copiedFromCloudId,
  });

  factory _$LocalApiConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalApiConnectionImplFromJson(json);

  @override
  final String localId;
  @override
  final ApiConnectionBase base;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Optional: track provenance for UI hints.
  @override
  final String? copiedFromCloudId;

  @override
  String toString() {
    return 'LocalApiConnection(localId: $localId, base: $base, createdAt: $createdAt, updatedAt: $updatedAt, copiedFromCloudId: $copiedFromCloudId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalApiConnectionImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.copiedFromCloudId, copiedFromCloudId) ||
                other.copiedFromCloudId == copiedFromCloudId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    localId,
    base,
    createdAt,
    updatedAt,
    copiedFromCloudId,
  );

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalApiConnectionImplCopyWith<_$LocalApiConnectionImpl> get copyWith =>
      __$$LocalApiConnectionImplCopyWithImpl<_$LocalApiConnectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalApiConnectionImplToJson(this);
  }
}

abstract class _LocalApiConnection implements LocalApiConnection {
  const factory _LocalApiConnection({
    required final String localId,
    required final ApiConnectionBase base,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? copiedFromCloudId,
  }) = _$LocalApiConnectionImpl;

  factory _LocalApiConnection.fromJson(Map<String, dynamic> json) =
      _$LocalApiConnectionImpl.fromJson;

  @override
  String get localId;
  @override
  ApiConnectionBase get base;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Optional: track provenance for UI hints.
  @override
  String? get copiedFromCloudId;

  /// Create a copy of LocalApiConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalApiConnectionImplCopyWith<_$LocalApiConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConnectionListItem {
  Object get connection => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CloudApiConnection connection) cloud,
    required TResult Function(LocalApiConnection connection) local,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CloudApiConnection connection)? cloud,
    TResult? Function(LocalApiConnection connection)? local,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CloudApiConnection connection)? cloud,
    TResult Function(LocalApiConnection connection)? local,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionListItemCloud value) cloud,
    required TResult Function(_ConnectionListItemLocal value) local,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionListItemCloud value)? cloud,
    TResult? Function(_ConnectionListItemLocal value)? local,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionListItemCloud value)? cloud,
    TResult Function(_ConnectionListItemLocal value)? local,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionListItemCopyWith<$Res> {
  factory $ConnectionListItemCopyWith(
    ConnectionListItem value,
    $Res Function(ConnectionListItem) then,
  ) = _$ConnectionListItemCopyWithImpl<$Res, ConnectionListItem>;
}

/// @nodoc
class _$ConnectionListItemCopyWithImpl<$Res, $Val extends ConnectionListItem>
    implements $ConnectionListItemCopyWith<$Res> {
  _$ConnectionListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectionListItemCloudImplCopyWith<$Res> {
  factory _$$ConnectionListItemCloudImplCopyWith(
    _$ConnectionListItemCloudImpl value,
    $Res Function(_$ConnectionListItemCloudImpl) then,
  ) = __$$ConnectionListItemCloudImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CloudApiConnection connection});

  $CloudApiConnectionCopyWith<$Res> get connection;
}

/// @nodoc
class __$$ConnectionListItemCloudImplCopyWithImpl<$Res>
    extends
        _$ConnectionListItemCopyWithImpl<$Res, _$ConnectionListItemCloudImpl>
    implements _$$ConnectionListItemCloudImplCopyWith<$Res> {
  __$$ConnectionListItemCloudImplCopyWithImpl(
    _$ConnectionListItemCloudImpl _value,
    $Res Function(_$ConnectionListItemCloudImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? connection = null}) {
    return _then(
      _$ConnectionListItemCloudImpl(
        connection: null == connection
            ? _value.connection
            : connection // ignore: cast_nullable_to_non_nullable
                  as CloudApiConnection,
      ),
    );
  }

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CloudApiConnectionCopyWith<$Res> get connection {
    return $CloudApiConnectionCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }
}

/// @nodoc

class _$ConnectionListItemCloudImpl implements _ConnectionListItemCloud {
  const _$ConnectionListItemCloudImpl({required this.connection});

  @override
  final CloudApiConnection connection;

  @override
  String toString() {
    return 'ConnectionListItem.cloud(connection: $connection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionListItemCloudImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection);

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionListItemCloudImplCopyWith<_$ConnectionListItemCloudImpl>
  get copyWith =>
      __$$ConnectionListItemCloudImplCopyWithImpl<
        _$ConnectionListItemCloudImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CloudApiConnection connection) cloud,
    required TResult Function(LocalApiConnection connection) local,
  }) {
    return cloud(connection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CloudApiConnection connection)? cloud,
    TResult? Function(LocalApiConnection connection)? local,
  }) {
    return cloud?.call(connection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CloudApiConnection connection)? cloud,
    TResult Function(LocalApiConnection connection)? local,
    required TResult orElse(),
  }) {
    if (cloud != null) {
      return cloud(connection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionListItemCloud value) cloud,
    required TResult Function(_ConnectionListItemLocal value) local,
  }) {
    return cloud(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionListItemCloud value)? cloud,
    TResult? Function(_ConnectionListItemLocal value)? local,
  }) {
    return cloud?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionListItemCloud value)? cloud,
    TResult Function(_ConnectionListItemLocal value)? local,
    required TResult orElse(),
  }) {
    if (cloud != null) {
      return cloud(this);
    }
    return orElse();
  }
}

abstract class _ConnectionListItemCloud implements ConnectionListItem {
  const factory _ConnectionListItemCloud({
    required final CloudApiConnection connection,
  }) = _$ConnectionListItemCloudImpl;

  @override
  CloudApiConnection get connection;

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionListItemCloudImplCopyWith<_$ConnectionListItemCloudImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionListItemLocalImplCopyWith<$Res> {
  factory _$$ConnectionListItemLocalImplCopyWith(
    _$ConnectionListItemLocalImpl value,
    $Res Function(_$ConnectionListItemLocalImpl) then,
  ) = __$$ConnectionListItemLocalImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocalApiConnection connection});

  $LocalApiConnectionCopyWith<$Res> get connection;
}

/// @nodoc
class __$$ConnectionListItemLocalImplCopyWithImpl<$Res>
    extends
        _$ConnectionListItemCopyWithImpl<$Res, _$ConnectionListItemLocalImpl>
    implements _$$ConnectionListItemLocalImplCopyWith<$Res> {
  __$$ConnectionListItemLocalImplCopyWithImpl(
    _$ConnectionListItemLocalImpl _value,
    $Res Function(_$ConnectionListItemLocalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? connection = null}) {
    return _then(
      _$ConnectionListItemLocalImpl(
        connection: null == connection
            ? _value.connection
            : connection // ignore: cast_nullable_to_non_nullable
                  as LocalApiConnection,
      ),
    );
  }

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalApiConnectionCopyWith<$Res> get connection {
    return $LocalApiConnectionCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }
}

/// @nodoc

class _$ConnectionListItemLocalImpl implements _ConnectionListItemLocal {
  const _$ConnectionListItemLocalImpl({required this.connection});

  @override
  final LocalApiConnection connection;

  @override
  String toString() {
    return 'ConnectionListItem.local(connection: $connection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionListItemLocalImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection);

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionListItemLocalImplCopyWith<_$ConnectionListItemLocalImpl>
  get copyWith =>
      __$$ConnectionListItemLocalImplCopyWithImpl<
        _$ConnectionListItemLocalImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CloudApiConnection connection) cloud,
    required TResult Function(LocalApiConnection connection) local,
  }) {
    return local(connection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CloudApiConnection connection)? cloud,
    TResult? Function(LocalApiConnection connection)? local,
  }) {
    return local?.call(connection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CloudApiConnection connection)? cloud,
    TResult Function(LocalApiConnection connection)? local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(connection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionListItemCloud value) cloud,
    required TResult Function(_ConnectionListItemLocal value) local,
  }) {
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionListItemCloud value)? cloud,
    TResult? Function(_ConnectionListItemLocal value)? local,
  }) {
    return local?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionListItemCloud value)? cloud,
    TResult Function(_ConnectionListItemLocal value)? local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(this);
    }
    return orElse();
  }
}

abstract class _ConnectionListItemLocal implements ConnectionListItem {
  const factory _ConnectionListItemLocal({
    required final LocalApiConnection connection,
  }) = _$ConnectionListItemLocalImpl;

  @override
  LocalApiConnection get connection;

  /// Create a copy of ConnectionListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionListItemLocalImplCopyWith<_$ConnectionListItemLocalImpl>
  get copyWith => throw _privateConstructorUsedError;
}
