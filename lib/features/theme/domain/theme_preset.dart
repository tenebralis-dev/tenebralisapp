import 'package:freezed_annotation/freezed_annotation.dart';

import 'theme_tokens.dart';

part 'theme_preset.freezed.dart';
part 'theme_preset.g.dart';

@freezed
class ThemePreset with _$ThemePreset {
  const factory ThemePreset({
    required String id,
    required String name,

    /// Theme preset schema version.
    ///
    /// - 1: legacy single color set (ThemePresetColors).
    /// - 2: new tokens with separate light/dark.
    @Default(2) int schemaVersion,

    /// Tokens for light mode.
    required ThemeTokens lightTokens,

    /// Tokens for dark mode.
    required ThemeTokens darkTokens,

    @Default(false) bool syncEnabled,
    @Default(false) bool pendingSync,
    DateTime? updatedAt,
  }) = _ThemePreset;

  factory ThemePreset.fromJson(Map<String, Object?> json) =>
      _$ThemePresetFromJson(json);
}

/// Legacy v1 colors. Kept for backward compatibility and migration.
@freezed
class ThemePresetColors with _$ThemePresetColors {
  const factory ThemePresetColors({
    required String primary,
    required String secondary,
    required String background,
    required String surface,
    required String text,
    String? error,
    String? success,
    String? warning,
  }) = _ThemePresetColors;

  factory ThemePresetColors.fromJson(Map<String, Object?> json) =>
      _$ThemePresetColorsFromJson(json);
}
