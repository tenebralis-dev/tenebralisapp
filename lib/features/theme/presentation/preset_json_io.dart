import 'dart:convert';

import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';

/// Export a single preset to JSON string.
String exportPresetToJson(ThemePreset preset) {
  final map = <String, Object?>{
    'schemaVersion': preset.schemaVersion,
    'id': preset.id,
    'name': preset.name,
    'lightTokens': preset.lightTokens.toJson(),
    'darkTokens': preset.darkTokens.toJson(),
  };
  return const JsonEncoder.withIndent('  ').convert(map);
}

/// Import a single preset from JSON string.
///
/// Supports:
/// - v2: {schemaVersion:2, lightTokens:{...}, darkTokens:{...}}
/// - v1 legacy: {colors:{...}} or raw ThemePreset json with `colors`.
ThemePreset importPresetFromJson({
  required String jsonString,
  required String newId,
}) {
  final decoded = jsonDecode(jsonString);
  if (decoded is! Map) {
    throw FormatException('JSON 必须是对象');
  }

  final map = Map<String, Object?>.from(decoded as Map);
  final schemaVersion = (map['schemaVersion'] as num?)?.toInt() ?? 1;

  if (schemaVersion >= 2 && map['lightTokens'] is Map && map['darkTokens'] is Map) {
    final light = ThemeTokens.fromJson(Map<String, Object?>.from(map['lightTokens'] as Map));
    final dark = ThemeTokens.fromJson(Map<String, Object?>.from(map['darkTokens'] as Map));

    return ThemePreset(
      id: newId,
      name: (map['name'] as String?) ?? '导入方案',
      schemaVersion: 2,
      lightTokens: light,
      darkTokens: dark,
      syncEnabled: false,
      pendingSync: false,
      updatedAt: DateTime.now(),
    );
  }

  // Legacy v1.
  // Accept either {colors:{...}} or a ThemePreset json.
  final colorsMap = map['colors'] is Map ? Map<String, Object?>.from(map['colors'] as Map) : null;
  if (colorsMap == null) {
    throw FormatException('不支持的 JSON 格式：缺少 lightTokens/darkTokens 或 colors');
  }

  final legacy = ThemePresetColors.fromJson(colorsMap);
  final light = ThemeTokens(
    primary: legacy.primary,
    secondary: legacy.secondary,
    background: legacy.background,
    surface: legacy.surface,
    text: legacy.text,
    error: legacy.error,
    success: legacy.success,
    warning: legacy.warning,
  );

  return ThemePreset(
    id: newId,
    name: (map['name'] as String?) ?? '导入方案',
    schemaVersion: 2,
    lightTokens: light,
    darkTokens: light,
    syncEnabled: false,
    pendingSync: false,
    updatedAt: DateTime.now(),
  );
}
