// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldIdentityImpl _$$WorldIdentityImplFromJson(Map<String, dynamic> json) =>
    _$WorldIdentityImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      worldId: json['world_id'] as String,
      identityName: json['identity_name'] as String,
      isActive: json['is_active'] as bool? ?? true,
      promptIdentityText: json['prompt_identity_text'] as String?,
      roleDataJson: json['role_data_json'] as Map<String, dynamic>? ?? const {},
      personaJson: json['persona_json'] as Map<String, dynamic>? ?? const {},
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$WorldIdentityImplToJson(_$WorldIdentityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'world_id': instance.worldId,
      'identity_name': instance.identityName,
      'is_active': instance.isActive,
      'prompt_identity_text': instance.promptIdentityText,
      'role_data_json': instance.roleDataJson,
      'persona_json': instance.personaJson,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
