import 'package:flutter/material.dart';

import '../domain/theme_preset.dart';
import '../domain/theme_preset_defaults.dart';
import '../domain/theme_tokens.dart';
import 'theme_scheme_builder.dart';

/// Built-in theme presets shipped with the app.
List<ThemePreset> builtinThemePresets() {
  // Slate（石板）
  final slateLight = ThemePresetDefaults.slateLightTokens;
  final slateLightWithText = ensureAutoText(slateLight);
  final slateDark = deriveDarkTokens(slateLightWithText);

  // Deep Sea（深海） - 深色预设
  // 这里我们以 darkTokens 为基准，生成一套可用的 lightTokens（便于在“浅色模式”也能预览/使用）。
  // 由于目前仅提供 deriveDarkTokens(light) 而没有反向推导，这里给一个稳定的浅色版本：
  // - 以主色/辅色保持一致
  // - background/surface 用更浅的同色系（由既有基色手动选择），避免出现不可读或过暗的浅色界面
  final deepSeaDark = ensureAutoText(ThemePresetDefaults.deepSeaDarkTokens);
  final deepSeaLight = ensureAutoText(const ThemeTokens(
    primary: '#0F4C75',
    secondary: '#3282B8',
    background: '#E7F3FA',
    surface: '#BBE1FA',
    text: '',
  ));

  return [
    ThemePreset(
      id: 'slate',
      name: 'Slate（石板）',
      lightTokens: slateLightWithText,
      darkTokens: slateDark,
      syncEnabled: false,
      pendingSync: false,
    ),
    ThemePreset(
      id: 'deep_sea',
      name: '深海',
      lightTokens: deepSeaLight,
      darkTokens: deepSeaDark,
      syncEnabled: false,
      pendingSync: false,
    ),
  ];
}

/// Optional helper kept for backward compatibility.
ThemeData applyBuiltinSchemeToTheme(ThemeData base, String builtinId) => base;
