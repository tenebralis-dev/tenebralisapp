import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import 'host_profile.dart';

part 'users_repository.g.dart';

class UsersRepository {
  UsersRepository(this._client);

  final SupabaseClient _client;

  static const _table = 'users';

  Future<HostProfile?> getCurrent() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final row = await _client.from(_table).select().eq('id', user.id).maybeSingle();
    if (row == null) return null;
    return HostProfile.fromJson(row);
  }

  Future<HostProfile> updateCurrent({
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw const AuthException('Not authenticated');

    final patch = <String, dynamic>{};
    if (displayName != null) patch['display_name'] = displayName;
    if (avatarUrl != null) patch['avatar_url'] = avatarUrl;
    if (bio != null) patch['bio'] = bio;

    final row = await _client
        .from(_table)
        .update(patch)
        .eq('id', user.id)
        .select()
        .single();

    return HostProfile.fromJson(row);
  }
}

@riverpod
UsersRepository usersRepository(Ref ref) {
  return UsersRepository(SupabaseService.client);
}

@riverpod
Future<HostProfile?> currentHostProfile(Ref ref) async {
  final repo = ref.watch(usersRepositoryProvider);
  return repo.getCurrent();
}
