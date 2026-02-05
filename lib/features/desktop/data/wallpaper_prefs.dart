import 'package:shared_preferences/shared_preferences.dart';

/// Wallpaper preference persistence.
///
/// Supports:
/// - Remote direct URL (jpg/png)
/// - Local file path (picked by user)
class WallpaperPrefs {
  WallpaperPrefs._();

  static const _typeKey = 'settings.wallpaper.type';
  static const _valueKey = 'settings.wallpaper.value';

  static Future<WallpaperConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    final type = prefs.getString(_typeKey);
    final value = prefs.getString(_valueKey);

    if (type == null || value == null || value.trim().isEmpty) {
      return const WallpaperConfig.none();
    }

    switch (type) {
      case 'url':
        return WallpaperConfig.url(value.trim());
      case 'file':
        return WallpaperConfig.file(value.trim());
      default:
        return const WallpaperConfig.none();
    }
  }

  static Future<void> save(WallpaperConfig config) async {
    final prefs = await SharedPreferences.getInstance();

    if (config.isNone) {
      await prefs.remove(_typeKey);
      await prefs.remove(_valueKey);
      return;
    }

    await prefs.setString(_typeKey, config.type);
    await prefs.setString(_valueKey, config.value);
  }

  static Future<void> clear() => save(const WallpaperConfig.none());
}

class WallpaperConfig {
  const WallpaperConfig._(this.type, this.value);

  final String type; // none/url/file
  final String value;

  const WallpaperConfig.none() : this._('none', '');
  const WallpaperConfig.url(String url) : this._('url', url);
  const WallpaperConfig.file(String path) : this._('file', path);

  bool get isNone => type == 'none' || value.trim().isEmpty;

  @override
  String toString() => 'WallpaperConfig(type: $type, value: $value)';
}
