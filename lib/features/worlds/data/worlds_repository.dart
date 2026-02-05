import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import 'models/world.dart';

class WorldsRepository {
  WorldsRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'worlds';

  Future<List<World>> listMyWorlds() async {
    final user = SupabaseService.currentUser;
    if (user == null) {
      throw const AuthException('Not authenticated');
    }

    final response = await _client
        .from(_table)
        .select()
        .isFilter('archived_at', null)
        .order('updated_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(response as List);
    return rows.map(World.fromJson).toList();
  }

  Future<World> createWorld({
    required String name,
    String? description,
    String? slug,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) {
      throw const AuthException('Not authenticated');
    }

    final insertData = <String, dynamic>{
      'user_id': user.id,
      'name': name,
      'description': description,
      'slug': slug,
    }..removeWhere((key, value) => value == null);

    final row = await _client.from(_table).insert(insertData).select().single();
    return World.fromJson(row);
  }
}
