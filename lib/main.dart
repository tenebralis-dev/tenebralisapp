import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/font_controller.dart';
import 'app/locale_controller.dart';
import 'app/router.dart';
import 'app/theme_controller.dart';
import 'app/ocean_dark_theme.dart';
import 'app/app_color_schemes.dart';
import 'app/system_ui.dart';
import 'app/theme_data_builder.dart';
import 'features/desktop/presentation/controllers/wallpaper_controller.dart';
import 'features/desktop/presentation/controllers/wallpaper_contrast_controller.dart';
import 'features/fonts/presentation/controllers/active_font_controller.dart';
import 'core/config/env_config.dart';
import 'core/services/supabase_service.dart';
import 'features/fonts/data/user_font_debug.dart';
import 'features/theme/presentation/controllers/theme_presets_controller.dart';
import 'core/debug/agent_log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load runtime env (.env).
  await EnvConfig.load();

  // Debug: dump local user font prefs on startup.
  // ignore: avoid_print
  // (kept as debugPrint in implementation)
  await UserFontDebug.dumpLocalPrefs();

  // Initialize Supabase (reads from EnvConfig).
  await SupabaseService.initialize();

  // Local storage (Hive) for connections cache/local-only configs.
  await Hive.initFlutter();

  runApp(const ProviderScope(child: TenebralisApp()));
}

class TenebralisApp extends ConsumerWidget {
  const TenebralisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeControllerProvider);

    // 关键点：主题必须直接 watch `fontControllerProvider`，
    // 才能在 setFont 后立即触发重建。
    // bootstrap provider 只负责初始化默认值。
    ref.watch(fontControllerBootstrapProvider);
    ref.watch(themeControllerBootstrapProvider);
    final fontFamily = ref.watch(fontControllerProvider);
    final themeOption = ref.watch(themeControllerProvider);

    final activeFontAsync = ref.watch(activeFontProvider);

    final ThemeData baseTheme = activeFontAsync.maybeWhen(
      data: (activeFont) => applyActiveFontToTheme(
        OceanDarkTheme.darkWithFont(fontFamily),
        activeFont,
      ),
      orElse: () => OceanDarkTheme.darkWithFont(fontFamily),
    );

    // Create base Light/Dark themes from current tokens output.
    // Note: baseTheme is still used as a fallback for dark mode.
    ThemeData buildThemed(ThemeData base, Brightness b) {
      return buildAppThemeData(
        scheme: base.colorScheme,
        brightness: b,
        fontFamily: fontFamily,
      );
    }

    final presetStateAsync = ref.watch(themePresetsControllerProvider);
    final presetsController = ref.read(themePresetsControllerProvider.notifier);

    // #region agent log
    AgentLog.log(
      sessionId: 'debug-session',
      runId: 'run1',
      hypothesisId: 'H1',
      location: 'main.dart:theme',
      message: 'themePresetsState',
      data: {
        'asyncType': presetStateAsync.runtimeType.toString(),
        'hasValue': presetStateAsync.valueOrNull != null,
        'activePresetId': presetStateAsync.valueOrNull?.activePresetId,
        'presetsCount': presetStateAsync.valueOrNull?.presets.length,
        'themeOption': themeOption.name,
      },
    );
    // #endregion

    final ThemeData theme = presetStateAsync.maybeWhen(
      data: (_) => presetsController.applyActivePresetToTheme(
        buildThemed(baseTheme, Brightness.dark),
        Brightness.dark,
      ),
      orElse: () => buildThemed(baseTheme, Brightness.dark),
    );

    final ThemeData darkTheme = presetStateAsync.maybeWhen(
      // If a custom preset is active, use it as the darkTheme directly
      // to ensure it takes effect even when themeMode is dark.
      data: (s) => s.activePresetId == null
          ? (switch (themeOption) {
              AppThemeOption.kraftDark => AppColorSchemes.kraftDark(theme),
              AppThemeOption.defaultDark => theme,
              _ => theme,
            })
          : theme,
      orElse: () => switch (themeOption) {
        AppThemeOption.kraftDark => AppColorSchemes.kraftDark(theme),
        AppThemeOption.defaultDark => theme,
        _ => theme,
      },
    );

    // Base light theme starts from current baseTheme but with light brightness.
    // We intentionally avoid locking to DreamOSHomeColors so presets can cover
    // global UI (including DreamOS & Auth).
    final ThemeData baseLightTheme = buildThemed(
      ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        fontFamily: fontFamily,
      ),
      Brightness.light,
    );

    final ThemeData defaultLightTheme = presetStateAsync.maybeWhen(
      data: (_) => presetsController.applyActivePresetToTheme(
        baseLightTheme,
        Brightness.light,
      ),
      orElse: () => baseLightTheme,
    );

    final ThemeData lightTheme = presetStateAsync.maybeWhen(
      // If a custom preset is active, use it as the lightTheme directly.
      data: (s) => s.activePresetId == null
          ? (switch (themeOption) {
              AppThemeOption.defaultLight => defaultLightTheme,
              AppThemeOption.rosaLight => AppColorSchemes.rosaLight(defaultLightTheme),
              AppThemeOption.slateLight => AppColorSchemes.slateLight(defaultLightTheme),
              AppThemeOption.mintLight => AppColorSchemes.mintLight(defaultLightTheme),
              AppThemeOption.lavenderLight =>
                AppColorSchemes.lavenderLight(defaultLightTheme),
              // Dark options should not affect ThemeData.theme
              AppThemeOption.defaultDark => defaultLightTheme,
              AppThemeOption.kraftDark => defaultLightTheme,
              AppThemeOption.system => defaultLightTheme,
            })
          : presetsController.applyActivePresetToTheme(
              baseLightTheme,
              Brightness.light,
            ),
      orElse: () => switch (themeOption) {
        AppThemeOption.defaultLight => defaultLightTheme,
        AppThemeOption.rosaLight => AppColorSchemes.rosaLight(defaultLightTheme),
        AppThemeOption.slateLight => AppColorSchemes.slateLight(defaultLightTheme),
        AppThemeOption.mintLight => AppColorSchemes.mintLight(defaultLightTheme),
        AppThemeOption.lavenderLight =>
          AppColorSchemes.lavenderLight(defaultLightTheme),
        AppThemeOption.defaultDark => defaultLightTheme,
        AppThemeOption.kraftDark => defaultLightTheme,
        AppThemeOption.system => defaultLightTheme,
      },
    );

    final effectiveBrightness = switch (themeOption) {
      AppThemeOption.defaultDark || AppThemeOption.kraftDark => Brightness.dark,
      AppThemeOption.system => MediaQuery.platformBrightnessOf(context),
      _ => Brightness.light,
    };

    final hasWallpaper = ref.watch(wallpaperControllerProvider).isNone == false;
    final useLightWallpaperFg = ref.watch(wallpaperLightForegroundProvider);

    // 有壁纸时：状态栏 icon 跟随壁纸对比度（黑/白）。
    // 无壁纸时：保持原本按主题明暗控制。
    if (hasWallpaper) {
      applyStatusBarForWallpaper(useLightForeground: useLightWallpaperFg);
    } else {
      applyStatusBarForBrightness(effectiveBrightness);
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tenebralis Dream System',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: presetStateAsync.maybeWhen(
        data: (s) {
          if (s.activePresetId != null) {
            // Custom preset should apply in both light and dark modes.
            return ThemeMode.system;
          }
          return switch (themeOption) {
            AppThemeOption.system => ThemeMode.system,
            AppThemeOption.defaultLight ||
            AppThemeOption.rosaLight ||
            AppThemeOption.slateLight ||
            AppThemeOption.mintLight ||
            AppThemeOption.lavenderLight => ThemeMode.light,
            AppThemeOption.defaultDark || AppThemeOption.kraftDark => ThemeMode.dark,
          };
        },
        orElse: () => switch (themeOption) {
          AppThemeOption.system => ThemeMode.system,
          AppThemeOption.defaultLight ||
          AppThemeOption.rosaLight ||
          AppThemeOption.slateLight ||
          AppThemeOption.mintLight ||
          AppThemeOption.lavenderLight => ThemeMode.light,
          AppThemeOption.defaultDark || AppThemeOption.kraftDark => ThemeMode.dark,
        },
      ),
      locale: locale,
      supportedLocales: const [
        Locale('zh'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
