import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

// 允许在 runApp 之前注入预加载值，避免启动时闪烁（system → 用户选择）。
AppThemeOption? _preloadedThemeOption;

void setPreloadedThemeOption(AppThemeOption? option) {
  _preloadedThemeOption = option;
}



/// Unified theme selection (merged ThemeMode + ColorScheme).

///

/// - The current themes are default light and default dark.

/// - Other options are sorted by Light palettes first, then Dark palettes.

/// - Persisted via SharedPreferences.

enum AppThemeOption {
  // Defaults
  defaultLight,
  defaultDark,

  // Special
  system,
}



class ThemeController extends StateNotifier<AppThemeOption> {

  ThemeController({required AppThemeOption initial}) : super(initial);



  static const _prefsKey = 'settings.theme';



  static Future<AppThemeOption> loadInitial() async {

    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(_prefsKey);

    switch (raw) {
      case 'defaultLight':
        return AppThemeOption.defaultLight;
      case 'defaultDark':
        return AppThemeOption.defaultDark;
      case 'system':
      default:
        return AppThemeOption.system;
    }

  }



  Future<void> setTheme(AppThemeOption option) async {

    state = option;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_prefsKey, option.name);

  }

}



final themeControllerBootstrapProvider = FutureProvider<AppThemeOption>((ref) async {

  return ThemeController.loadInitial();

});



final themeControllerProvider =

    StateNotifierProvider<ThemeController, AppThemeOption>((ref) {

  final controller =
      ThemeController(initial: _preloadedThemeOption ?? AppThemeOption.system);



  // 如果 main() 已经预加载并注入，则无需再异步读取，避免再次触发 state 变更。
  if (_preloadedThemeOption == null) {
    Future<void>(() async {

    final initial = await ThemeController.loadInitial();

    if (initial != controller.state) {
      controller.state = initial;

    }

    });
  }



  return controller;

});

