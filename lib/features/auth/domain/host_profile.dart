import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_identity.dart';

part 'host_profile.freezed.dart';
part 'host_profile.g.dart';

Map<String, dynamic> _mapFromJson(Object? raw) {
  if (raw == null) return const {};
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  return const {};
}

UserIdentity? _identityFromJson(Object? raw) {
  if (raw == null) return null;
  if (raw is Map<String, dynamic>) return UserIdentity.fromJson(raw);
  if (raw is Map) return UserIdentity.fromJson(Map<String, dynamic>.from(raw));
  return null;
}

/// Host profile - maps to Supabase `public.users` table.
///
/// Note: `activeIdentity` is kept as a client-side concept (stored locally),
/// because the new DB baseline no longer stores `current_session` in DB.
@freezed
class HostProfile with _$HostProfile {
  const factory HostProfile({
    required String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? bio,
    @JsonKey(name: 'system_level') @Default(1) int systemLevel,
    @JsonKey(name: 'exp_points') @Default(0) int expPoints,

    /// For backward-compat only: if any old data path still provides identity JSON.
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? legacyCurrentSession,

    /// For backward-compat only: preferences JSON from old profiles table.
    @JsonKey(fromJson: _mapFromJson) @Default({}) Map<String, dynamic> legacyPreferences,
  }) = _HostProfile;

  factory HostProfile.fromJson(Map<String, dynamic> json) =>
      _$HostProfileFromJson(json);
}
