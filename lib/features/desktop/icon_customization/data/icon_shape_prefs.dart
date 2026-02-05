import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/icon_shape.dart';

class IconShapePrefs {
  IconShapePrefs(this._prefs);

  static const _kKey = 'desktop.icon_shape.global.v1';

  final SharedPreferences _prefs;

  Future<IconShape> load() async {
    final raw = _prefs.getString(_kKey);
    return IconShapeX.fromId(raw);
  }

  Future<void> save(IconShape shape) async {
    await _prefs.setString(_kKey, shape.id);
  }
}

final iconShapePrefsProvider = FutureProvider<IconShapePrefs>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return IconShapePrefs(prefs);
});
