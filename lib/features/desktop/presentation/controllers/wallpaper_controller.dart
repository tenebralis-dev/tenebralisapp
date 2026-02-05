import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/wallpaper_prefs.dart';

/// App-wide wallpaper state.
///
/// Persisted via SharedPreferences. UI can watch this provider to render
/// wallpaper background.
class WallpaperController extends StateNotifier<WallpaperConfig> {
  WallpaperController({required WallpaperConfig initial}) : super(initial);

  static Future<WallpaperConfig> loadInitial() => WallpaperPrefs.load();

  Future<void> setNone() async {
    state = const WallpaperConfig.none();
    await WallpaperPrefs.clear();
  }

  Future<void> setUrl(String url) async {
    state = WallpaperConfig.url(url);
    await WallpaperPrefs.save(state);
  }

  Future<void> setFile(String path) async {
    state = WallpaperConfig.file(path);
    await WallpaperPrefs.save(state);
  }
}

final wallpaperControllerBootstrapProvider =
    FutureProvider<WallpaperConfig>((ref) async {
  return WallpaperController.loadInitial();
});

final wallpaperControllerProvider =
    StateNotifierProvider<WallpaperController, WallpaperConfig>((ref) {
  final controller = WallpaperController(initial: const WallpaperConfig.none());

  Future<void>(() async {
    final initial = await WallpaperController.loadInitial();
    if (initial.toString() != controller.state.toString()) {
      controller.state = initial;
    }
  });

  return controller;
});
