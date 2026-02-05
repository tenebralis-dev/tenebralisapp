import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/settings/data/local_locale_prefs.dart';

/// App locale controller (local-only persistence).
class LocaleController extends StateNotifier<Locale?> {
  LocaleController() : super(const Locale('zh')) {
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final initial = await LocalLocalePrefs.load();
    if (state?.languageCode != initial.languageCode) {
      state = initial;
    }
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    if (locale != null) {
      await LocalLocalePrefs.save(locale);
    }
  }

  Future<void> setChinese() => setLocale(const Locale('zh'));
  Future<void> setEnglish() => setLocale(const Locale('en'));
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale?>(
  (ref) => LocaleController(),
);
