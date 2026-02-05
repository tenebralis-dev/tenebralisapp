import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_model.freezed.dart';
part 'world_model.g.dart';

/// World Model
/// Matches the `worlds` table in Supabase
@freezed
class WorldModel with _$WorldModel {
  const factory WorldModel({
    /// UUID primary key
    required String id,

    /// World name
    required String name,

    /// World genre (fantasy, sci-fi, modern, etc.)
    required String genre,

    /// World settings including AI prompts
    WorldSettings? settings,

    /// Initial state when entering the world
    @JsonKey(name: 'initial_state') WorldInitialState? initialState,

    /// World description
    String? description,

    /// Cover image URL
    @JsonKey(name: 'cover_image') String? coverImage,

    /// Whether the world is public
    @JsonKey(name: 'is_public') @Default(false) bool isPublic,

    /// Creator user ID
    @JsonKey(name: 'creator_id') String? creatorId,

    /// Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WorldModel;

  factory WorldModel.fromJson(Map<String, dynamic> json) =>
      _$WorldModelFromJson(json);
}

/// World Settings (stored as JSONB)
/// Contains AI prompts and world configuration
@freezed
class WorldSettings with _$WorldSettings {
  const factory WorldSettings({
    /// System prompt for AI
    @JsonKey(name: 'system_prompt') String? systemPrompt,

    /// World background/lore prompt
    @JsonKey(name: 'world_prompt') String? worldPrompt,

    /// Style instructions for AI responses
    @JsonKey(name: 'style_prompt') String? stylePrompt,

    /// Available NPCs in this world
    @Default([]) List<NpcConfig> npcs,

    /// Available quests in this world
    @Default([]) List<QuestConfig> quests,

    /// World rules and constraints
    @Default([]) List<String> rules,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _WorldSettings;

  factory WorldSettings.fromJson(Map<String, dynamic> json) =>
      _$WorldSettingsFromJson(json);
}

/// NPC Configuration
@freezed
class NpcConfig with _$NpcConfig {
  const factory NpcConfig({
    /// NPC unique key
    required String key,

    /// NPC display name
    required String name,

    /// NPC personality prompt
    String? personality,

    /// NPC avatar URL
    String? avatar,

    /// NPC role/occupation
    String? role,

    /// Initial affection value
    @Default(0) int initialAffection,
  }) = _NpcConfig;

  factory NpcConfig.fromJson(Map<String, dynamic> json) =>
      _$NpcConfigFromJson(json);
}

/// Quest Configuration
@freezed
class QuestConfig with _$QuestConfig {
  const factory QuestConfig({
    /// Quest unique key
    required String key,

    /// Quest title
    required String title,

    /// Quest description
    String? description,

    /// Quest type: 'main' | 'side' | 'daily'
    @Default('side') String type,

    /// Quest objectives
    @Default([]) List<String> objectives,

    /// Rewards for completing the quest
    @Default({}) Map<String, dynamic> rewards,
  }) = _QuestConfig;

  factory QuestConfig.fromJson(Map<String, dynamic> json) =>
      _$QuestConfigFromJson(json);
}

/// World Initial State (stored as JSONB)
@freezed
class WorldInitialState with _$WorldInitialState {
  const factory WorldInitialState({
    /// Starting location/scene
    @JsonKey(name: 'starting_location') String? startingLocation,

    /// Initial narrative text
    @JsonKey(name: 'opening_narrative') String? openingNarrative,

    /// Initial available actions
    @JsonKey(name: 'initial_actions') @Default([]) List<String> initialActions,

    /// Initial flags/variables
    @Default({}) Map<String, dynamic> flags,
  }) = _WorldInitialState;

  factory WorldInitialState.fromJson(Map<String, dynamic> json) =>
      _$WorldInitialStateFromJson(json);
}
