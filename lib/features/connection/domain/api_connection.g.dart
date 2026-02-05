// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiConnectionBaseImpl _$$ApiConnectionBaseImplFromJson(
  Map<String, dynamic> json,
) => _$ApiConnectionBaseImpl(
  name: json['name'] as String,
  serviceType: $enumDecode(_$ApiServiceTypeEnumMap, json['serviceType']),
  baseUrl: json['baseUrl'] as String,
  isActive: json['isActive'] as bool? ?? true,
  defaultModel: json['defaultModel'] as String?,
  systemPrompt: json['systemPrompt'] as String?,
  params: json['params'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  headersTemplate:
      json['headersTemplate'] as Map<String, dynamic>? ??
      const <String, dynamic>{},
  config: json['config'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ApiConnectionBaseImplToJson(
  _$ApiConnectionBaseImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'serviceType': _$ApiServiceTypeEnumMap[instance.serviceType]!,
  'baseUrl': instance.baseUrl,
  'isActive': instance.isActive,
  'defaultModel': instance.defaultModel,
  'systemPrompt': instance.systemPrompt,
  'params': instance.params,
  'headersTemplate': instance.headersTemplate,
  'config': instance.config,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$ApiServiceTypeEnumMap = {
  ApiServiceType.openaiCompat: 'openai_compat',
  ApiServiceType.stt: 'stt',
  ApiServiceType.tts: 'tts',
  ApiServiceType.image: 'image',
  ApiServiceType.custom: 'custom',
};

_$CloudApiConnectionImpl _$$CloudApiConnectionImplFromJson(
  Map<String, dynamic> json,
) => _$CloudApiConnectionImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  base: ApiConnectionBase.fromJson(json['base'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$CloudApiConnectionImplToJson(
  _$CloudApiConnectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'base': instance.base,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

_$LocalApiConnectionImpl _$$LocalApiConnectionImplFromJson(
  Map<String, dynamic> json,
) => _$LocalApiConnectionImpl(
  localId: json['localId'] as String,
  base: ApiConnectionBase.fromJson(json['base'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  copiedFromCloudId: json['copiedFromCloudId'] as String?,
);

Map<String, dynamic> _$$LocalApiConnectionImplToJson(
  _$LocalApiConnectionImpl instance,
) => <String, dynamic>{
  'localId': instance.localId,
  'base': instance.base,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'copiedFromCloudId': instance.copiedFromCloudId,
};
