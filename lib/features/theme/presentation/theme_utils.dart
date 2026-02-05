import 'package:flutter/material.dart';

import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';

Color _parseHexColor(String hex) {
  var raw = hex.trim();
  if (raw.startsWith('#')) raw = raw.substring(1);
  if (raw.length == 6) raw = 'FF$raw';
  if (raw.length != 8) return const Color(0xFF6C63FF);
  return Color(int.parse(raw, radix: 16));
}

ColorScheme colorSchemeFromTokens(ThemeTokens colors, Brightness b) {
  final primary = _parseHexColor(colors.primary);
  final secondary = _parseHexColor(colors.secondary);
  final surface = _parseHexColor(colors.surface);
  final background = _parseHexColor(colors.background);
  final text = _parseHexColor(colors.text);
  final error = colors.error == null ? null : _parseHexColor(colors.error!);

  if (b == Brightness.dark) {
    return ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error ?? const Color(0xFFFF5252),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: text,
    ).copyWith(
      background: background,
      onBackground: text,
    );
  }

  return ColorScheme.light(
    primary: primary,
    secondary: secondary,
    surface: surface,
    error: error ?? const Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: text,
  ).copyWith(
    background: background,
    onBackground: text,
  );
}
