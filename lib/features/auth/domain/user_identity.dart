import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_identity.freezed.dart';
part 'user_identity.g.dart';

Map<String, int> _statusBarsFromJson(Object? raw) {
  if (raw == null) return const {};
  if (raw is Map<String, dynamic>) {
    return raw.map((k, v) => MapEntry(k, (v is num) ? v.toInt() : 0));
  }
  if (raw is Map) {
    final map = Map<String, dynamic>.from(raw);
    return map.map((k, v) => MapEntry(k, (v is num) ? v.toInt() : 0));
  }
  return const {};
}

/// Identity (马甲) - stored inside `profiles.current_session` JSON.
@freezed
class UserIdentity with _$UserIdentity {
  const factory UserIdentity({
    /// Current world id.
    @JsonKey(name: 'world_id') String? worldId,

    /// Role name shown in UI.
    @JsonKey(name: 'role_name') @Default('Unknown') String roleName,

    /// Title / epithet.
    @JsonKey(name: 'role_title') @Default('') String roleTitle,

    /// Simple status bars such as HP/MP.
    @JsonKey(name: 'status_bars', fromJson: _statusBarsFromJson)
    @Default({})
    Map<String, int> statusBars,
  }) = _UserIdentity;

  factory UserIdentity.fromJson(Map<String, dynamic> json) =>
      _$UserIdentityFromJson(json);
}
