import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';



/// Unified theme selection (merged ThemeMode + ColorScheme).

///

/// - The current themes are default light and default dark.

/// - Other options are sorted by Light palettes first, then Dark palettes.

/// - Persisted via SharedPreferences.

enum AppThemeOption {

  // Defaults

  defaultLight,

  defaultDark,



  // Light palettes

  rosaLight,

  slateLight,

  mintLight,

  lavenderLight,



  // Dark palettes

  kraftDark,



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

      case 'rosaLight':

        return AppThemeOption.rosaLight;

      case 'slateLight':

        return AppThemeOption.slateLight;

      case 'mintLight':

        return AppThemeOption.mintLight;

      case 'lavenderLight':

        return AppThemeOption.lavenderLight;

      case 'kraftDark':

        return AppThemeOption.kraftDark;

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

  final controller = ThemeController(initial: AppThemeOption.system);



  Future<void>(() async {

    final initial = await ThemeController.loadInitial();

    if (initial != controller.state) {

      controller.state = initial;

    }

  });



  return controller;

});

