// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      globalPoints: (json['global_points'] as num?)?.toInt() ?? 0,
      preferences: json['preferences'] == null
          ? const {}
          : _mapFromJson(json['preferences']),
      inventory: json['inventory'] == null
          ? const {}
          : _mapFromJson(json['inventory']),
      currentSession: _identityFromJson(json['current_session']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'global_points': instance.globalPoints,
      'preferences': instance.preferences,
      'inventory': instance.inventory,
      'current_session': instance.currentSession,
    };
