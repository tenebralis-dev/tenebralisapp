import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';
import '../models/world_model.dart';

part 'world_repository.g.dart';

/// World Repository
/// Handles all world-related database operations
class WorldRepository {
  WorldRepository(this._client);

  final SupabaseClient _client;

  static const String _tableName = 'worlds';

  /// Get all public worlds
  Future<List<WorldModel>> getPublicWorlds() async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('is_public', true)
        .order('created_at', ascending: false);

    return (response as List).map((e) => WorldModel.fromJson(e)).toList();
  }

  /// Get worlds created by a user
  Future<List<WorldModel>> getUserWorlds(String userId) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('creator_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((e) => WorldModel.fromJson(e)).toList();
  }

  /// Get a specific world by ID
  Future<WorldModel?> getWorld(String worldId) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('id', worldId)
        .maybeSingle();

    if (response == null) return null;
    return WorldModel.fromJson(response);
  }

  /// Create a new world
  Future<WorldModel> createWorld(WorldModel world) async {
    final data = world.toJson();
    data.remove('id'); // Let database generate ID
    data.remove('created_at');
    data.remove('updated_at');

    final response =
        await _client.from(_tableName).insert(data).select().single();
    return WorldModel.fromJson(response);
  }

  /// Update a world
  Future<WorldModel> updateWorld(
    String worldId,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from(_tableName)
        .update(updates)
        .eq('id', worldId)
        .select()
        .single();
    return WorldModel.fromJson(response);
  }

  /// Delete a world
  Future<void> deleteWorld(String worldId) async {
    await _client.from(_tableName).delete().eq('id', worldId);
  }

  /// Search worlds by name or genre
  Future<List<WorldModel>> searchWorlds(String query) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('is_public', true)
        .or('name.ilike.%$query%,genre.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List).map((e) => WorldModel.fromJson(e)).toList();
  }

  /// Get worlds by genre
  Future<List<WorldModel>> getWorldsByGenre(String genre) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('is_public', true)
        .eq('genre', genre)
        .order('created_at', ascending: false);

    return (response as List).map((e) => WorldModel.fromJson(e)).toList();
  }
}

/// Provider for WorldRepository
@riverpod
WorldRepository worldRepository(Ref ref) {
  return WorldRepository(SupabaseService.client);
}

/// Provider for public worlds list
@riverpod
Future<List<WorldModel>> publicWorlds(Ref ref) async {
  final repository = ref.watch(worldRepositoryProvider);
  return repository.getPublicWorlds();
}

/// Provider for user's worlds
@riverpod
Future<List<WorldModel>> userWorlds(Ref ref, String userId) async {
  final repository = ref.watch(worldRepositoryProvider);
  return repository.getUserWorlds(userId);
}

/// Provider for a specific world
@riverpod
Future<WorldModel?> world(Ref ref, String worldId) async {
  final repository = ref.watch(worldRepositoryProvider);
  return repository.getWorld(worldId);
}
