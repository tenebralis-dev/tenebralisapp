import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/font_controller.dart';
import 'app/locale_controller.dart';
import 'app/router.dart';
import 'app/theme_controller.dart';
import 'app/system_ui.dart';
import 'app/theme_data_builder.dart';
import 'features/desktop/presentation/controllers/wallpaper_controller.dart';
import 'features/desktop/presentation/controllers/wallpaper_contrast_controller.dart';
import 'features/fonts/presentation/controllers/active_font_controller.dart';
import 'core/config/env_config.dart';
import 'core/services/supabase_service.dart';
import 'features/fonts/data/user_font_debug.dart';
import 'features/theme/presentation/controllers/theme_presets_controller.dart';

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

  // 预加载 ThemeMode 选项（system/defaultDark/defaultLight），避免启动时先按 system 渲染，
  // 再异步切换到用户保存的选项导致闪烁。
  final preloadedThemeOption = await ThemeController.loadInitial();
  setPreloadedThemeOption(preloadedThemeOption);

  // 预加载主题配置，避免首帧渲染时因异步加载导致的"默认配色→自定义配色"闪烁
  final preloadedThemeState = await ThemePresetsController.preload();
  setPreloadedThemePresetsState(preloadedThemeState);

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

    // 统一主题入口：
    // - 不再在此处写死 seedColor
    // - ColorScheme 由 Theme Preset（tokens）决定；无 preset 时由内置默认 preset 决定
    final presetStateAsync = ref.watch(themePresetsControllerProvider);
    final presetsController = ref.read(themePresetsControllerProvider.notifier);

    final ThemeData baseTheme = activeFontAsync.maybeWhen(
      data: (activeFont) => applyActiveFontToTheme(
        ThemeData(useMaterial3: true, brightness: Brightness.dark, fontFamily: fontFamily),
        activeFont,
      ),
      orElse: () => ThemeData(useMaterial3: true, brightness: Brightness.dark, fontFamily: fontFamily),
    );

    // 先拿到“当前应生效的 scheme”（active preset or default）。
    // 如果 preset 仍在 loading，优先用“上一次已知的本地 active preset”（controller state）
    // 来构建首帧主题，避免启动闪烁。
    final ColorScheme activeScheme = presetStateAsync.maybeWhen(
      data: (s) => presetsController.activeColorScheme(Brightness.dark),
      orElse: () => presetsController.activeColorScheme(Brightness.dark),
    );

    // Create base Light/Dark themes from current tokens output.
    ThemeData buildThemed(ThemeData base, Brightness b) {
      return buildAppThemeData(
        scheme: presetStateAsync.maybeWhen(
          data: (_) => presetsController.activeColorScheme(b),
          orElse: () => presetsController.activeColorScheme(b),
        ),
        brightness: b,
        fontFamily: fontFamily,
      );
    }

    // Keep baseTheme updated with active scheme for any downstream fallback usage.
    final ThemeData baseThemeWithScheme = baseTheme.copyWith(
      colorScheme: activeScheme,
      scaffoldBackgroundColor: activeScheme.background,
    );

    final ThemeData theme = buildThemed(baseThemeWithScheme, Brightness.dark);

    final ThemeData darkTheme = presetStateAsync.maybeWhen(
      // 如果启用了自定义方案，直接使用对应 ThemeData。
      data: (s) => theme,
      orElse: () => theme,
    );

    // Base light theme starts from current baseTheme but with light brightness.
    // We intentionally avoid locking to DreamOSHomeColors so presets can cover
    // global UI (including DreamOS & Auth).
    final ThemeData baseLightTheme = activeFontAsync.maybeWhen(
      data: (activeFont) => applyActiveFontToTheme(
        ThemeData(useMaterial3: true, brightness: Brightness.light, fontFamily: fontFamily),
        activeFont,
      ),
      orElse: () => ThemeData(useMaterial3: true, brightness: Brightness.light, fontFamily: fontFamily),
    );

    final ThemeData lightTheme = buildThemed(baseLightTheme, Brightness.light);

    final platformBrightness = MediaQuery.platformBrightnessOf(context);

    final ThemeMode resolvedThemeMode = switch (themeOption) {
      AppThemeOption.system => ThemeMode.system,
      AppThemeOption.defaultLight => ThemeMode.light,
      AppThemeOption.defaultDark => ThemeMode.dark,
    };

    final effectiveBrightness = switch (resolvedThemeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => platformBrightness,
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
      themeMode: resolvedThemeMode,
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
