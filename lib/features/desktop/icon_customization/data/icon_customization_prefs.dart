import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/icon_customization.dart';

class IconCustomizationPrefs {
  IconCustomizationPrefs(this._prefs);

  static const _kKey = 'desktop.icon_customization.map.v1';

  final SharedPreferences _prefs;

  Future<Map<String, IconCustomization>> loadAll() async {
    final raw = _prefs.getString(_kKey);
    if (raw == null || raw.isEmpty) return {};

    try {
      return IconCustomization.decodeMap(raw);
    } catch (_) {
      return {};
    }
  }

  Future<void> saveAll(Map<String, IconCustomization> map) async {
    final raw = IconCustomization.encodeMap(map);
    await _prefs.setString(_kKey, raw);
  }

  Future<void> clearAll() async {
    await _prefs.remove(_kKey);
  }
}

final iconCustomizationPrefsProvider =
    FutureProvider<IconCustomizationPrefs>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return IconCustomizationPrefs(prefs);
});
