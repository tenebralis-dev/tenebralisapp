import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalLocalePrefs {
  LocalLocalePrefs._();

  static const _key = 'settings.language'; // 'zh_CN' | 'en_US'

  static Future<Locale> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key) ?? 'zh_CN';
    if (raw.startsWith('en')) return const Locale('en');
    return const Locale('zh');
  }

  static Future<void> save(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    final v = locale.languageCode.startsWith('en') ? 'en_US' : 'zh_CN';
    await prefs.setString(_key, v);
  }
}
