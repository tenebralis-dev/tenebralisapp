import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/user_font.dart';

class UserFontLocalPrefs {
  UserFontLocalPrefs._();

  static const _fontsKey = 'local.user_fonts';
  static const _selectedIdKey = 'local.selected_user_font_id';

  static Future<List<UserFont>> list() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_fontsKey);
    if (raw == null || raw.trim().isEmpty) return [];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .where((e) => e is Map)
            .map((e) => UserFont.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static Future<void> saveAll(List<UserFont> fonts) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(fonts.map((e) => e.toJson()).toList());
    await prefs.setString(_fontsKey, raw);
  }

  static Future<void> upsert(UserFont font) async {
    final fonts = await list();
    final idx = fonts.indexWhere((f) => f.id == font.id);
    if (idx >= 0) {
      fonts[idx] = font;
    } else {
      fonts.add(font);
    }
    await saveAll(fonts);
  }

  static Future<void> removeById(String id) async {
    final fonts = await list();
    fonts.removeWhere((f) => f.id == id);
    await saveAll(fonts);

    final selected = await getSelectedFontId();
    if (selected == id) {
      await setSelectedFontId(null);
    }
  }

  static Future<String?> getSelectedFontId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedIdKey);
  }

  static Future<void> setSelectedFontId(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(_selectedIdKey);
    } else {
      await prefs.setString(_selectedIdKey, id);
    }
  }
}
