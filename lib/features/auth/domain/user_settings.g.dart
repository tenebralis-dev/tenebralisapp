// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      userId: json['user_id'] as String,
      uiConfig: json['ui_config'] == null
          ? const {}
          : _mapFromJson(json['ui_config']),
      systemPreferences: json['system_preferences'] == null
          ? const {}
          : _mapFromJson(json['system_preferences']),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'ui_config': instance.uiConfig,
      'system_preferences': instance.systemPreferences,
    };
