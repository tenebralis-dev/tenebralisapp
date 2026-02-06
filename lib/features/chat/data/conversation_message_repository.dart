import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';

part 'conversation_message_repository.g.dart';

class ConversationMessageRepository {
  ConversationMessageRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'conversation_messages';

  Future<int> getNextSeq(String conversationId) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final row = await _client
        .from(_table)
        .select('seq')
        .eq('conversation_id', conversationId)
        .order('seq', ascending: false)
        .limit(1)
        .maybeSingle();

    final last = row?['seq'];
    if (last is int) return last + 1;
    return 1;
  }

  Future<List<Map<String, dynamic>>> list({
    required String conversationId,
    int limit = 50,
    int? beforeSeq,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    var query = _client
        .from(_table)
        .select()
        .eq('conversation_id', conversationId);

    if (beforeSeq != null) {
      query = query.lt('seq', beforeSeq);
    }

    final response = await query.order('seq', ascending: false).limit(limit);
    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<Map<String, dynamic>> insert({
    required String conversationId,
    required String role,
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final nextSeq = await getNextSeq(conversationId);

    final insertData = <String, dynamic>{
      'user_id': user.id,
      'conversation_id': conversationId,
      'seq': nextSeq,
      'role': role,
      'content': content,
      'metadata_json': metadata ?? <String, dynamic>{},
    };

    final row = await _client.from(_table).insert(insertData).select().single();
    return row;
  }
}

@riverpod
ConversationMessageRepository conversationMessageRepository(Ref ref) {
  return ConversationMessageRepository(SupabaseService.client);
}
