import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_identity.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

Map<String, dynamic> _mapFromJson(Object? raw) {
  if (raw == null) return const {};
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  return const {};
}

List<dynamic> _listFromJson(Object? raw) {
  if (raw == null) return const [];
  if (raw is List) return raw;
  return const [];
}

UserIdentity? _identityFromJson(Object? raw) {
  if (raw == null) return null;
  if (raw is Map<String, dynamic>) return UserIdentity.fromJson(raw);
  if (raw is Map) return UserIdentity.fromJson(Map<String, dynamic>.from(raw));
  return null;
}

/// Profile (宿主) - maps to Supabase `profiles` table.
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'global_points') @Default(0) int globalPoints,

    /// Arbitrary preferences JSON.
    @JsonKey(fromJson: _mapFromJson) @Default({}) Map<String, dynamic> preferences,

    /// Inventory JSON object.
    @JsonKey(fromJson: _mapFromJson) @Default({}) Map<String, dynamic> inventory,

    /// Identity stored in `profiles.current_session`.
    @JsonKey(name: 'current_session', fromJson: _identityFromJson)
    UserIdentity? currentSession,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
