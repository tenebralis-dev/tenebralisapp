// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_save_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldSaveStateImpl _$$WorldSaveStateImplFromJson(Map<String, dynamic> json) =>
    _$WorldSaveStateImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      worldId: json['world_id'] as String,
      identityId: json['identity_id'] as String,
      slot: (json['slot'] as num).toInt(),
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      chapter: json['chapter'] as String?,
      stage: json['stage'] as String?,
      promptProgressText: json['prompt_progress_text'] as String?,
      stateJson: json['state_json'] == null
          ? const {}
          : _mapFromJson(json['state_json']),
      lastPlayedAt: json['last_played_at'] == null
          ? null
          : DateTime.parse(json['last_played_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$WorldSaveStateImplToJson(
  _$WorldSaveStateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'world_id': instance.worldId,
  'identity_id': instance.identityId,
  'slot': instance.slot,
  'title': instance.title,
  'summary': instance.summary,
  'chapter': instance.chapter,
  'stage': instance.stage,
  'prompt_progress_text': instance.promptProgressText,
  'state_json': instance.stateJson,
  'last_played_at': instance.lastPlayedAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
