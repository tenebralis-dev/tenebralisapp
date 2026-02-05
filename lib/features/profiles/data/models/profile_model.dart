import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

UserPreferences? _userPreferencesFromJson(Object? raw) {
  if (raw == null) return null;

  if (raw is Map<String, dynamic>) {
    return UserPreferences.fromJson(raw);
  }

  if (raw is Map) {
    return UserPreferences.fromJson(Map<String, dynamic>.from(raw));
  }

  // Defensive: some backends/migrations could accidentally store preferences as a list.
  // In that case, treat it as "no preferences" to avoid crashing the whole settings UI.
  return null;
}

UserInventory? _userInventoryFromJson(Object? raw) {
  if (raw == null) return null;

  if (raw is Map<String, dynamic>) {
    return UserInventory.fromJson(raw);
  }

  if (raw is Map) {
    return UserInventory.fromJson(Map<String, dynamic>.from(raw));
  }

  return null;
}

SessionState? _sessionStateFromJson(Object? raw) {
  if (raw == null) return null;

  if (raw is Map<String, dynamic>) {
    return SessionState.fromJson(raw);
  }

  if (raw is Map) {
    return SessionState.fromJson(Map<String, dynamic>.from(raw));
  }

  return null;
}

/// User Profile Model
/// Matches the `profiles` table in Supabase
@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    /// UUID primary key
    required String id,

    /// Global points accumulated across all worlds
    @JsonKey(name: 'global_points') @Default(0) int globalPoints,

    /// User preferences (theme, language, etc.)
    @JsonKey(fromJson: _userPreferencesFromJson)
    UserPreferences? preferences,

    /// User inventory (items, collectibles)
    @JsonKey(fromJson: _userInventoryFromJson)
    UserInventory? inventory,

    /// Current session state
    @JsonKey(name: 'current_session', fromJson: _sessionStateFromJson)
    SessionState? currentSession,

    /// Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

/// User Preferences (stored as JSONB)
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    /// Theme mode: 'dark' | 'light' | 'system'
    @Default('dark') String theme,

    /// Language code: 'zh' | 'en'
    @Default('zh') String language,

    /// Notification settings
    @Default(true) bool notificationsEnabled,

    /// Sound effects enabled
    @Default(true) bool soundEnabled,

    /// Haptic feedback enabled
    @Default(true) bool hapticEnabled,

    /// Custom wallpaper path
    String? wallpaperPath,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

/// User Inventory (stored as JSONB)
@freezed
class UserInventory with _$UserInventory {
  const factory UserInventory({
    /// List of owned item IDs
    @Default([]) List<String> items,

    /// List of unlocked achievement IDs
    @Default([]) List<String> achievements,

    /// List of unlocked world IDs
    @Default([]) List<String> unlockedWorlds,

    /// Currency balances
    @Default({}) Map<String, int> currencies,
  }) = _UserInventory;

  factory UserInventory.fromJson(Map<String, dynamic> json) =>
      _$UserInventoryFromJson(json);
}

/// Current Session State (stored as JSONB)
@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    /// Current world ID (if in a world)
    String? currentWorldId,

    /// Current NPC ID (if in conversation)
    String? currentNpcId,

    /// Current quest ID (if active)
    String? currentQuestId,

    /// Last activity timestamp
    DateTime? lastActivity,

    /// Session metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _SessionState;

  factory SessionState.fromJson(Map<String, dynamic> json) =>
      _$SessionStateFromJson(json);
}
