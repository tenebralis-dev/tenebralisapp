// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorldModelImpl _$$WorldModelImplFromJson(Map<String, dynamic> json) =>
    _$WorldModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      genre: json['genre'] as String,
      settings: json['settings'] == null
          ? null
          : WorldSettings.fromJson(json['settings'] as Map<String, dynamic>),
      initialState: json['initial_state'] == null
          ? null
          : WorldInitialState.fromJson(
              json['initial_state'] as Map<String, dynamic>,
            ),
      description: json['description'] as String?,
      coverImage: json['cover_image'] as String?,
      isPublic: json['is_public'] as bool? ?? false,
      creatorId: json['creator_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$WorldModelImplToJson(_$WorldModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genre': instance.genre,
      'settings': instance.settings,
      'initial_state': instance.initialState,
      'description': instance.description,
      'cover_image': instance.coverImage,
      'is_public': instance.isPublic,
      'creator_id': instance.creatorId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$WorldSettingsImpl _$$WorldSettingsImplFromJson(Map<String, dynamic> json) =>
    _$WorldSettingsImpl(
      systemPrompt: json['system_prompt'] as String?,
      worldPrompt: json['world_prompt'] as String?,
      stylePrompt: json['style_prompt'] as String?,
      npcs:
          (json['npcs'] as List<dynamic>?)
              ?.map((e) => NpcConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      quests:
          (json['quests'] as List<dynamic>?)
              ?.map((e) => QuestConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rules:
          (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$WorldSettingsImplToJson(_$WorldSettingsImpl instance) =>
    <String, dynamic>{
      'system_prompt': instance.systemPrompt,
      'world_prompt': instance.worldPrompt,
      'style_prompt': instance.stylePrompt,
      'npcs': instance.npcs,
      'quests': instance.quests,
      'rules': instance.rules,
      'metadata': instance.metadata,
    };

_$NpcConfigImpl _$$NpcConfigImplFromJson(Map<String, dynamic> json) =>
    _$NpcConfigImpl(
      key: json['key'] as String,
      name: json['name'] as String,
      personality: json['personality'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      initialAffection: (json['initialAffection'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$NpcConfigImplToJson(_$NpcConfigImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'personality': instance.personality,
      'avatar': instance.avatar,
      'role': instance.role,
      'initialAffection': instance.initialAffection,
    };

_$QuestConfigImpl _$$QuestConfigImplFromJson(Map<String, dynamic> json) =>
    _$QuestConfigImpl(
      key: json['key'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'side',
      objectives:
          (json['objectives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rewards: json['rewards'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$QuestConfigImplToJson(_$QuestConfigImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'objectives': instance.objectives,
      'rewards': instance.rewards,
    };

_$WorldInitialStateImpl _$$WorldInitialStateImplFromJson(
  Map<String, dynamic> json,
) => _$WorldInitialStateImpl(
  startingLocation: json['starting_location'] as String?,
  openingNarrative: json['opening_narrative'] as String?,
  initialActions:
      (json['initial_actions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  flags: json['flags'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$WorldInitialStateImplToJson(
  _$WorldInitialStateImpl instance,
) => <String, dynamic>{
  'starting_location': instance.startingLocation,
  'opening_narrative': instance.openingNarrative,
  'initial_actions': instance.initialActions,
  'flags': instance.flags,
};
