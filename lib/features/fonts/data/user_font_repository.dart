import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/supabase_service.dart';
import '../../auth/domain/user_settings_repository.dart';
import '../../auth/domain/user_settings.dart';
import '../domain/user_font.dart';
import 'user_font_local_prefs.dart';
import 'user_font_prefs.dart';

/// Repository for user fonts stored in `user_settings.ui_config`.
///
/// Sync strategy:
/// - Store only metadata (no font file sync)
class UserFontRepository {
  UserFontRepository(this._settingsRepo);

  final UserSettingsRepository _settingsRepo;

  Future<List<UserFont>> list() async {
    final settings = await _getOrCreateSettings();

    // Local-only mode (not logged in)
    if (settings.userId == 'local') {
      return UserFontLocalPrefs.list();
    }

    final prefs = await _loadUiConfigRaw(settings);
    return _decodeFontsFromPrefs(prefs);
  }

  Future<String?> getSelectedFontId() async {
    final settings = await _getOrCreateSettings();

    // Local-only mode
    if (settings.userId == 'local') {
      return UserFontLocalPrefs.getSelectedFontId();
    }

    final prefs = await _loadUiConfigRaw(settings);
    return _decodeSelectedIdFromPrefs(prefs);
  }

  Future<void> setSelectedFontId(String? id) async {
    final settings = await _getOrCreateSettings();

    // Local-only mode
    if (settings.userId == 'local') {
      await UserFontLocalPrefs.setSelectedFontId(id);
      return;
    }

    final userId = settings.userId;
    final json = await _loadUiConfigRaw(settings);
    if (id == null) {
      json.remove(UserFontPrefsKeys.selectedFontId);
    } else {
      json[UserFontPrefsKeys.selectedFontId] = id;
    }
    await _settingsRepo.upsertUiConfigPatch(json);
  }

  Future<void> upsert(UserFont font) async {
    final settings = await _getOrCreateSettings();

    // Local-only mode
    if (settings.userId == 'local') {
      await UserFontLocalPrefs.upsert(font);
      return;
    }

    final userId = settings.userId;
    final json = await _loadUiConfigRaw(settings);
    final fonts = _decodeFontsFromPrefs(json);
    final idx = fonts.indexWhere((f) => f.id == font.id);
    if (idx >= 0) {
      fonts[idx] = font;
    } else {
      fonts.add(font);
    }
    json[UserFontPrefsKeys.userFonts] = fonts.map((e) => e.toJson()).toList();

    await _settingsRepo.upsertUiConfigPatch(json);
  }

  Future<void> removeById(String id) async {
    final settings = await _getOrCreateSettings();

    // Local-only mode
    if (settings.userId == 'local') {
      await UserFontLocalPrefs.removeById(id);
      return;
    }

    final userId = settings.userId;
    final json = await _loadUiConfigRaw(settings);
    final fonts = _decodeFontsFromPrefs(json);
    fonts.removeWhere((f) => f.id == id);
    json[UserFontPrefsKeys.userFonts] = fonts.map((e) => e.toJson()).toList();

    // If selected points to removed, clear selection
    final selected = _decodeSelectedIdFromPrefs(json);
    if (selected == id) {
      json.remove(UserFontPrefsKeys.selectedFontId);
    }

    await _settingsRepo.upsertUiConfigPatch(json);
  }

  Future<UserSettings> _getOrCreateSettings() async {
    final user = SupabaseService.currentUser;
    if (user == null) {
      // Not logged in: local-only preferences.
      return const UserSettings(userId: 'local');
    }

    final existing = await _settingsRepo.getCurrent();
    if (existing != null) return existing;

    // user_settings is auto-created by trigger on signup. If missing, fail loudly.
    throw Exception('user_settings not found for current user');
  }

  Future<Map<String, dynamic>> _loadUiConfigRaw(UserSettings settings) async {
    final fallback = settings.uiConfig;
    final userId = settings.userId;
    try {
      final row = await SupabaseService.client
          .from('user_settings')
          .select('ui_config')
          .eq('user_id', userId)
          .maybeSingle();
      final raw = row?['ui_config'];
      final map = _normalizePrefsMap(raw);
      if (map != null) return map;
    } catch (_) {}
    return fallback;
  }

  Map<String, dynamic>? _normalizePrefsMap(Object? raw) {
    if (raw is Map<String, dynamic>) {
      return Map<String, dynamic>.from(raw);
    }
    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {}
    }
    return null;
  }

  List<UserFont> _decodeFontsFromPrefs(Map<String, dynamic> prefs) {
    final raw = prefs[UserFontPrefsKeys.userFonts];
    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map(UserFont.fromJson)
          .toList();
    }

    // Sometimes jsonb comes back as List<dynamic> of Map<dynamic,dynamic>
    if (raw is List<dynamic>) {
      return raw
          .where((e) => e is Map)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map(UserFont.fromJson)
          .toList();
    }

    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded
              .where((e) => e is Map)
              .map((e) => Map<String, dynamic>.from(e as Map))
              .map(UserFont.fromJson)
              .toList();
        }
      } catch (_) {}
    }

    return [];
  }

  String? _decodeSelectedIdFromPrefs(Map<String, dynamic> prefs) {
    final v = prefs[UserFontPrefsKeys.selectedFontId];
    return v is String ? v : null;
  }
}

final userFontRepositoryProvider = Provider<UserFontRepository>((ref) {
  final repo = ref.watch(userSettingsRepositoryProvider);
  return UserFontRepository(repo);
});
