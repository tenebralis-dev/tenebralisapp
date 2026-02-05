// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemePresetImpl _$$ThemePresetImplFromJson(Map<String, dynamic> json) =>
    _$ThemePresetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 2,
      lightTokens: ThemeTokens.fromJson(
        json['lightTokens'] as Map<String, dynamic>,
      ),
      darkTokens: ThemeTokens.fromJson(
        json['darkTokens'] as Map<String, dynamic>,
      ),
      syncEnabled: json['syncEnabled'] as bool? ?? false,
      pendingSync: json['pendingSync'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ThemePresetImplToJson(_$ThemePresetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schemaVersion': instance.schemaVersion,
      'lightTokens': instance.lightTokens,
      'darkTokens': instance.darkTokens,
      'syncEnabled': instance.syncEnabled,
      'pendingSync': instance.pendingSync,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ThemePresetColorsImpl _$$ThemePresetColorsImplFromJson(
  Map<String, dynamic> json,
) => _$ThemePresetColorsImpl(
  primary: json['primary'] as String,
  secondary: json['secondary'] as String,
  background: json['background'] as String,
  surface: json['surface'] as String,
  text: json['text'] as String,
  error: json['error'] as String?,
  success: json['success'] as String?,
  warning: json['warning'] as String?,
);

Map<String, dynamic> _$$ThemePresetColorsImplToJson(
  _$ThemePresetColorsImpl instance,
) => <String, dynamic>{
  'primary': instance.primary,
  'secondary': instance.secondary,
  'background': instance.background,
  'surface': instance.surface,
  'text': instance.text,
  'error': instance.error,
  'success': instance.success,
  'warning': instance.warning,
};
