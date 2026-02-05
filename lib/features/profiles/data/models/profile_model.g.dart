// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      globalPoints: (json['global_points'] as num?)?.toInt() ?? 0,
      preferences: _userPreferencesFromJson(json['preferences']),
      inventory: _userInventoryFromJson(json['inventory']),
      currentSession: _sessionStateFromJson(json['current_session']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'global_points': instance.globalPoints,
      'preferences': instance.preferences,
      'inventory': instance.inventory,
      'current_session': instance.currentSession,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$UserPreferencesImpl(
  theme: json['theme'] as String? ?? 'dark',
  language: json['language'] as String? ?? 'zh',
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  soundEnabled: json['soundEnabled'] as bool? ?? true,
  hapticEnabled: json['hapticEnabled'] as bool? ?? true,
  wallpaperPath: json['wallpaperPath'] as String?,
);

Map<String, dynamic> _$$UserPreferencesImplToJson(
  _$UserPreferencesImpl instance,
) => <String, dynamic>{
  'theme': instance.theme,
  'language': instance.language,
  'notificationsEnabled': instance.notificationsEnabled,
  'soundEnabled': instance.soundEnabled,
  'hapticEnabled': instance.hapticEnabled,
  'wallpaperPath': instance.wallpaperPath,
};

_$UserInventoryImpl _$$UserInventoryImplFromJson(Map<String, dynamic> json) =>
    _$UserInventoryImpl(
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      unlockedWorlds:
          (json['unlockedWorlds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currencies:
          (json['currencies'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$UserInventoryImplToJson(_$UserInventoryImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'achievements': instance.achievements,
      'unlockedWorlds': instance.unlockedWorlds,
      'currencies': instance.currencies,
    };

_$SessionStateImpl _$$SessionStateImplFromJson(Map<String, dynamic> json) =>
    _$SessionStateImpl(
      currentWorldId: json['currentWorldId'] as String?,
      currentNpcId: json['currentNpcId'] as String?,
      currentQuestId: json['currentQuestId'] as String?,
      lastActivity: json['lastActivity'] == null
          ? null
          : DateTime.parse(json['lastActivity'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SessionStateImplToJson(_$SessionStateImpl instance) =>
    <String, dynamic>{
      'currentWorldId': instance.currentWorldId,
      'currentNpcId': instance.currentNpcId,
      'currentQuestId': instance.currentQuestId,
      'lastActivity': instance.lastActivity?.toIso8601String(),
      'metadata': instance.metadata,
    };
