import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';
import '../models/chronicle_model.dart';

part 'chronicle_repository.g.dart';

/// Chronicle Repository
/// Handles all chronicle/timeline-related database operations
class ChronicleRepository {
  ChronicleRepository(this._client);

  final SupabaseClient _client;

  static const String _tableName = 'chronicles';

  /// Get all chronicles for a user
  Future<List<ChronicleModel>> getUserChronicles(
    String userId, {
    int? limit,
    int? offset,
  }) async {
    var query = _client
        .from(_tableName)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final response = limit != null ? await query.limit(limit) : await query;
    return (response as List).map((e) => ChronicleModel.fromJson(e)).toList();
  }

  /// Get chronicles for a specific world
  Future<List<ChronicleModel>> getWorldChronicles(
    String userId,
    String worldId, {
    int? limit,
    int? offset,
  }) async {
    var query = _client
        .from(_tableName)
        .select()
        .eq('user_id', userId)
        .eq('world_id', worldId)
        .order('created_at', ascending: false);

    final response = limit != null ? await query.limit(limit) : await query;
    return (response as List).map((e) => ChronicleModel.fromJson(e)).toList();
  }

  /// Get chronicles by type
  Future<List<ChronicleModel>> getChroniclesByType(
    String userId,
    ChronicleType type, {
    String? worldId,
    int? limit,
  }) async {
    var query = _client
        .from(_tableName)
        .select()
        .eq('user_id', userId)
        .eq('type', type.name);

    if (worldId != null) {
      query = query.eq('world_id', worldId);
    }

    final orderedQuery = query.order('created_at', ascending: false);
    final response =
        limit != null ? await orderedQuery.limit(limit) : await orderedQuery;
    return (response as List).map((e) => ChronicleModel.fromJson(e)).toList();
  }

  /// Get chat history (paginated)
  Future<List<ChronicleModel>> getChatHistory(
    String userId,
    String worldId, {
    int limit = 50,
    DateTime? before,
  }) async {
    var query = _client
        .from(_tableName)
        .select()
        .eq('user_id', userId)
        .eq('world_id', worldId)
        .eq('type', ChronicleType.chat.name);

    if (before != null) {
      query = query.lt('created_at', before.toIso8601String());
    }

    final response =
        await query.order('created_at', ascending: false).limit(limit);
    return (response as List).map((e) => ChronicleModel.fromJson(e)).toList();
  }

  /// Create a new chronicle entry
  Future<ChronicleModel> createChronicle(ChronicleModel chronicle) async {
    final data = chronicle.toJson();
    data.remove('id'); // Let database generate ID
    data.remove('created_at');
    data.remove('updated_at');

    final response =
        await _client.from(_tableName).insert(data).select().single();
    return ChronicleModel.fromJson(response);
  }

  /// Create a chat chronicle
  Future<ChronicleModel> createChatChronicle({
    required String userId,
    required String worldId,
    required String sender,
    required String message,
    String? npcKey,
    List<SystemEvent>? systemEvents,
    String? thought,
  }) async {
    final chronicle = ChronicleModel(
      id: '',
      userId: userId,
      worldId: worldId,
      type: ChronicleType.chat,
      content: ChronicleContent.chat(
        sender: sender,
        message: message,
        npcKey: npcKey,
        systemEvents: systemEvents ?? [],
        thought: thought,
      ),
    );

    return createChronicle(chronicle);
  }

  /// Create a memo chronicle
  Future<ChronicleModel> createMemoChronicle({
    required String userId,
    String? worldId,
    required String title,
    required String body,
    List<String>? tags,
    bool isPinned = false,
  }) async {
    final chronicle = ChronicleModel(
      id: '',
      userId: userId,
      worldId: worldId,
      type: ChronicleType.memo,
      content: ChronicleContent.memo(
        title: title,
        body: body,
        tags: tags ?? [],
        isPinned: isPinned,
      ),
    );

    return createChronicle(chronicle);
  }

  /// Create a transaction chronicle
  Future<ChronicleModel> createTransactionChronicle({
    required String userId,
    String? worldId,
    required String transactionType,
    required int amount,
    required String reason,
    String currencyType = 'points',
    String? referenceId,
  }) async {
    final chronicle = ChronicleModel(
      id: '',
      userId: userId,
      worldId: worldId,
      type: ChronicleType.transaction,
      content: ChronicleContent.transaction(
        transactionType: transactionType,
        amount: amount,
        reason: reason,
        currencyType: currencyType,
        referenceId: referenceId,
      ),
    );

    return createChronicle(chronicle);
  }

  /// Update a chronicle
  Future<ChronicleModel> updateChronicle(
    String chronicleId,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from(_tableName)
        .update(updates)
        .eq('id', chronicleId)
        .select()
        .single();
    return ChronicleModel.fromJson(response);
  }

  /// Delete a chronicle
  Future<void> deleteChronicle(String chronicleId) async {
    await _client.from(_tableName).delete().eq('id', chronicleId);
  }

  /// Subscribe to new chronicles
  RealtimeChannel subscribeToChronicles(
    String userId, {
    String? worldId,
    required void Function(ChronicleModel chronicle) onInsert,
  }) {
    final channelName = worldId != null
        ? 'chronicles:$userId:$worldId'
        : 'chronicles:$userId';

    var channel = _client.channel(channelName).onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: _tableName,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            final chronicle = ChronicleModel.fromJson(payload.newRecord);
            if (worldId == null || chronicle.worldId == worldId) {
              onInsert(chronicle);
            }
          },
        );

    return channel.subscribe();
  }
}

/// Provider for ChronicleRepository
@riverpod
ChronicleRepository chronicleRepository(Ref ref) {
  return ChronicleRepository(SupabaseService.client);
}

/// Provider for user's chronicles
@riverpod
Future<List<ChronicleModel>> userChronicles(
  Ref ref,
  String userId, {
  int? limit,
}) async {
  final repository = ref.watch(chronicleRepositoryProvider);
  return repository.getUserChronicles(userId, limit: limit);
}

/// Provider for world chronicles
@riverpod
Future<List<ChronicleModel>> worldChronicles(
  Ref ref,
  String userId,
  String worldId, {
  int? limit,
}) async {
  final repository = ref.watch(chronicleRepositoryProvider);
  return repository.getWorldChronicles(userId, worldId, limit: limit);
}
