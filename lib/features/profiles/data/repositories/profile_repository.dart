import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';
import '../models/profile_model.dart';
import '../models/relationship_model.dart';

part 'profile_repository.g.dart';

/// Profile Repository
/// Handles all profile-related database operations
class ProfileRepository {
  ProfileRepository(this._client);

  final SupabaseClient _client;

  static const String _tableName = 'profiles';
  static const String _relationshipsTable = 'relationships';

  /// Get profile by user ID
  Future<ProfileModel?> getProfile(String userId) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return ProfileModel.fromJson(response);
  }

  /// Create a new profile for a user
  Future<ProfileModel> createProfile(String userId) async {
    final data = {
      'id': userId,
      'global_points': 0,
      'preferences': const UserPreferences().toJson(),
      'inventory': const UserInventory().toJson(),
      'current_session': null,
    };

    final response =
        await _client.from(_tableName).insert(data).select().single();
    return ProfileModel.fromJson(response);
  }

  /// Update profile
  Future<ProfileModel> updateProfile(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    final response = await _client
        .from(_tableName)
        .update(updates)
        .eq('id', userId)
        .select()
        .single();
    return ProfileModel.fromJson(response);
  }

  /// Update global points
  Future<ProfileModel> updateGlobalPoints(String userId, int delta) async {
    // Get current points
    final current = await getProfile(userId);
    final newPoints = (current?.globalPoints ?? 0) + delta;

    return updateProfile(userId, {'global_points': newPoints});
  }

  /// Update user preferences
  Future<ProfileModel> updatePreferences(
    String userId,
    UserPreferences preferences,
  ) async {
    return updateProfile(userId, {'preferences': preferences.toJson()});
  }

  /// Update user inventory
  Future<ProfileModel> updateInventory(
    String userId,
    UserInventory inventory,
  ) async {
    return updateProfile(userId, {'inventory': inventory.toJson()});
  }

  /// Update current session
  Future<ProfileModel> updateSession(
    String userId,
    SessionState? session,
  ) async {
    return updateProfile(userId, {'current_session': session?.toJson()});
  }

  /// Get all relationships for a user in a world
  Future<List<RelationshipModel>> getRelationships(
    String userId,
    String worldId,
  ) async {
    final response = await _client
        .from(_relationshipsTable)
        .select()
        .eq('user_id', userId)
        .eq('world_id', worldId);

    return (response as List)
        .map((e) => RelationshipModel.fromJson(e))
        .toList();
  }

  /// Get specific relationship
  Future<RelationshipModel?> getRelationship(
    String userId,
    String worldId,
    RelationshipTargetType targetType,
    String targetKey,
  ) async {
    final response = await _client
        .from(_relationshipsTable)
        .select()
        .eq('user_id', userId)
        .eq('world_id', worldId)
        .eq('target_type', targetType.name)
        .eq('target_key', targetKey)
        .maybeSingle();

    if (response == null) return null;
    return RelationshipModel.fromJson(response);
  }

  /// Create or update relationship
  Future<RelationshipModel> upsertRelationship(
    RelationshipModel relationship,
  ) async {
    final data = relationship.toJson();
    data.remove('id'); // Let database generate ID
    data.remove('created_at');
    data.remove('updated_at');

    final response = await _client
        .from(_relationshipsTable)
        .upsert(
          data,
          onConflict: 'user_id,world_id,target_type,target_key',
        )
        .select()
        .single();

    return RelationshipModel.fromJson(response);
  }

  /// Update relationship value (affection or quest progress)
  Future<RelationshipModel> updateRelationshipValue(
    String userId,
    String worldId,
    RelationshipTargetType targetType,
    String targetKey,
    int delta,
  ) async {
    final current =
        await getRelationship(userId, worldId, targetType, targetKey);

    if (current != null) {
      final newValue = current.value + delta;
      final response = await _client
          .from(_relationshipsTable)
          .update({'value': newValue})
          .eq('id', current.id)
          .select()
          .single();
      return RelationshipModel.fromJson(response);
    } else {
      // Create new relationship
      return upsertRelationship(
        RelationshipModel(
          id: '', // Will be generated
          userId: userId,
          worldId: worldId,
          targetType: targetType,
          targetKey: targetKey,
          value: delta,
        ),
      );
    }
  }

  /// Subscribe to profile changes
  RealtimeChannel subscribeToProfile(
    String userId, {
    required void Function(ProfileModel profile) onUpdate,
  }) {
    return _client
        .channel('profile:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: _tableName,
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: userId,
          ),
          callback: (payload) {
            onUpdate(ProfileModel.fromJson(payload.newRecord));
          },
        )
        .subscribe();
  }
}

/// Provider for ProfileRepository
@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(SupabaseService.client);
}

/// Provider for current user's profile
@riverpod
Future<ProfileModel?> currentProfile(Ref ref) async {
  final user = SupabaseService.currentUser;
  if (user == null) return null;

  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile(user.id);
}
