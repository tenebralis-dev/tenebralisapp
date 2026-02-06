import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import 'models/world_identity.dart';

part 'world_identity_repository.g.dart';

class WorldIdentityRepository {
  WorldIdentityRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'user_world_identities';

  Future<List<WorldIdentity>> listByWorld(String worldId) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final response = await _client
        .from(_table)
        .select()
        .eq('world_id', worldId)
        .order('updated_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(response as List);
    return rows.map(WorldIdentity.fromJson).toList();
  }

  Future<WorldIdentity> create({
    required String worldId,
    required String identityName,
    String? promptIdentityText,
  }) async {
    // #region agent log
    void _log(String hypothesisId, String message, Map<String, dynamic> data) {
      // ignore: avoid_print
      print('[agentlog] $hypothesisId $message $data');
    }
    // #endregion

    final user = SupabaseService.currentUser;
    _log('H2', 'create_enter', {
      'worldId': worldId,
      'identityNameLen': identityName.length,
      'hasUser': user != null,
    });

    if (user == null) throw const AuthException('Not authenticated');

    final insertData = <String, dynamic>{
      'user_id': user.id,
      'world_id': worldId,
      'identity_name': identityName,
      'prompt_identity_text': promptIdentityText,
      'is_active': true,
    }..removeWhere((k, v) => v == null);

    _log('H2', 'before_insert', {
      'keys': insertData.keys.toList(),
      'userIdPrefix': user.id.substring(0, 6),
    });

    try {
      final row = await _client.from(_table).insert(insertData).select().single();

      _log('H2', 'after_insert', {
        'rowKeys': (row as Map).keys.toList(),
        'id': row['id'],
      });

      return WorldIdentity.fromJson(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      // Common cause: Supabase schema cache stale.
      _log('H2', 'postgrest_exception', {
        'code': e.code,
        'message': e.message,
        'details': e.details,
      });
      rethrow;
    }
  }
}

@riverpod
WorldIdentityRepository worldIdentityRepository(Ref ref) {
  return WorldIdentityRepository(SupabaseService.client);
}
