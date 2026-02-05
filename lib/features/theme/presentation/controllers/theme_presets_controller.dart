import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/debug/agent_log.dart';
import '../../data/theme_preset_repository.dart';
import '../../data/theme_preset_sync_service.dart';
import '../../domain/theme_preset.dart';
import '../../domain/theme_tokens.dart';
import '../../domain/theme_preset_defaults.dart';
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
  /// 创建控制器。
  /// 
  /// [initialState] 可选：如果提供了预加载的初始状态，
  /// 将直接使用该状态，避免首帧渲染时出现闪烁。
  ThemePresetsController({
    ThemePresetRepository? repository,
    ThemePresetSyncService? syncService,
    ThemePresetsState? initialState,
  })  : _repository = repository ?? ThemePresetRepository(),
        _syncService = syncService ?? ThemePresetSyncService(),
        super(initialState != null 
            ? AsyncValue.data(initialState) 
            : const AsyncValue.loading()) {
    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H4',
      location: 'theme_presets_controller.dart:ctor',
      message: 'controllerInit',
      data: {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'hasInitialState': initialState != null,
        'initialActivePresetId': initialState?.activePresetId,
      },
    );
    // #endregion
    
    // 如果有初始状态，设置 _lastKnownState 以支持后续回退
    if (initialState != null) {
      _lastKnownState = initialState;
    }
    
    _load(skipLocalIfPreloaded: initialState != null);
  }

  final ThemePresetRepository _repository;
  final ThemePresetSyncService _syncService;

  // 用于首帧回退：当 state 处于 loading 时，仍可用上一次已知的值避免闪烁。
  ThemePresetsState? _lastKnownState;

  // #region agent log
  bool get hasLastKnownState => _lastKnownState != null;
  // #endregion

  Future<void> _load({bool skipLocalIfPreloaded = false}) async {
    // #region agent log
    final loadStart = DateTime.now().millisecondsSinceEpoch;
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H1,H2',
      location: 'theme_presets_controller.dart:_load',
      message: 'loadStart',
      data: {
        'loadStartTimestamp': loadStart,
        'skipLocalIfPreloaded': skipLocalIfPreloaded,
      },
    );
    // #endregion

    // 如果已有预加载数据，跳过本地加载步骤，直接进行远端同步
    if (!skipLocalIfPreloaded) {
      state = const AsyncValue.loading();
    }
    
    try {
      final data = await _repository.loadAll();

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H2,H5',
      location: 'theme_presets_controller.dart:_load',
      message: 'afterLoadAll',
        data: {
          'activeId': data.activeId,
          'localPresetsCount': data.presets.length,
          'elapsedMs': DateTime.now().millisecondsSinceEpoch - loadStart,
        },
      );
      // #endregion

      // 先让本地主题立即生效，避免启动时“默认→自定义”的闪烁。
      // 远端 pull/merge 将在后面继续执行，并在必要时刷新 state。
      final localState = ThemePresetsState(
        presets: data.presets,
        activePresetId: data.activeId,
      );
      _lastKnownState = localState;

      state = AsyncValue.data(localState);

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H1,H5',
      location: 'theme_presets_controller.dart:_load',
      message: 'stateReadyLocal',
      data: {
          'activeId': data.activeId,
          'presetsCount': data.presets.length,
          'lastKnownStateSet': _lastKnownState != null,
          'elapsedMs': DateTime.now().millisecondsSinceEpoch - loadStart,
        },
      );
      // #endregion

      // Pull remote & merge when available.
      var presets = await _syncService.pullAndMerge();

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H3',
      location: 'theme_presets_controller.dart:_load',
      message: 'afterPullAndMerge',
        data: {
          'mergedPresetsCount': presets.length,
          'elapsedMs': DateTime.now().millisecondsSinceEpoch - loadStart,
        },
      );
      // #endregion

      // Push pending items.
      presets = await _syncService.pushPending();

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H3',
      location: 'theme_presets_controller.dart:_load',
      message: 'afterPushPending',
        data: {
          'presetsCount': presets.length,
          'elapsedMs': DateTime.now().millisecondsSinceEpoch - loadStart,
        },
      );
      // #endregion

      // Keep active preset id stable:
      // - If activeId is null, keep it null (no implicit activation)
      // - If activeId exists but the preset was deleted, clear it
      final activeId = data.activeId;
      final activeExists =
          activeId == null ? false : presets.any((p) => p.id == activeId);
      final effectiveActiveId = (activeId != null && !activeExists)
          ? null
          : activeId;

      // 只有在远端合并结果与当前 state 有差异时才更新，减少不必要的重建。
      final current = state.valueOrNull;
      final shouldUpdate = current == null ||
          current.activePresetId != effectiveActiveId ||
          current.presets.length != presets.length;

      if (shouldUpdate) {
        final mergedState = ThemePresetsState(
          presets: presets,
          activePresetId: effectiveActiveId,
        );
        _lastKnownState = mergedState;
        state = AsyncValue.data(mergedState);
      }

      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H3',
      location: 'theme_presets_controller.dart:_load',
      message: 'stateReady',
        data: {
          'effectiveActiveId': effectiveActiveId,
          'presetsCount': presets.length,
          'elapsedMs': DateTime.now().millisecondsSinceEpoch - loadStart,
        },
      );
      // #endregion
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

    await _repository.setActivePresetId(id);

    state = AsyncValue.data(
      ThemePresetsState(presets: current.presets, activePresetId: id),
    );
  }

  /// 获取当前应该生效的 ColorScheme：
  /// - 有 active preset：使用 active preset 对应 brightness 的 tokens
  /// - 无 active preset：使用内置默认 tokens（作为全局唯一默认主题入口）
  ColorScheme activeColorScheme(Brightness brightness) {
    // 在 state 还处于 loading 的窗口期，valueOrNull 为 null。
    // 这会导致首帧使用 defaults，从而出现“默认→自定义”的跳变。
    // 因此：loading 时也回退到“上一次已知的 lastState”。
    final current = state.valueOrNull ?? _lastKnownState;
    final active = current?.activePreset;

    // #region agent log
    final usingDefaults = active == null;
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run2',
      hypothesisId: 'H1,H5',
      location: 'theme_presets_controller.dart:activeColorScheme',
      message: 'schemeResolution',
      data: {
        'brightness': brightness.toString(),
        'stateHasValue': state.valueOrNull != null,
        'lastKnownStateExists': _lastKnownState != null,
        'currentExists': current != null,
        'activePresetId': current?.activePresetId,
        'usingDefaults': usingDefaults,
      },
    );
    // #endregion

    ThemeTokens tokens;
    if (active != null) {
      tokens = brightness == Brightness.dark ? active.darkTokens : active.lightTokens;
    } else {
      tokens = brightness == Brightness.dark
          ? ThemePresetDefaults.darkTokens
          : ThemePresetDefaults.lightTokens;
    }

    final scheme = buildColorSchemeFromTokens(tokens, brightness);

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run3',
      hypothesisId: 'H6,H7,H8',
      location: 'theme_presets_controller.dart:activeColorScheme',
      message: 'schemeValues',
      data: {
        'brightness': brightness.toString(),
        'activePresetId': current?.activePresetId,
        'schemePrimary': scheme.primary.value,
        'schemeSecondary': scheme.secondary.value,
        'schemeBackground': scheme.background.value,
      },
    );
    // #endregion

    return scheme;
  }

  ThemeData applyActivePresetToTheme(ThemeData base, Brightness brightness) {
    // 保持兼容：如果还有旧调用者，依然能工作。
    // 但推荐直接用 activeColorScheme() + theme_data_builder 统一生成。
    final scheme = activeColorScheme(brightness);
    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
    );
  }

  /// 预加载主题数据（在 runApp 之前调用）。
  /// 
  /// 返回预加载的 [ThemePresetsState]，用于初始化 controller，
  /// 避免首帧渲染时因异步加载导致的闪烁。
  static Future<ThemePresetsState?> preload() async {
    try {
      final repository = ThemePresetRepository();
      final data = await repository.loadAll();
      
      // #region agent log
      AgentLog.log(
        sessionId: 'debug-session',
        runId: 'run2',
        hypothesisId: 'FIX',
        location: 'theme_presets_controller.dart:preload',
        message: 'preloadComplete',
        data: {
          'activeId': data.activeId,
          'presetsCount': data.presets.length,
        },
      );
      // #endregion
      
      return ThemePresetsState(
        presets: data.presets,
        activePresetId: data.activeId,
      );
    } catch (e) {
      // 预加载失败时返回 null，让 controller 正常加载
      return null;
    }
  }
}

/// 预加载的主题状态（在 main() 中设置）
ThemePresetsState? _preloadedThemePresetsState;

/// 设置预加载的主题状态
void setPreloadedThemePresetsState(ThemePresetsState? state) {
  _preloadedThemePresetsState = state;
}

final themePresetsControllerProvider =
    StateNotifierProvider<ThemePresetsController, AsyncValue<ThemePresetsState>>(
        (ref) {
  return ThemePresetsController(initialState: _preloadedThemePresetsState);
});
