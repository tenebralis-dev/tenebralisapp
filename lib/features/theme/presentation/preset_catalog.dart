import 'package:flutter/material.dart';

import '../../../app/app_color_schemes.dart';
import '../../../app/ocean_dark_theme.dart';
import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';
import 'theme_scheme_builder.dart';

String _hex(Color c) => '#${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

/// Built-in theme presets shipped with the app.
///
/// These are *not* user-editable presets. They can be applied directly or copied
/// into a user preset.
List<ThemePreset> builtinThemePresets() {
  // NOTE: We map existing palettes from `AppColorSchemes` (and a few other
  // bundled themes) into `ThemePresetColors`.
  //
  // For schemes that don't explicitly define some values (e.g. background/text)
  // in `AppColorSchemes`, we make a reasonable mapping consistent with how the
  // ThemeData is built in that file.
  const blackText = Color(0xFF1A1A1A);
  const slateDarkText = Color(0xFF1E2022);

  return [
    (() {
      final light = ThemeTokens(
        primary: _hex(const Color(0xFFDBA39A)),
        secondary: _hex(const Color(0xFFF0DBDB)),
        background: _hex(const Color(0xFFFEFCF3)),
        surface: _hex(const Color(0xFFFEFCF3)),
        text: _hex(const Color(0xFF2D2D2D)),
        error: _hex(const Color(0xFFB00020)),
      );
      return ThemePreset(
        id: 'builtin.rosaLight',
        name: 'Rosa（玫粉）',
        schemaVersion: 2,
        lightTokens: light,
        darkTokens: deriveDarkTokens(light),
        syncEnabled: false,
        pendingSync: false,
      );
    })(),
    (() {
      final light = ThemeTokens(
        primary: _hex(const Color(0xFF52616B)),
        secondary: _hex(const Color(0xFFC9D6DF)),
        background: _hex(const Color(0xFFF0F5F9)),
        surface: _hex(const Color(0xFFF0F5F9)),
        text: _hex(slateDarkText),
        error: _hex(const Color(0xFFB00020)),
      );
      return ThemePreset(
        id: 'builtin.slateLight',
        name: 'Slate（石板）',
        schemaVersion: 2,
        lightTokens: light,
        darkTokens: deriveDarkTokens(light),
        syncEnabled: false,
        pendingSync: false,
      );
    })(),
    (() {
      final light = ThemeTokens(
        primary: _hex(const Color(0xFF71C9CE)),
        secondary: _hex(const Color(0xFFA6E3E9)),
        background: _hex(const Color(0xFFE3FDFD)),
        surface: _hex(const Color(0xFFE3FDFD)),
        text: _hex(const Color(0xFF083233)),
        error: _hex(const Color(0xFFB00020)),
      );
      return ThemePreset(
        id: 'builtin.mintLight',
        name: 'Mint（薄荷）',
        schemaVersion: 2,
        lightTokens: light,
        darkTokens: deriveDarkTokens(light),
        syncEnabled: false,
        pendingSync: false,
      );
    })(),
    (() {
      final light = ThemeTokens(
        primary: _hex(const Color(0xFF424874)),
        secondary: _hex(const Color(0xFFA6B1E1)),
        background: _hex(const Color(0xFFF4EEFF)),
        surface: _hex(const Color(0xFFF4EEFF)),
        text: _hex(const Color(0xFF1C1F2C)),
        error: _hex(const Color(0xFFB00020)),
      );
      return ThemePreset(
        id: 'builtin.lavenderLight',
        name: 'Lavender（薰衣草）',
        schemaVersion: 2,
        lightTokens: light,
        darkTokens: deriveDarkTokens(light),
        syncEnabled: false,
        pendingSync: false,
      );
    })(),
    ThemePreset(
      id: 'builtin.kraftDark',
      name: 'Kraft（牛皮纸-暗）',
      schemaVersion: 2,
      lightTokens: ThemeTokens(
        primary: _hex(const Color(0xFFA27B5C)),
        secondary: _hex(const Color(0xFF3F4E4F)),
        background: _hex(const Color(0xFFDCD7C9)),
        surface: _hex(const Color(0xFFDCD7C9)),
        text: _hex(const Color(0xFF2C3639)),
        error: _hex(const Color(0xFFB00020)),
      ),
      darkTokens: ThemeTokens(
        primary: _hex(const Color(0xFFA27B5C)),
        secondary: _hex(const Color(0xFF3F4E4F)),
        background: _hex(const Color(0xFF2C3639)),
        surface: _hex(const Color(0xFF2C3639)),
        text: _hex(const Color(0xFFDCD7C9)),
        error: _hex(const Color(0xFFFF5252)),
      ),
      syncEnabled: false,
      pendingSync: false,
    ),

    // Extra bundled dark preset.
    ThemePreset(
      id: 'builtin.oceanDark',
      name: 'Ocean（海洋-暗）',
      schemaVersion: 2,
      lightTokens: ThemeTokens(
        primary: _hex(OceanDarkTheme.primary),
        secondary: _hex(OceanDarkTheme.surface),
        background: _hex(const Color(0xFFECE2E1)),
        surface: _hex(const Color(0xFFF0F5F9)),
        text: _hex(const Color(0xFF1B262C)),
        error: _hex(const Color(0xFFB00020)),
      ),
      darkTokens: ThemeTokens(
        primary: _hex(OceanDarkTheme.primary),
        secondary: _hex(OceanDarkTheme.surface),
        background: _hex(OceanDarkTheme.bg),
        surface: _hex(OceanDarkTheme.surface),
        text: _hex(OceanDarkTheme.onPrimary),
        error: _hex(const Color(0xFFFF6B6B)),
      ),
      syncEnabled: false,
      pendingSync: false,
    ),
  ];
}

/// Optional helper if callers still need ThemeData-based presets later.
ThemeData applyBuiltinSchemeToTheme(ThemeData base, String builtinId) {
  switch (builtinId) {
    case 'builtin.rosaLight':
      return AppColorSchemes.rosaLight(base);
    case 'builtin.slateLight':
      return AppColorSchemes.slateLight(base);
    case 'builtin.mintLight':
      return AppColorSchemes.mintLight(base);
    case 'builtin.lavenderLight':
      return AppColorSchemes.lavenderLight(base);
    case 'builtin.kraftDark':
      return AppColorSchemes.kraftDark(base);
    case 'builtin.oceanDark':
      return OceanDarkTheme.dark;
    default:
      return base;
  }
}
