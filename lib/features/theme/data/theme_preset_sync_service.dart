import '../domain/theme_preset.dart';
import 'theme_preset_remote_data_source.dart';
import 'theme_preset_local_store.dart';

class ThemePresetSyncService {
  ThemePresetSyncService({
    ThemePresetLocalStore? localStore,
    ThemePresetRemoteDataSource? remote,
  })  : _localStore = localStore ?? ThemePresetLocalStore(),
        _remote = remote ?? ThemePresetRemoteDataSource();

  final ThemePresetLocalStore _localStore;
  final ThemePresetRemoteDataSource _remote;

  Future<List<ThemePreset>> pullAndMerge() async {
    final local = await _localStore.loadPresets();
    if (!_remote.canUse) return local;

    final remote = await _remote.fetchPresets();

    final byId = <String, ThemePreset>{
      for (final p in local) p.id: p,
    };

    for (final r in remote) {
      final l = byId[r.id];
      if (l == null) {
        byId[r.id] = r;
        continue;
      }

      final lt = l.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final rt = r.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      byId[r.id] = rt.isAfter(lt) ? r : l;
    }

    final merged = byId.values.toList()
      ..sort((a, b) => (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));

    await _localStore.savePresets(merged);
    return merged;
  }

  Future<List<ThemePreset>> pushPending() async {
    final local = await _localStore.loadPresets();
    if (!_remote.canUse) return local;

    final updated = <ThemePreset>[];

    for (final p in local) {
      if (!p.syncEnabled) {
        updated.add(p);
        continue;
      }

      if (!p.pendingSync) {
        updated.add(p);
        continue;
      }

      try {
        await _remote.upsertPreset(p);
        updated.add(p.copyWith(pendingSync: false));
      } catch (_) {
        updated.add(p);
      }
    }

    await _localStore.savePresets(updated);
    return updated;
  }

  Future<List<ThemePreset>> deleteRemoteIfNeeded(ThemePreset preset) async {
    if (!_remote.canUse) return _localStore.loadPresets();

    if (preset.syncEnabled) return _localStore.loadPresets();

    try {
      await _remote.softDeletePreset(preset.id);
    } catch (_) {}

    return _localStore.loadPresets();
  }
}
