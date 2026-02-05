import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/icon_customization_prefs.dart';
import '../../domain/icon_customization.dart';

/// icon 自定义映射表（key: appKey）。
class IconCustomizationController
    extends AutoDisposeAsyncNotifier<Map<String, IconCustomization>> {
  @override
  Future<Map<String, IconCustomization>> build() async {
    final prefs = await ref.watch(iconCustomizationPrefsProvider.future);
    final map = await prefs.loadAll();

    return map;
  }

  IconCustomization? getFor(String appKey) {
    final v = state.valueOrNull;
    return v?[appKey];
  }

  bool hasCustomization(String appKey) {
    final v = state.valueOrNull;
    return v != null && v.containsKey(appKey);
  }

  Future<void> setCustomization(IconCustomization customization) async {
    final current = state.valueOrNull ?? const <String, IconCustomization>{};
    final next = {...current, customization.appKey: customization};

    state = AsyncValue.data(next);

    final prefs = await ref.watch(iconCustomizationPrefsProvider.future);
    await prefs.saveAll(next);
  }

  Future<void> removeCustomization(String appKey) async {
    final current = state.valueOrNull;
    if (current == null || !current.containsKey(appKey)) return;

    final next = {...current}..remove(appKey);
    state = AsyncValue.data(next);

    final prefs = await ref.watch(iconCustomizationPrefsProvider.future);
    await prefs.saveAll(next);
  }

  Future<void> clearAll() async {
    state = const AsyncValue.data({});

    final prefs = await ref.watch(iconCustomizationPrefsProvider.future);
    await prefs.clearAll();
  }
}

final iconCustomizationControllerProvider = AsyncNotifierProvider.autoDispose<
    IconCustomizationController, Map<String, IconCustomization>>(
  IconCustomizationController.new,
);

/// Dock 任意 icon 是否存在自定义配置。
///
/// 规则：只要 Dock 内任意一个 icon 被自定义（预设/本地图片/URL 任一），
/// 就去除整个 Dock 的默认背景。
final dockHasAnyCustomIconProvider = Provider.family<bool, List<String>>(
  (ref, dockKeys) {
    final map = ref.watch(iconCustomizationControllerProvider).valueOrNull;
    if (map == null || map.isEmpty) return false;

    for (final key in dockKeys) {
      if (map.containsKey(key)) return true;
    }
    return false;
  },
);
