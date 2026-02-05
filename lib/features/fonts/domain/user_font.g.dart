// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_font.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserFontImpl _$$UserFontImplFromJson(Map<String, dynamic> json) =>
    _$UserFontImpl(
      id: json['id'] as String,
      sourceType: $enumDecode(_$UserFontSourceTypeEnumMap, json['sourceType']),
      originalName: json['originalName'] as String,
      tagName: json['tagName'] as String?,
      remoteUrl: json['remoteUrl'] as String?,
      localPath: json['localPath'] as String?,
      family: json['family'] as String?,
      format: json['format'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserFontImplToJson(_$UserFontImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceType': _$UserFontSourceTypeEnumMap[instance.sourceType]!,
      'originalName': instance.originalName,
      'tagName': instance.tagName,
      'remoteUrl': instance.remoteUrl,
      'localPath': instance.localPath,
      'family': instance.family,
      'format': instance.format,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UserFontSourceTypeEnumMap = {
  UserFontSourceType.builtIn: 'builtIn',
  UserFontSourceType.remoteUrl: 'remoteUrl',
  UserFontSourceType.localFile: 'localFile',
};
