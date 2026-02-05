import 'package:uuid/uuid.dart';

import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';
import 'theme_preset_local_store.dart';

class ThemePresetRepository {
  ThemePresetRepository({ThemePresetLocalStore? localStore})
      : _localStore = localStore ?? ThemePresetLocalStore();

  final ThemePresetLocalStore _localStore;
  final _uuid = const Uuid();

  Future<({List<ThemePreset> presets, String? activeId})> loadAll() async {
    final presets = await _localStore.loadPresets();
    final activeId = await _localStore.loadActivePresetId();
    return (presets: presets, activeId: activeId);
  }

  Future<List<ThemePreset>> savePreset({
    String? id,
    required String name,
    required ThemeTokens lightTokens,
    required ThemeTokens darkTokens,
    bool syncEnabled = false,
  }) async {
    final existing = await _localStore.loadPresets();
    final now = DateTime.now();

    final preset = ThemePreset(
      id: id ?? _uuid.v4(),
      name: name,
      schemaVersion: 2,
      lightTokens: lightTokens,
      darkTokens: darkTokens,
      syncEnabled: syncEnabled,
      pendingSync: syncEnabled,
      updatedAt: now,
    );

    final next = [
      for (final p in existing)
        if (p.id == preset.id) preset else p,
      if (!existing.any((p) => p.id == preset.id)) preset,
    ];

    await _localStore.savePresets(next);
    return next;
  }

  Future<List<ThemePreset>> deletePreset(String id) async {
    final existing = await _localStore.loadPresets();
    final next = existing.where((p) => p.id != id).toList();
    await _localStore.savePresets(next);

    final activeId = await _localStore.loadActivePresetId();
    if (activeId == id) {
      await _localStore.saveActivePresetId(null);
    }

    return next;
  }

  Future<void> setActivePresetId(String? id) async {
    await _localStore.saveActivePresetId(id);
  }
}
