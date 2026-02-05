import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/debug/agent_log.dart';
import '../../data/theme_preset_repository.dart';
import '../../data/theme_preset_sync_service.dart';
import '../../domain/theme_preset.dart';
import '../../domain/theme_tokens.dart';
import '../theme_scheme_builder.dart';
import '../theme_utils.dart';

extension _FirstOrNullExt<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class ThemePresetsState {
  const ThemePresetsState({
    required this.presets,
    required this.activePresetId,
  });

  final List<ThemePreset> presets;
  final String? activePresetId;

  ThemePreset? get activePreset {
    if (activePresetId == null) return null;
    return presets.where((p) => p.id == activePresetId).firstOrNull;
  }
}

class ThemePresetsController extends StateNotifier<AsyncValue<ThemePresetsState>> {
  ThemePresetsController({
    ThemePresetRepository? repository,
    ThemePresetSyncService? syncService,
  })  : _repository = repository ?? ThemePresetRepository(),
        _syncService = syncService ?? ThemePresetSyncService(),
        super(const AsyncValue.loading()) {
    _load();
  }

  final ThemePresetRepository _repository;
  final ThemePresetSyncService _syncService;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.loadAll();

      // Pull remote & merge when available.
      var presets = await _syncService.pullAndMerge();

      // Push pending items.
      presets = await _syncService.pushPending();

      // Keep active preset id stable:
      // - If activeId is null, keep it null (no implicit activation)
      // - If activeId exists but the preset was deleted, clear it
      final activeId = data.activeId;
      final activeExists =
          activeId == null ? false : presets.any((p) => p.id == activeId);
      final effectiveActiveId = (activeId != null && !activeExists)
          ? null
          : activeId;

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
        runId: 'run1',
        hypothesisId: 'H4',
        location: 'theme_presets_controller.dart:_load',
        message: 'loadResult',
        data: {
          'repoActiveId': activeId,
          'activeExistsInPresets': activeExists,
          'effectiveActiveId': effectiveActiveId,
          'presetsCount': presets.length,
        },
      );
      // #endregion

      state = AsyncValue.data(
        ThemePresetsState(presets: presets, activePresetId: effectiveActiveId),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createOrUpdatePreset({
    String? id,
    required String name,
    required ThemeTokens lightTokens,
    required ThemeTokens darkTokens,
    bool syncEnabled = false,
  }) async {
    final current = state.valueOrNull;
    try {
      var presets = await _repository.savePreset(
        id: id,
        name: name,
        lightTokens: lightTokens,
        darkTokens: darkTokens,
        syncEnabled: syncEnabled,
      );

      // Best-effort push.
      presets = await _syncService.pushPending();

      state = AsyncValue.data(
        ThemePresetsState(
          presets: presets,
          activePresetId: current?.activePresetId,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deletePreset(String id) async {
    final current = state.valueOrNull;
    try {
      final toDelete = current?.presets.where((p) => p.id == id).firstOrNull;

      final presets = await _repository.deletePreset(id);

      // Best-effort remote soft delete when the preset was sync-enabled.
      if (toDelete != null && toDelete.syncEnabled) {
        try {
          await _syncService.deleteRemoteIfNeeded(
              toDelete.copyWith(syncEnabled: false));
        } catch (_) {}
      }

      final nextActive =
          (current?.activePresetId == id) ? null : current?.activePresetId;
      state = AsyncValue.data(
        ThemePresetsState(presets: presets, activePresetId: nextActive),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String?> duplicateFromBuiltin(ThemePreset builtin,
      {String? nameOverride, bool syncEnabled = false}) async {
    // Create a new user preset from a built-in preset.
    final name = nameOverride ?? builtin.name;

    final current = state.valueOrNull;
    try {
      var presets = await _repository.savePreset(
        name: name,
        lightTokens: builtin.lightTokens,
        darkTokens: builtin.darkTokens,
        syncEnabled: syncEnabled,
      );

      // Best-effort push.
      presets = await _syncService.pushPending();

      state = AsyncValue.data(
        ThemePresetsState(
          presets: presets,
          activePresetId: current?.activePresetId,
        ),
      );

      // Return the created preset id (best effort: last updated).
      presets.sort((a, b) =>
          (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
      return presets.firstOrNull?.id;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> applyBuiltinAsUserPreset(ThemePreset builtin) async {
    // "Apply" built-in: persist as a user preset then activate it.
    final id = await duplicateFromBuiltin(
      builtin,
      nameOverride: '（预置）${builtin.name}',
      syncEnabled: false,
    );
    if (id == null) return;
    await setActivePreset(id);
  }

  Future<void> setActivePreset(String? id) async {
    final current = state.valueOrNull;
    if (current == null) return;

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run1',
      hypothesisId: 'H2',
      location: 'theme_presets_controller.dart:setActivePreset',
      message: 'beforePersistActive',
      data: {
        'nextActiveId': id,
        'prevActiveId': current.activePresetId,
        'presetsCount': current.presets.length,
      },
    );
    // #endregion

    await _repository.setActivePresetId(id);

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run1',
      hypothesisId: 'H2',
      location: 'theme_presets_controller.dart:setActivePreset',
      message: 'afterPersistActive',
      data: {
        'nextActiveId': id,
      },
    );
    // #endregion

    state = AsyncValue.data(
      ThemePresetsState(presets: current.presets, activePresetId: id),
    );
  }

  ThemeData applyActivePresetToTheme(ThemeData base, Brightness brightness) {
    final current = state.valueOrNull;
    final active = current?.activePreset;

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run1',
      hypothesisId: 'H3',
      location: 'theme_presets_controller.dart:applyActivePresetToTheme',
      message: 'applyThemeAttempt',
      data: {
        'brightness': brightness.name,
        'activePresetId': current?.activePresetId,
        'activeFound': active != null,
      },
    );
    // #endregion

    if (active == null) return base;

    final scheme = buildColorSchemeFromTokens(
      brightness == Brightness.dark ? active.darkTokens : active.lightTokens,
      brightness,
    );

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run1',
      hypothesisId: 'H5',
      location: 'theme_presets_controller.dart:applyActivePresetToTheme',
      message: 'schemeSummary',
      data: {
        'brightness': brightness.name,
        'primary': scheme.primary.value.toRadixString(16),
        'secondary': scheme.secondary.value.toRadixString(16),
        'surface': scheme.surface.value.toRadixString(16),
        'background': scheme.background.value.toRadixString(16),
      },
    );
    // #endregion

    // Keep component theming centralized; only override scheme + scaffold bg
    // here. Further component tweaks should live in theme_data_builder.
    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
    );
  }
}

final themePresetsControllerProvider =
    StateNotifierProvider<ThemePresetsController, AsyncValue<ThemePresetsState>>(
        (ref) {
  return ThemePresetsController();
});
