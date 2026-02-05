import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';

class ThemePresetRemoteDataSource {
  ThemePresetRemoteDataSource({SupabaseClient? client})
      : _client = client ?? SupabaseService.client;

  final SupabaseClient _client;

  static const table = 'ui_theme_presets';

  bool get canUse => SupabaseService.isInitialized && SupabaseService.isAuthenticated;

  Future<List<ThemePreset>> fetchPresets() async {
    final user = SupabaseService.currentUser;
    if (user == null) return [];

    final rows = await _client
        .from(table)
        .select('id,name,colors_json,is_deleted,updated_at')
        .eq('user_id', user.id)
        .order('updated_at', ascending: false);

    return (rows as List)
        .cast<Map<String, dynamic>>()
        .where((r) => (r['is_deleted'] as bool? ?? false) == false)
        .map(_mapRowToPreset)
        .toList();
  }

  Future<void> upsertPreset(ThemePreset preset) async {
    final user = SupabaseService.currentUser;
    if (user == null) return;

    await _client.from(table).upsert({
      'id': preset.id,
      'user_id': user.id,
      'name': preset.name,
      'colors_json': {
        'schemaVersion': preset.schemaVersion,
        'lightTokens': preset.lightTokens.toJson(),
        'darkTokens': preset.darkTokens.toJson(),
      },
      'is_deleted': false,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> softDeletePreset(String id) async {
    final user = SupabaseService.currentUser;
    if (user == null) return;

    await _client.from(table).update({
      'is_deleted': true,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', id).eq('user_id', user.id);
  }

  ThemePreset _mapRowToPreset(Map<String, dynamic> row) {
    final colorsJson = row['colors_json'];
    ThemePreset? preset;

    if (colorsJson is Map<String, dynamic>) {
      final sv = (colorsJson['schemaVersion'] as num?)?.toInt() ?? 1;
      if (sv >= 2 && colorsJson['lightTokens'] is Map && colorsJson['darkTokens'] is Map) {
        final light = ThemeTokens.fromJson(
          Map<String, Object?>.from(colorsJson['lightTokens'] as Map),
        );
        final dark = ThemeTokens.fromJson(
          Map<String, Object?>.from(colorsJson['darkTokens'] as Map),
        );
        preset = ThemePreset(
          id: row['id'] as String,
          name: row['name'] as String,
          schemaVersion: 2,
          lightTokens: light,
          darkTokens: dark,
          syncEnabled: true,
          pendingSync: false,
          updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? ''),
        );
      } else {
        // Legacy v1 payload.
        final legacy = ThemePresetColors.fromJson(colorsJson);
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
        preset = ThemePreset(
          id: row['id'] as String,
          name: row['name'] as String,
          schemaVersion: 2,
          lightTokens: light,
          darkTokens: light,
          syncEnabled: true,
          pendingSync: false,
          updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? ''),
        );
      }
    }

    preset ??= ThemePreset(
      id: row['id'] as String,
      name: row['name'] as String,
      schemaVersion: 2,
      lightTokens: const ThemeTokens(
        primary: '#6C63FF',
        secondary: '#00D9FF',
        background: '#0A0E21',
        surface: '#1D1E33',
        text: '#FFFFFF',
      ),
      darkTokens: const ThemeTokens(
        primary: '#6C63FF',
        secondary: '#00D9FF',
        background: '#0A0E21',
        surface: '#1D1E33',
        text: '#FFFFFF',
      ),
      syncEnabled: true,
      pendingSync: false,
      updatedAt: DateTime.tryParse(row['updated_at'] as String? ?? ''),
    );

    return preset;
  }
}
