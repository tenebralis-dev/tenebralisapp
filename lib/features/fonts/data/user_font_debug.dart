import 'dart:developer' as dev;

import 'user_font_local_prefs.dart';

class UserFontDebug {
  UserFontDebug._();

  static Future<void> dumpLocalPrefs() async {
    try {
      final fonts = await UserFontLocalPrefs.list();
      final selected = await UserFontLocalPrefs.getSelectedFontId();
      dev.log('local fonts: ${fonts.length}', name: 'UserFontDebug');
      dev.log('local selected id: $selected', name: 'UserFontDebug');
      for (final f in fonts) {
        dev.log(
          '- id=${f.id} type=${f.sourceType.name} family=${f.family} localPath=${f.localPath}',
          name: 'UserFontDebug',
        );
      }
    } catch (e) {
      dev.log('dumpLocalPrefs failed: $e', name: 'UserFontDebug');
    }
  }
}
