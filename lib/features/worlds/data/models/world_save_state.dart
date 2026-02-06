import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_save_state.freezed.dart';
part 'world_save_state.g.dart';

Map<String, dynamic> _mapFromJson(Object? raw) {
  if (raw == null) return const {};
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  return const {};
}

@freezed
class WorldSaveState with _$WorldSaveState {
  const factory WorldSaveState({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'world_id') required String worldId,
    @JsonKey(name: 'identity_id') required String identityId,
    required int slot,
    String? title,
    String? summary,
    String? chapter,
    String? stage,
    @JsonKey(name: 'prompt_progress_text') String? promptProgressText,
    @JsonKey(name: 'state_json', fromJson: _mapFromJson) @Default({}) Map<String, dynamic> stateJson,
    @JsonKey(name: 'last_played_at') DateTime? lastPlayedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WorldSaveState;

  factory WorldSaveState.fromJson(Map<String, dynamic> json) =>
      _$WorldSaveStateFromJson(json);
}
