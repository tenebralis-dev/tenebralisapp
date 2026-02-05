import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_tokens.freezed.dart';
part 'theme_tokens.g.dart';

/// Schema version for preset JSON import/export.
///
/// v1: legacy `ThemePresetColors` single set.
/// v2: `ThemeTokens` with separate light/dark tokens.
const int kThemePresetSchemaVersion = 2;

@freezed
class ThemeTokens with _$ThemeTokens {
  const factory ThemeTokens({
    /// Primary accent color.
    required String primary,

    /// Secondary accent color.
    required String secondary,

    /// App background color (full-screen).
    required String background,

    /// Surface color (cards, sheets).
    required String surface,

    /// Default text color.
    required String text,

    /// Error color (optional).
    String? error,

    /// Optional extra semantic colors for future expansion.
    String? success,
    String? warning,

    /// Optional tertiary color.
    String? tertiary,
  }) = _ThemeTokens;

  factory ThemeTokens.fromJson(Map<String, Object?> json) =>
      _$ThemeTokensFromJson(json);
}
