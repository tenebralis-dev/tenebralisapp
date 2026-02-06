import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';

part 'conversation_repository.g.dart';

class ConversationRepository {
  ConversationRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'conversations';

  Future<Map<String, dynamic>?> findById(String conversationId) async {
    final user = SupabaseService.currentUser;
    if (user == null) return null;

    final row = await _client
        .from(_table)
        .select()
        .eq('id', conversationId)
        .maybeSingle();

    return row;
  }

  Future<List<Map<String, dynamic>>> listBySave({
    required String saveId,
    int limit = 50,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final response = await _client
        .from(_table)
        .select()
        .eq('save_id', saveId)
        .order('last_message_at', ascending: false)
        .limit(limit);

    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<Map<String, dynamic>> getOrCreate({
    required String saveId,
    required String npcId,
    required String threadKey,
    String? title,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final existing = await _client
        .from(_table)
        .select()
        .eq('save_id', saveId)
        .eq('npc_id', npcId)
        .eq('thread_key', threadKey)
        .maybeSingle();

    if (existing != null) return existing;

    final insertData = <String, dynamic>{
      'user_id': user.id,
      'save_id': saveId,
      'npc_id': npcId,
      'thread_key': threadKey,
      'title': title,
      'last_message_at': DateTime.now().toIso8601String(),
    }..removeWhere((k, v) => v == null);

    final row = await _client.from(_table).insert(insertData).select().single();
    return row;
  }

  Future<void> touchLastMessageAt(String conversationId) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    await _client
        .from(_table)
        .update({'last_message_at': DateTime.now().toIso8601String()})
        .eq('id', conversationId);
  }
}

@riverpod
ConversationRepository conversationRepository(Ref ref) {
  return ConversationRepository(SupabaseService.client);
}
