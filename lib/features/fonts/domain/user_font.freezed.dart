// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_font.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserFont _$UserFontFromJson(Map<String, dynamic> json) {
  return _UserFont.fromJson(json);
}

/// @nodoc
mixin _$UserFont {
  String get id => throw _privateConstructorUsedError;
  UserFontSourceType get sourceType => throw _privateConstructorUsedError;

  /// Display base name (usually filename or user provided)
  String get originalName => throw _privateConstructorUsedError;

  /// Optional user tag, displayed as: tagName（originalName）
  String? get tagName => throw _privateConstructorUsedError;

  /// Remote font direct URL (ttf/otf)
  String? get remoteUrl => throw _privateConstructorUsedError;

  /// Imported local font file path (ttf/otf)
  String? get localPath => throw _privateConstructorUsedError;

  /// Runtime registered family key, e.g. userfont_<id>
  String? get family => throw _privateConstructorUsedError;

  /// File format: ttf | otf
  String? get format => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserFont to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFont
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFontCopyWith<UserFont> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFontCopyWith<$Res> {
  factory $UserFontCopyWith(UserFont value, $Res Function(UserFont) then) =
      _$UserFontCopyWithImpl<$Res, UserFont>;
  @useResult
  $Res call({
    String id,
    UserFontSourceType sourceType,
    String originalName,
    String? tagName,
    String? remoteUrl,
    String? localPath,
    String? family,
    String? format,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserFontCopyWithImpl<$Res, $Val extends UserFont>
    implements $UserFontCopyWith<$Res> {
  _$UserFontCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFont
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceType = null,
    Object? originalName = null,
    Object? tagName = freezed,
    Object? remoteUrl = freezed,
    Object? localPath = freezed,
    Object? family = freezed,
    Object? format = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceType: null == sourceType
                ? _value.sourceType
                : sourceType // ignore: cast_nullable_to_non_nullable
                      as UserFontSourceType,
            originalName: null == originalName
                ? _value.originalName
                : originalName // ignore: cast_nullable_to_non_nullable
                      as String,
            tagName: freezed == tagName
                ? _value.tagName
                : tagName // ignore: cast_nullable_to_non_nullable
                      as String?,
            remoteUrl: freezed == remoteUrl
                ? _value.remoteUrl
                : remoteUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            localPath: freezed == localPath
                ? _value.localPath
                : localPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            family: freezed == family
                ? _value.family
                : family // ignore: cast_nullable_to_non_nullable
                      as String?,
            format: freezed == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
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
}

/// @nodoc
abstract class _$$UserFontImplCopyWith<$Res>
    implements $UserFontCopyWith<$Res> {
  factory _$$UserFontImplCopyWith(
    _$UserFontImpl value,
    $Res Function(_$UserFontImpl) then,
  ) = __$$UserFontImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    UserFontSourceType sourceType,
    String originalName,
    String? tagName,
    String? remoteUrl,
    String? localPath,
    String? family,
    String? format,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserFontImplCopyWithImpl<$Res>
    extends _$UserFontCopyWithImpl<$Res, _$UserFontImpl>
    implements _$$UserFontImplCopyWith<$Res> {
  __$$UserFontImplCopyWithImpl(
    _$UserFontImpl _value,
    $Res Function(_$UserFontImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserFont
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceType = null,
    Object? originalName = null,
    Object? tagName = freezed,
    Object? remoteUrl = freezed,
    Object? localPath = freezed,
    Object? family = freezed,
    Object? format = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserFontImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceType: null == sourceType
            ? _value.sourceType
            : sourceType // ignore: cast_nullable_to_non_nullable
                  as UserFontSourceType,
        originalName: null == originalName
            ? _value.originalName
            : originalName // ignore: cast_nullable_to_non_nullable
                  as String,
        tagName: freezed == tagName
            ? _value.tagName
            : tagName // ignore: cast_nullable_to_non_nullable
                  as String?,
        remoteUrl: freezed == remoteUrl
            ? _value.remoteUrl
            : remoteUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        localPath: freezed == localPath
            ? _value.localPath
            : localPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        family: freezed == family
            ? _value.family
            : family // ignore: cast_nullable_to_non_nullable
                  as String?,
        format: freezed == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
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
class _$UserFontImpl implements _UserFont {
  const _$UserFontImpl({
    required this.id,
    required this.sourceType,
    required this.originalName,
    this.tagName,
    this.remoteUrl,
    this.localPath,
    this.family,
    this.format,
    this.createdAt,
    this.updatedAt,
  });

  factory _$UserFontImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFontImplFromJson(json);

  @override
  final String id;
  @override
  final UserFontSourceType sourceType;

  /// Display base name (usually filename or user provided)
  @override
  final String originalName;

  /// Optional user tag, displayed as: tagName（originalName）
  @override
  final String? tagName;

  /// Remote font direct URL (ttf/otf)
  @override
  final String? remoteUrl;

  /// Imported local font file path (ttf/otf)
  @override
  final String? localPath;

  /// Runtime registered family key, e.g. userfont_<id>
  @override
  final String? family;

  /// File format: ttf | otf
  @override
  final String? format;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserFont(id: $id, sourceType: $sourceType, originalName: $originalName, tagName: $tagName, remoteUrl: $remoteUrl, localPath: $localPath, family: $family, format: $format, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFontImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.tagName, tagName) || other.tagName == tagName) &&
            (identical(other.remoteUrl, remoteUrl) ||
                other.remoteUrl == remoteUrl) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.format, format) || other.format == format) &&
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
    sourceType,
    originalName,
    tagName,
    remoteUrl,
    localPath,
    family,
    format,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserFont
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFontImplCopyWith<_$UserFontImpl> get copyWith =>
      __$$UserFontImplCopyWithImpl<_$UserFontImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFontImplToJson(this);
  }
}

abstract class _UserFont implements UserFont {
  const factory _UserFont({
    required final String id,
    required final UserFontSourceType sourceType,
    required final String originalName,
    final String? tagName,
    final String? remoteUrl,
    final String? localPath,
    final String? family,
    final String? format,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserFontImpl;

  factory _UserFont.fromJson(Map<String, dynamic> json) =
      _$UserFontImpl.fromJson;

  @override
  String get id;
  @override
  UserFontSourceType get sourceType;

  /// Display base name (usually filename or user provided)
  @override
  String get originalName;

  /// Optional user tag, displayed as: tagName（originalName）
  @override
  String? get tagName;

  /// Remote font direct URL (ttf/otf)
  @override
  String? get remoteUrl;

  /// Imported local font file path (ttf/otf)
  @override
  String? get localPath;

  /// Runtime registered family key, e.g. userfont_<id>
  @override
  String? get family;

  /// File format: ttf | otf
  @override
  String? get format;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserFont
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFontImplCopyWith<_$UserFontImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
