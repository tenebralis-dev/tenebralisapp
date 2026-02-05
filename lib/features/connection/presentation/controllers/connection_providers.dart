import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/cloud_connections_cache.dart';
import '../../data/cloud_connections_repository.dart';
import 'package:tenebralis_app/core/services/supabase_service.dart';
import '../../data/connection_secrets_store.dart';
import '../../data/connection_tester.dart';
import '../../data/models_fetcher.dart';
import '../../data/local_connections_store.dart';

final localConnectionsStoreProvider =
    Provider<LocalConnectionsStore>((_) => LocalConnectionsStore());
final cloudConnectionsCacheProvider =
    Provider<CloudConnectionsCache>((_) => CloudConnectionsCache());
final cloudConnectionsRepositoryProvider = Provider<CloudConnectionsRepository>(
  (ref) => CloudConnectionsRepository(SupabaseService.client),
);
final connectionSecretsStoreProvider =
    Provider<ConnectionSecretsStore>((_) => ConnectionSecretsStore());
final connectionTesterProvider =
    Provider<ConnectionTester>((_) => ConnectionTester());
final modelsFetcherProvider = Provider<ModelsFetcher>((_) => ModelsFetcher());
