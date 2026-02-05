import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../domain/theme_tokens.dart';

Color _parseHexColor(String hex) {
  var raw = hex.trim();
  if (raw.startsWith('#')) raw = raw.substring(1);
  if (raw.length == 6) raw = 'FF$raw';
  if (raw.length != 8) return const Color(0xFF6C63FF);
  return Color(int.parse(raw, radix: 16));
}

Color _mix(Color a, Color b, double t) {
  final tt = t.clamp(0.0, 1.0);
  return Color.fromARGB(
    (a.alpha + (b.alpha - a.alpha) * tt).round(),
    (a.red + (b.red - a.red) * tt).round(),
    (a.green + (b.green - a.green) * tt).round(),
    (a.blue + (b.blue - a.blue) * tt).round(),
  );
}

Color _onColorFor(Color bg) {
  // Simple contrast: luminance threshold.
  return bg.computeLuminance() > 0.55 ? Colors.black : Colors.white;
}

/// Build a reasonably complete Material 3 ColorScheme from user tokens.
///
/// Goals:
/// - Provide stable background/surface/container/outline values so UI looks
///   consistent across the app (DreamOS, Auth, pages).
/// - Keep input minimal (tokens are user-editable) while deriving the rest.
ColorScheme buildColorSchemeFromTokens(ThemeTokens t, Brightness brightness) {
  final primary = _parseHexColor(t.primary);
  final secondary = _parseHexColor(t.secondary);
  final background = _parseHexColor(t.background);
  final surface = _parseHexColor(t.surface);
  final onBackground = _parseHexColor(t.text);

  final error = t.error == null
      ? (brightness == Brightness.dark
          ? const Color(0xFFFF5252)
          : const Color(0xFFB00020))
      : _parseHexColor(t.error!);

  // Containers: blend accent into background/surface.
  final primaryContainer = _mix(background, primary, brightness == Brightness.dark ? 0.25 : 0.18);
  final secondaryContainer = _mix(background, secondary, brightness == Brightness.dark ? 0.22 : 0.16);

  // Surface containers: step between surface and background.
  final surfaceContainer = _mix(surface, background, 0.08);
  final surfaceContainerHigh = _mix(surface, background, 0.16);
  final surfaceContainerHighest = _mix(surface, background, 0.24);

  final outline = _mix(onBackground, background, 0.70);
  final outlineVariant = _mix(onBackground, background, 0.82);

  final onPrimary = _onColorFor(primary);
  final onSecondary = _onColorFor(secondary);
  final onSurface = onBackground;

  final onPrimaryContainer = _onColorFor(primaryContainer);
  final onSecondaryContainer = _onColorFor(secondaryContainer);

  final onError = _onColorFor(error);

  // Inverse colors (used by SnackBar etc.).
  final inverseSurface = _mix(onBackground, background, brightness == Brightness.dark ? 0.12 : 0.88);
  final onInverseSurface = _onColorFor(inverseSurface);
  final inversePrimary = _mix(primary, onPrimary, 0.20);

  if (brightness == Brightness.dark) {
    return ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      background: background,
      onBackground: onBackground,
      error: error,
      onError: onError,
      outline: outline,
      outlineVariant: outlineVariant,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      // Keep tertiary minimal; if user provides, use it.
      tertiary: t.tertiary == null ? secondary : _parseHexColor(t.tertiary!),
      onTertiary: _onColorFor(t.tertiary == null ? secondary : _parseHexColor(t.tertiary!)),
    );
  }

  return ColorScheme.light(
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    background: background,
    onBackground: onBackground,
    error: error,
    onError: onError,
    outline: outline,
    outlineVariant: outlineVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    inversePrimary: inversePrimary,
    tertiary: t.tertiary == null ? secondary : _parseHexColor(t.tertiary!),
    onTertiary: _onColorFor(t.tertiary == null ? secondary : _parseHexColor(t.tertiary!)),
  );
}

/// Simple token derivation for dark mode from light mode.
///
/// This is intentionally conservative; users can fine-tune dark tokens.
ThemeTokens deriveDarkTokens(ThemeTokens light) {
  final bg = _parseHexColor(light.background);
  final surface = _parseHexColor(light.surface);

  // Dark background targets: invert towards near-black while preserving hue a bit.
  final darkBg = _mix(const Color(0xFF0B0C10), bg, 0.08);
  final darkSurface = _mix(const Color(0xFF121318), surface, 0.10);

  final text = const Color(0xFFEDEDED);

  String hex(Color c) => '#${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

  return ThemeTokens(
    primary: light.primary,
    secondary: light.secondary,
    background: hex(darkBg),
    surface: hex(darkSurface),
    text: hex(text),
    error: light.error,
    success: light.success,
    warning: light.warning,
    tertiary: light.tertiary,
  );
}
