import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_model.freezed.dart';
part 'relationship_model.g.dart';

/// Relationship Target Type Enum
enum RelationshipTargetType {
  @JsonValue('npc')
  npc,
  @JsonValue('quest')
  quest,
}

/// Relationship Model
/// Matches the `relationships` table in Supabase
/// Tracks NPC affection levels and quest progress
@freezed
class RelationshipModel with _$RelationshipModel {
  const factory RelationshipModel({
    /// UUID primary key
    required String id,

    /// User ID (foreign key to profiles)
    @JsonKey(name: 'user_id') required String userId,

    /// World ID (foreign key to worlds)
    @JsonKey(name: 'world_id') required String worldId,

    /// Target type: 'npc' | 'quest'
    @JsonKey(name: 'target_type') required RelationshipTargetType targetType,

    /// Target key (NPC key or quest key)
    @JsonKey(name: 'target_key') required String targetKey,

    /// Relationship value (affection level or quest progress)
    @Default(0) int value,

    /// Additional state data
    @Default({}) Map<String, dynamic> state,

    /// Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _RelationshipModel;

  factory RelationshipModel.fromJson(Map<String, dynamic> json) =>
      _$RelationshipModelFromJson(json);
}

/// Quest Status Enum
enum QuestStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

/// Extended Quest State (stored in relationship.state)
@freezed
class QuestState with _$QuestState {
  const factory QuestState({
    /// Current quest status
    @Default(QuestStatus.notStarted) QuestStatus status,

    /// Current objective index
    @JsonKey(name: 'current_objective') @Default(0) int currentObjective,

    /// Completed objectives
    @JsonKey(name: 'completed_objectives')
    @Default([])
    List<int> completedObjectives,

    /// Quest-specific flags
    @Default({}) Map<String, dynamic> flags,

    /// Started timestamp
    @JsonKey(name: 'started_at') DateTime? startedAt,

    /// Completed timestamp
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _QuestState;

  factory QuestState.fromJson(Map<String, dynamic> json) =>
      _$QuestStateFromJson(json);
}

/// Extended NPC Affection State (stored in relationship.state)
@freezed
class AffectionState with _$AffectionState {
  const factory AffectionState({
    /// Affection level (0-100)
    @Default(0) int level,

    /// Relationship stage: 'stranger' | 'acquaintance' | 'friend' | 'close' | 'intimate'
    @Default('stranger') String stage,

    /// Unlocked dialogue options
    @JsonKey(name: 'unlocked_dialogues') @Default([]) List<String> unlockedDialogues,

    /// Gift history
    @JsonKey(name: 'gift_history') @Default([]) List<String> giftHistory,

    /// Interaction count
    @JsonKey(name: 'interaction_count') @Default(0) int interactionCount,

    /// Last interaction timestamp
    @JsonKey(name: 'last_interaction') DateTime? lastInteraction,
  }) = _AffectionState;

  factory AffectionState.fromJson(Map<String, dynamic> json) =>
      _$AffectionStateFromJson(json);
}
