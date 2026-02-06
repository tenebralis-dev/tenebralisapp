import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_identity.freezed.dart';
part 'world_identity.g.dart';

@freezed
class WorldIdentity with _$WorldIdentity {
  const factory WorldIdentity({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'world_id') required String worldId,
    @JsonKey(name: 'identity_name') required String identityName,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'prompt_identity_text') String? promptIdentityText,
    @JsonKey(name: 'role_data_json') @Default({}) Map<String, dynamic> roleDataJson,
    @JsonKey(name: 'persona_json') @Default({}) Map<String, dynamic> personaJson,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WorldIdentity;

  factory WorldIdentity.fromJson(Map<String, dynamic> json) =>
      _$WorldIdentityFromJson(json);
}
