import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

Map<String, dynamic> _mapFromJson(Object? raw) {
  if (raw == null) return const {};
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  return const {};
}

/// User settings - maps to Supabase `public.user_settings`.
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'ui_config', fromJson: _mapFromJson) @Default({}) Map<String, dynamic> uiConfig,
    @JsonKey(name: 'system_preferences', fromJson: _mapFromJson)
    @Default({})
    Map<String, dynamic> systemPreferences,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
