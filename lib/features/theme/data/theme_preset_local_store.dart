import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/theme_preset.dart';

class ThemePresetLocalStore {
  static const _presetsKey = 'theme.presets.v1';
  static const _activeIdKey = 'theme.active_preset_id.v1';

  Future<List<ThemePreset>> loadPresets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_presetsKey);
    if (raw == null || raw.trim().isEmpty) return [];

    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map>()
        .map((e) => ThemePreset.fromJson(Map<String, Object?>.from(e)))
        .toList();
  }

  Future<void> savePresets(List<ThemePreset> presets) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(presets.map((e) => e.toJson()).toList());
    await prefs.setString(_presetsKey, raw);
  }

  Future<String?> loadActivePresetId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeIdKey);
  }

  Future<void> saveActivePresetId(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(_activeIdKey);
    } else {
      await prefs.setString(_activeIdKey, id);
    }
  }
}
