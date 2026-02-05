import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/api_connection.dart';
import '../connection_editor_page.dart';

import 'connection_providers.dart';

class ConnectionsListState {
  ConnectionsListState({
    required this.cloud,
    required this.local,
  });

  final List<CloudApiConnection> cloud;
  final List<LocalApiConnection> local;
}

final connectionsListControllerProvider =
    AsyncNotifierProvider.autoDispose<ConnectionsListController, ConnectionsListState>(
  ConnectionsListController.new,
);

class ConnectionsListController extends AutoDisposeAsyncNotifier<ConnectionsListState> {
  @override
  Future<ConnectionsListState> build() async {
    final localStore = ref.read(localConnectionsStoreProvider);
    final cache = ref.read(cloudConnectionsCacheProvider);

    // 1) Load local + cached cloud synchronously
    final local = await localStore.list();
    final cachedCloud = await cache.list();

    // 2) Start background refresh for cloud
    _refreshCloudInBackground();

    return ConnectionsListState(cloud: cachedCloud, local: local);
  }

  Future<void> refreshAll() async {
    state = const AsyncLoading();

    final localStore = ref.read(localConnectionsStoreProvider);
    final repo = ref.read(cloudConnectionsRepositoryProvider);
    final cache = ref.read(cloudConnectionsCacheProvider);

    final local = await localStore.list();
    final cloud = await repo.list();
    await cache.putAll(cloud);

    state = AsyncData(ConnectionsListState(cloud: cloud, local: local));
  }

  void _refreshCloudInBackground() {
    Future(() async {
      try {
        final repo = ref.read(cloudConnectionsRepositoryProvider);
        final cache = ref.read(cloudConnectionsCacheProvider);
        final cloud = await repo.list();
        await cache.putAll(cloud);

        final current = state.valueOrNull;
        if (current == null) return;
        state = AsyncData(ConnectionsListState(cloud: cloud, local: current.local));
      } catch (_) {
        // ignore background errors; UI can show cached.
      }
    });
  }

  Future<void> toggleActive({
    required ConnectionListItem item,
    required bool isActive,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;

    await item.when(
      cloud: (connection) async {
        final repo = ref.read(cloudConnectionsRepositoryProvider);
        final cache = ref.read(cloudConnectionsCacheProvider);
        final updated = await repo.update(
          id: connection.id,
          base: connection.base.copyWith(isActive: isActive),
        );
        await cache.upsert(updated);

        final nextCloud = [
          for (final c in current.cloud)
            if (c.id == updated.id) updated else c,
        ];
        state = AsyncData(ConnectionsListState(cloud: nextCloud, local: current.local));
      },
      local: (connection) async {
        final store = ref.read(localConnectionsStoreProvider);
        final updated = connection.copyWith(
          base: connection.base.copyWith(isActive: isActive),
          updatedAt: DateTime.now(),
        );
        await store.upsert(updated);

        final nextLocal = [
          for (final c in current.local)
            if (c.localId == updated.localId) updated else c,
        ];
        state = AsyncData(ConnectionsListState(cloud: current.cloud, local: nextLocal));
      },
    );
  }

  Future<void> openEditor({
    required ConnectionListItem item,
    required BuildContext context,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConnectionEditorPage(editing: item),
      ),
    );
    await refreshAll();
  }

  Future<void> delete(ConnectionListItem item) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final secrets = ref.read(connectionSecretsStoreProvider);

    await item.when(
      cloud: (connection) async {
        final repo = ref.read(cloudConnectionsRepositoryProvider);
        final cache = ref.read(cloudConnectionsCacheProvider);
        await repo.delete(connection.id);
        await cache.delete(connection.id);
        await secrets.deleteApiKey('cloud:${connection.id}');

        state = AsyncData(
          ConnectionsListState(
            cloud: current.cloud.where((c) => c.id != connection.id).toList(),
            local: current.local,
          ),
        );
      },
      local: (connection) async {
        final store = ref.read(localConnectionsStoreProvider);
        await store.delete(connection.localId);
        await secrets.deleteApiKey('local:${connection.localId}');

        state = AsyncData(
          ConnectionsListState(
            cloud: current.cloud,
            local: current.local.where((c) => c.localId != connection.localId).toList(),
          ),
        );
      },
    );
  }

  Future<void> copyToLocal({required ConnectionListItem item}) async {
    final current = state.valueOrNull;
    if (current == null) return;

    if (item is! ConnectionListItem) return;
    if (item.whenOrNull(cloud: (_) => true) != true) return;

    final uuid = const Uuid().v4();
    final localStore = ref.read(localConnectionsStoreProvider);
    final secrets = ref.read(connectionSecretsStoreProvider);

    final cloud = item.when(
      cloud: (c) => c,
      local: (_) => throw StateError('Expected cloud item'),
    );

    final local = LocalApiConnection(
      localId: uuid,
      base: cloud.base,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      copiedFromCloudId: cloud.id,
    );

    await localStore.upsert(local);
    await secrets.copyApiKey(fromRef: 'cloud:${cloud.id}', toRef: 'local:$uuid');

    state = AsyncData(
      ConnectionsListState(
        cloud: current.cloud,
        local: [local, ...current.local],
      ),
    );
  }

  Future<void> quickTest({
    required ConnectionListItem item,
    required BuildContext context,
  }) async {
    final secrets = ref.read(connectionSecretsStoreProvider);
    final tester = ref.read(connectionTesterProvider);

    final (refKey, base) = item.when(
      cloud: (connection) => ('cloud:${connection.id}', connection.base),
      local: (connection) => ('local:${connection.localId}', connection.base),
    );

    final key = await secrets.readApiKey(refKey);
    if (key == null || key.trim().isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('缺少密钥：请先编辑连接填写密钥')), 
        );
      }
      return;
    }

    try {
      final result = await tester.test(base: base, apiKey: key);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ 可用（${result.latency}ms）${result.model == null ? '' : ' model=${result.model}'}')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ 测试失败：$e')),
      );
    }
  }
}
