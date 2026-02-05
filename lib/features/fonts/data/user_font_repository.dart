import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profiles/data/repositories/profile_repository.dart';
import '../../profiles/data/models/profile_model.dart';
import '../../../core/services/supabase_service.dart';
import '../domain/user_font.dart';
import 'user_font_local_prefs.dart';
import 'user_font_prefs.dart';

/// Repository for user fonts stored in `profiles.preferences`.
///
/// Sync strategy:
/// - Store only metadata (no font file sync)
class UserFontRepository {
  UserFontRepository(this._profileRepo);

  final ProfileRepository _profileRepo;

  Future<List<UserFont>> list() async {
    final profile = await _getOrCreateProfile();

    // Local-only mode (not logged in)
    if (profile.id == 'local') {
      return UserFontLocalPrefs.list();
    }

    final prefs = await _loadPreferencesRaw(profile);
    return _decodeFontsFromPrefs(prefs);
  }

  Future<String?> getSelectedFontId() async {
    final profile = await _getOrCreateProfile();

    // Local-only mode
    if (profile.id == 'local') {
      return UserFontLocalPrefs.getSelectedFontId();
    }

    final prefs = await _loadPreferencesRaw(profile);
    return _decodeSelectedIdFromPrefs(prefs);
  }

  Future<void> setSelectedFontId(String? id) async {
    final profile = await _getOrCreateProfile();

    // Local-only mode
    if (profile.id == 'local') {
      await UserFontLocalPrefs.setSelectedFontId(id);
      return;
    }

    final userId = profile.id;
    final json = await _loadPreferencesRaw(profile);
    if (id == null) {
      json.remove(UserFontPrefsKeys.selectedFontId);
    } else {
      json[UserFontPrefsKeys.selectedFontId] = id;
    }
    await _profileRepo.updateProfile(userId, {'preferences': json});
  }

  Future<void> upsert(UserFont font) async {
    final profile = await _getOrCreateProfile();

    // Local-only mode
    if (profile.id == 'local') {
      await UserFontLocalPrefs.upsert(font);
      return;
    }

    final userId = profile.id;
    final json = await _loadPreferencesRaw(profile);
    final fonts = _decodeFontsFromPrefs(json);
    final idx = fonts.indexWhere((f) => f.id == font.id);
    if (idx >= 0) {
      fonts[idx] = font;
    } else {
      fonts.add(font);
    }
    json[UserFontPrefsKeys.userFonts] = fonts.map((e) => e.toJson()).toList();

    await _profileRepo.updateProfile(userId, {'preferences': json});
  }

  Future<void> removeById(String id) async {
    final profile = await _getOrCreateProfile();

    // Local-only mode
    if (profile.id == 'local') {
      await UserFontLocalPrefs.removeById(id);
      return;
    }

    final userId = profile.id;
    final json = await _loadPreferencesRaw(profile);
    final fonts = _decodeFontsFromPrefs(json);
    fonts.removeWhere((f) => f.id == id);
    json[UserFontPrefsKeys.userFonts] = fonts.map((e) => e.toJson()).toList();

    // If selected points to removed, clear selection
    final selected = _decodeSelectedIdFromPrefs(json);
    if (selected == id) {
      json.remove(UserFontPrefsKeys.selectedFontId);
    }

    await _profileRepo.updateProfile(userId, {'preferences': json});
  }

  Future<ProfileModel> _getOrCreateProfile() async {
    final user = SupabaseService.currentUser;
    if (user == null) {
      // Not logged in: return a pseudo profile with local-only preferences.
      // For v1, user fonts are only available after login.
      return ProfileModel(id: 'local', preferences: const UserPreferences());
    }

    final existing = await _profileRepo.getProfile(user.id);
    if (existing != null) return existing;
    return await _profileRepo.createProfile(user.id);
  }

  Future<Map<String, dynamic>> _loadPreferencesRaw(ProfileModel profile) async {
    final fallback = profile.preferences ?? const UserPreferences();
    final userId = profile.id;
    try {
      final row = await SupabaseService.client
          .from('profiles')
          .select('preferences')
          .eq('id', userId)
          .maybeSingle();
      final raw = row?['preferences'];
      final map = _normalizePrefsMap(raw);
      if (map != null) return map;
    } catch (_) {}
    return fallback.toJson();
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
  final repo = ref.watch(profileRepositoryProvider);
  return UserFontRepository(repo);
});
