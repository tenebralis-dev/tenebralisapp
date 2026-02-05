import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/supabase_service.dart';
import '../data/models/world.dart';
import '../data/worlds_repository.dart';

part 'worlds_providers.g.dart';

@riverpod
WorldsRepository worldsRepository(Ref ref) {
  return WorldsRepository(SupabaseService.client);
}

@riverpod
Future<List<World>> myWorlds(Ref ref) async {
  final repo = ref.watch(worldsRepositoryProvider);
  return repo.listMyWorlds();
}
