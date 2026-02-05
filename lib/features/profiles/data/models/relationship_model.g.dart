// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationshipModelImpl _$$RelationshipModelImplFromJson(
  Map<String, dynamic> json,
) => _$RelationshipModelImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  worldId: json['world_id'] as String,
  targetType: $enumDecode(_$RelationshipTargetTypeEnumMap, json['target_type']),
  targetKey: json['target_key'] as String,
  value: (json['value'] as num?)?.toInt() ?? 0,
  state: json['state'] as Map<String, dynamic>? ?? const {},
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$RelationshipModelImplToJson(
  _$RelationshipModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'world_id': instance.worldId,
  'target_type': _$RelationshipTargetTypeEnumMap[instance.targetType]!,
  'target_key': instance.targetKey,
  'value': instance.value,
  'state': instance.state,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$RelationshipTargetTypeEnumMap = {
  RelationshipTargetType.npc: 'npc',
  RelationshipTargetType.quest: 'quest',
};

_$QuestStateImpl _$$QuestStateImplFromJson(Map<String, dynamic> json) =>
    _$QuestStateImpl(
      status:
          $enumDecodeNullable(_$QuestStatusEnumMap, json['status']) ??
          QuestStatus.notStarted,
      currentObjective: (json['current_objective'] as num?)?.toInt() ?? 0,
      completedObjectives:
          (json['completed_objectives'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      flags: json['flags'] as Map<String, dynamic>? ?? const {},
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$$QuestStateImplToJson(_$QuestStateImpl instance) =>
    <String, dynamic>{
      'status': _$QuestStatusEnumMap[instance.status]!,
      'current_objective': instance.currentObjective,
      'completed_objectives': instance.completedObjectives,
      'flags': instance.flags,
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
    };

const _$QuestStatusEnumMap = {
  QuestStatus.notStarted: 'not_started',
  QuestStatus.inProgress: 'in_progress',
  QuestStatus.completed: 'completed',
  QuestStatus.failed: 'failed',
};

_$AffectionStateImpl _$$AffectionStateImplFromJson(Map<String, dynamic> json) =>
    _$AffectionStateImpl(
      level: (json['level'] as num?)?.toInt() ?? 0,
      stage: json['stage'] as String? ?? 'stranger',
      unlockedDialogues:
          (json['unlocked_dialogues'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      giftHistory:
          (json['gift_history'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      interactionCount: (json['interaction_count'] as num?)?.toInt() ?? 0,
      lastInteraction: json['last_interaction'] == null
          ? null
          : DateTime.parse(json['last_interaction'] as String),
    );

Map<String, dynamic> _$$AffectionStateImplToJson(
  _$AffectionStateImpl instance,
) => <String, dynamic>{
  'level': instance.level,
  'stage': instance.stage,
  'unlocked_dialogues': instance.unlockedDialogues,
  'gift_history': instance.giftHistory,
  'interaction_count': instance.interactionCount,
  'last_interaction': instance.lastInteraction?.toIso8601String(),
};
