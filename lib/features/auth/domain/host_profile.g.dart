// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HostProfileImpl _$$HostProfileImplFromJson(Map<String, dynamic> json) =>
    _$HostProfileImpl(
      id: json['id'] as String,
      username: json['username'] as String?,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      systemLevel: (json['system_level'] as num?)?.toInt() ?? 1,
      expPoints: (json['exp_points'] as num?)?.toInt() ?? 0,
      legacyCurrentSession: _identityFromJson(json['current_session']),
      legacyPreferences: json['legacyPreferences'] == null
          ? const {}
          : _mapFromJson(json['legacyPreferences']),
    );

Map<String, dynamic> _$$HostProfileImplToJson(_$HostProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'bio': instance.bio,
      'system_level': instance.systemLevel,
      'exp_points': instance.expPoints,
      'current_session': instance.legacyCurrentSession,
      'legacyPreferences': instance.legacyPreferences,
    };
