import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import 'user_settings.dart';

part 'user_settings_repository.g.dart';

class UserSettingsRepository {
  UserSettingsRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'user_settings';

  Future<UserSettings?> getCurrent() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final row = await _client
        .from(_table)
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    if (row == null) return null;
    return UserSettings.fromJson(row);
  }

  Future<UserSettings> upsertUiConfigPatch(Map<String, dynamic> patch) async {
    final user = _client.auth.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    // Load current then merge in app, because supabase Dart doesn't provide deep jsonb merge.
    final current = await getCurrent();
    final merged = <String, dynamic>{...current?.uiConfig ?? const {}, ...patch};

    final row = await _client
        .from(_table)
        .update({'ui_config': merged})
        .eq('user_id', user.id)
        .select()
        .single();

    return UserSettings.fromJson(row);
  }
}

@riverpod
UserSettingsRepository userSettingsRepository(Ref ref) {
  return UserSettingsRepository(SupabaseService.client);
}

@riverpod
Future<UserSettings?> currentUserSettings(Ref ref) async {
  final repo = ref.watch(userSettingsRepositoryProvider);
  return repo.getCurrent();
}
