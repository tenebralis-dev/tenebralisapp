import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide UserIdentity;

import '../../../core/services/supabase_service.dart';
import 'user_identity.dart';
import 'user_profile.dart';

part 'profile_repository.g.dart';

/// Legacy Profile repository (Auth-domain)
///
/// This was previously backed by `public.profiles`.
/// It is kept temporarily for compatibility, but SHOULD NOT be used by new code.
class ProfileRepository {
  ProfileRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'profiles';

  Future<UserProfile?> getProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final row = await _client.from(_table).select().eq('id', user.id).maybeSingle();
    if (row == null) return null;

    return UserProfile.fromJson(row);
  }

  Future<UserProfile> updateIdentity(UserIdentity newIdentity) async {
    final user = _client.auth.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final response = await _client
        .from(_table)
        .update({'current_session': newIdentity.toJson()})
        .eq('id', user.id)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  /// Optional helper: clear current session.
  Future<UserProfile> clearIdentity() async {
    final user = _client.auth.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final response = await _client
        .from(_table)
        .update({'current_session': null})
        .eq('id', user.id)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  /// Defensive helper: merge patch into existing current_session.
  Future<UserProfile> patchIdentity(Map<String, dynamic> patch) async {
    final profile = await getProfile();
    final current = profile?.currentSession?.toJson() ?? <String, dynamic>{};

    // Allow patch payload to be provided as JSON string.
    final safePatch = <String, dynamic>{};
    patch.forEach((k, v) {
      if (v is String) {
        try {
          final decoded = jsonDecode(v);
          safePatch[k] = decoded;
          return;
        } catch (_) {
          // ignore
        }
      }
      safePatch[k] = v;
    });

    final merged = {...current, ...safePatch};
    return updateIdentity(UserIdentity.fromJson(merged));
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(SupabaseService.client);
}

@riverpod
Future<UserProfile?> currentUserProfile(Ref ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile();
}
