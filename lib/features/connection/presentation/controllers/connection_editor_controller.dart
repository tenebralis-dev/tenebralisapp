import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/api_connection.dart';

import 'connection_providers.dart';

class ConnectionEditorState {
  ConnectionEditorState({
    required this.saveToCloud,
    required this.base,
    required this.isTesting,
    required this.isFetchingModels,
    required this.models,
    this.apiKey,
    this.editing,
  });

  final bool saveToCloud;
  final ApiConnectionBase base;
  final bool isTesting;
  final bool isFetchingModels;
  final List<String> models;
  final String? apiKey;

  /// Existing item if editing.
  final ConnectionListItem? editing;

  ConnectionEditorState copyWith({
    bool? saveToCloud,
    ApiConnectionBase? base,
    bool? isTesting,
    bool? isFetchingModels,
    List<String>? models,
    String? apiKey,
    ConnectionListItem? editing,
  }) {
    return ConnectionEditorState(
      saveToCloud: saveToCloud ?? this.saveToCloud,
      base: base ?? this.base,
      isTesting: isTesting ?? this.isTesting,
      isFetchingModels: isFetchingModels ?? this.isFetchingModels,
      models: models ?? this.models,
      apiKey: apiKey ?? this.apiKey,
      editing: editing ?? this.editing,
    );
  }
}

final connectionEditorControllerProvider =
    AsyncNotifierProvider.autoDispose<ConnectionEditorController, ConnectionEditorState>(
  ConnectionEditorController.new,
);

class ConnectionEditorController extends AutoDisposeAsyncNotifier<ConnectionEditorState> {
  @override
  Future<ConnectionEditorState> build() async {
    return ConnectionEditorState(
      saveToCloud: false,
      base: ApiConnectionBase(
        name: '',
        serviceType: ApiServiceType.openaiCompat,
        baseUrl: '',
      ),
      isTesting: false,
      isFetchingModels: false,
      models: const [],
    );
  }

  Future<void> load(ConnectionListItem? editing) async {
    final current = await future;
    if (editing == null) {
      state = AsyncData(current.copyWith(editing: null));
      return;
    }

    final secrets = ref.read(connectionSecretsStoreProvider);

    await editing.when(
      cloud: (connection) async {
        final key = await secrets.readApiKey('cloud:${connection.id}');
        state = AsyncData(
          current.copyWith(
            saveToCloud: true,
            base: connection.base,
            apiKey: key,
            editing: editing,
            models: const [],
          ),
        );
      },
      local: (connection) async {
        final key = await secrets.readApiKey('local:${connection.localId}');
        state = AsyncData(
          current.copyWith(
            saveToCloud: false,
            base: connection.base,
            apiKey: key,
            editing: editing,
            models: const [],
          ),
        );
      },
    );
  }

  void setSaveToCloud(bool v) {
    final current = state.valueOrNull;
    if (current == null) return;

    // Editing cloud -> local should become "copy & keep" semantics.
    // We keep editing reference but save() will create a local copy.
    state = AsyncData(current.copyWith(saveToCloud: v));
  }

  void updateBase(ApiConnectionBase base) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(base: base));
  }

  String? validate({required ApiConnectionBase base, required String apiKey}) {
    if (base.name.trim().isEmpty) return '名称不能为空';
    final url = base.baseUrl.trim();
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http')) {
      return 'Base URL 不是有效的 http/https URL';
    }
    if (uri.host.isEmpty) return 'Base URL 缺少 host';

    // Best effort: prevent auth headers in template.
    final headerKeys = base.headersTemplate.keys
        .map((k) => k.toString().toLowerCase())
        .toSet();
    if (headerKeys.contains('authorization') || headerKeys.contains('x-api-key')) {
      return 'headers_template_json 禁止包含 authorization/x-api-key（密钥仅本地存储）';
    }

    if (apiKey.trim().isEmpty) return '密钥不能为空';
    if (apiKey.trim().length <= 10) return '密钥长度不够：请检查是否完整';

    return null;
  }

  Future<void> save({required ApiConnectionBase base, String? apiKey}) async {
    final current = await future;
    final key = apiKey?.trim();

    final secrets = ref.read(connectionSecretsStoreProvider);
    final localStore = ref.read(localConnectionsStoreProvider);
    final cloudRepo = ref.read(cloudConnectionsRepositoryProvider);
    final cloudCache = ref.read(cloudConnectionsCacheProvider);

    final now = DateTime.now();

    // When saveToCloud is true: save/update in cloud.
    // When false: save/update in local.
    // Special case: editing cloud but saveToCloud=false => copy to local (keep cloud).

    if (current.saveToCloud) {
      // Cloud save.
      final editing = current.editing;
      if (editing != null && editing.whenOrNull(cloud: (_) => true) == true) {
        final connection = editing.when(
          cloud: (c) => c,
          local: (_) => throw StateError('Expected cloud item'),
        );
        final updated = await cloudRepo.update(id: connection.id, base: base);
        await cloudCache.upsert(updated);
        if (key != null && key.isNotEmpty) {
          await secrets.writeApiKey('cloud:${updated.id}', key);
        }
        state = AsyncData(current.copyWith(base: updated.base, apiKey: key));
        return;
      }

      // If editing local and toggled to cloud, create new cloud record.
      final created = await cloudRepo.create(base: base);
      await cloudCache.upsert(created);
      if (key != null && key.isNotEmpty) {
        await secrets.writeApiKey('cloud:${created.id}', key);
      }
      state = AsyncData(current.copyWith(base: created.base, apiKey: key));
      return;
    }

    // Local save.
    final editing = current.editing;
    if (editing != null && editing.whenOrNull(local: (_) => true) == true) {
      final connection = editing.when(
        cloud: (_) => throw StateError('Expected local item'),
        local: (c) => c,
      );
      final updated = connection.copyWith(base: base, updatedAt: now);
      await localStore.upsert(updated);
      if (key != null && key.isNotEmpty) {
        await secrets.writeApiKey('local:${updated.localId}', key);
      }
      state = AsyncData(current.copyWith(base: updated.base, apiKey: key));
      return;
    }

    if (editing != null && editing.whenOrNull(cloud: (_) => true) == true) {
      final connection = editing.when(
        cloud: (c) => c,
        local: (_) => throw StateError('Expected cloud item'),
      );

      // Copy & keep cloud.
      final newId = const Uuid().v4();
      final local = LocalApiConnection(
        localId: newId,
        base: base,
        createdAt: now,
        updatedAt: now,
        copiedFromCloudId: connection.id,
      );
      await localStore.upsert(local);
      await secrets.copyApiKey(fromRef: 'cloud:${connection.id}', toRef: 'local:$newId');
      if (key != null && key.isNotEmpty) {
        await secrets.writeApiKey('local:$newId', key);
      }
      return;
    }

    // New local connection.
    final newId = const Uuid().v4();
    final local = LocalApiConnection(
      localId: newId,
      base: base,
      createdAt: now,
      updatedAt: now,
    );
    await localStore.upsert(local);
    if (key != null && key.isNotEmpty) {
      await secrets.writeApiKey('local:$newId', key);
    }

    // Update UI state so editor stays consistent.
    final nowState = state.valueOrNull;
    if (nowState != null) {
      state = AsyncData(nowState.copyWith(base: base, apiKey: key));
    }
  }

  Future<List<String>> fetchModels({
    required ApiConnectionBase base,
    required String apiKey,
  }) async {
    final current = state.valueOrNull;
    if (current == null) throw Exception('状态未初始化');

    state = AsyncData(current.copyWith(isFetchingModels: true));
    try {
      final fetcher = ref.read(modelsFetcherProvider);
      final models = await fetcher.fetch(base: base, apiKey: apiKey);
      final now = state.valueOrNull;
      if (now != null) {
        state = AsyncData(now.copyWith(models: models, isFetchingModels: false));
      }
      return models;
    } finally {
      final now = state.valueOrNull;
      if (now != null) {
        state = AsyncData(now.copyWith(isFetchingModels: false));
      }
    }
  }

  Future<({String? model, int latency})> test({
    required ApiConnectionBase base,
    required String apiKey,
  }) async {
    final current = state.valueOrNull;
    if (current == null) throw Exception('状态未初始化');

    state = AsyncData(current.copyWith(isTesting: true));
    try {
      final tester = ref.read(connectionTesterProvider);
      return await tester.test(base: base, apiKey: apiKey);
    } finally {
      final now = state.valueOrNull;
      if (now != null) {
        state = AsyncData(now.copyWith(isTesting: false));
      }
    }
  }
}
