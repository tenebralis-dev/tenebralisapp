import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import 'models/world_save_state.dart';

part 'world_save_state_repository.g.dart';

class WorldSaveStateRepository {
  WorldSaveStateRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'world_save_states';

  Future<List<WorldSaveState>> listByIdentity(String identityId) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final response = await _client
        .from(_table)
        .select()
        .eq('identity_id', identityId)
        .order('last_played_at', ascending: false)
        .order('updated_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(response as List);
    return rows.map(WorldSaveState.fromJson).toList();
  }

  Future<WorldSaveState> create({
    required String worldId,
    required String identityId,
    required int slot,
    String? title,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final insertData = <String, dynamic>{
      'user_id': user.id,
      'world_id': worldId,
      'identity_id': identityId,
      'slot': slot,
      'title': title,
      'state_json': <String, dynamic>{},
      'last_played_at': DateTime.now().toIso8601String(),
    }..removeWhere((k, v) => v == null);

    final row = await _client.from(_table).insert(insertData).select().single();
    return WorldSaveState.fromJson(row);
  }

  Future<WorldSaveState> touchLastPlayed(String saveId) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final row = await _client
        .from(_table)
        .update({'last_played_at': DateTime.now().toIso8601String()})
        .eq('id', saveId)
        .select()
        .single();

    return WorldSaveState.fromJson(row);
  }
}

@riverpod
WorldSaveStateRepository worldSaveStateRepository(Ref ref) {
  return WorldSaveStateRepository(SupabaseService.client);
}
