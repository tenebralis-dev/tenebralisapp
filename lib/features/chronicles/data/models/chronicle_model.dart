import 'package:freezed_annotation/freezed_annotation.dart';

part 'chronicle_model.freezed.dart';
part 'chronicle_model.g.dart';

/// Chronicle Type Enum
enum ChronicleType {
  @JsonValue('chat')
  chat,
  @JsonValue('memo')
  memo,
  @JsonValue('transaction')
  transaction,
}

/// Chronicle Model
/// Matches the `chronicles` table in Supabase
/// Represents timeline entries (chat logs, memos, transactions)
@freezed
class ChronicleModel with _$ChronicleModel {
  const factory ChronicleModel({
    /// UUID primary key
    required String id,

    /// User ID (foreign key to profiles)
    @JsonKey(name: 'user_id') required String userId,

    /// World ID (nullable - some chronicles are global)
    @JsonKey(name: 'world_id') String? worldId,

    /// Chronicle type: 'chat' | 'memo' | 'transaction'
    required ChronicleType type,

    /// Content varies by type
    required ChronicleContent content,

    /// Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ChronicleModel;

  factory ChronicleModel.fromJson(Map<String, dynamic> json) =>
      _$ChronicleModelFromJson(json);
}

/// Chronicle Content (stored as JSONB)
/// Structure varies based on chronicle type
@freezed
class ChronicleContent with _$ChronicleContent {
  /// Chat message content
  const factory ChronicleContent.chat({
    /// Message sender: 'user' | 'npc' | 'system'
    required String sender,

    /// NPC key if sender is NPC
    String? npcKey,

    /// Message text
    required String message,

    /// System events triggered by this message
    @Default([]) List<SystemEvent> systemEvents,

    /// AI thought process (hidden from user)
    String? thought,
  }) = ChatContent;

  /// Memo/note content
  const factory ChronicleContent.memo({
    /// Memo title
    required String title,

    /// Memo body text
    required String body,

    /// Tags for categorization
    @Default([]) List<String> tags,

    /// Is pinned
    @Default(false) bool isPinned,
  }) = MemoContent;

  /// Transaction content (point changes, item purchases, etc.)
  const factory ChronicleContent.transaction({
    /// Transaction type: 'point_change' | 'item_purchase' | 'quest_reward'
    required String transactionType,

    /// Amount changed (positive or negative)
    required int amount,

    /// Currency or item type
    @Default('points') String currencyType,

    /// Reason for transaction
    required String reason,

    /// Reference ID (quest, item, etc.)
    String? referenceId,
  }) = TransactionContent;

  factory ChronicleContent.fromJson(Map<String, dynamic> json) =>
      _$ChronicleContentFromJson(json);
}

/// System Event from AI Response
/// Matches the JSON contract in PRD Rule 2
@freezed
class SystemEvent with _$SystemEvent {
  const factory SystemEvent({
    /// Event type: 'point_change' | 'update_quest' | 'update_affection' | etc.
    required String type,

    /// Event-specific data
    int? amount,
    String? reason,
    @JsonKey(name: 'quest_id') String? questId,
    String? status,
    @JsonKey(name: 'npc_key') String? npcKey,
    int? value,

    /// Generic metadata
    @Default({}) Map<String, dynamic> data,
  }) = _SystemEvent;

  factory SystemEvent.fromJson(Map<String, dynamic> json) =>
      _$SystemEventFromJson(json);
}
