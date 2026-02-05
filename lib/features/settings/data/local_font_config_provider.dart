import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_settings_font_config.dart';

final localFontConfigProvider = FutureProvider<LocalFontConfig?>((ref) async {
  return LocalFontConfigStore.load();
});
