import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// public.users 对应的用户档案模型。
///
/// 注意：这里的 `id` 必须等于 `auth.users.id`。
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'system_level') int? systemLevel,
    @JsonKey(name: 'exp_points') int? expPoints,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
