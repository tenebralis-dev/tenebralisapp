import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Local-only font config.
/// - preset: { type: 'preset', preset: 'NotoSansSC' }
/// - source: { type: 'url', source: 'https://...' } OR { type: 'url', source: 'file://...' }
class LocalFontConfig {
  const LocalFontConfig._({this.preset, this.source});

  final String? preset;
  final String? source;

  bool get isPreset => preset != null && preset!.isNotEmpty;
  bool get isSource => source != null && source!.isNotEmpty;

  Map<String, dynamic> toJson() {
    if (isPreset) return {'type': 'preset', 'preset': preset};
    if (isSource) return {'type': 'url', 'source': source};
    return {};
  }

  static LocalFontConfig? fromJson(Object? raw) {
    if (raw == null) return null;
    Map<String, dynamic> map;
    if (raw is Map<String, dynamic>) {
      map = raw;
    } else if (raw is Map) {
      map = Map<String, dynamic>.from(raw);
    } else {
      return null;
    }
    final type = map['type'] as String?;
    if (type == 'preset') {
      final p = map['preset'] as String?;
      return (p == null || p.isEmpty) ? null : LocalFontConfig._(preset: p);
    }
    if (type == 'url') {
      final s = map['source'] as String?;
      return (s == null || s.isEmpty) ? null : LocalFontConfig._(source: s);
    }
    return null;
  }
}

class LocalFontConfigStore {
  LocalFontConfigStore._();

  static const _key = 'settings.font_config';

  static Future<LocalFontConfig?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      return LocalFontConfig.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  static Future<void> save(LocalFontConfig? config) async {
    final prefs = await SharedPreferences.getInstance();
    if (config == null) {
      await prefs.remove(_key);
      return;
    }
    await prefs.setString(_key, jsonEncode(config.toJson()));
  }
}
