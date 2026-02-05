import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';

ThemeTokens tokensFromLegacyColors(ThemePresetColors c) {
  return ThemeTokens(
    primary: c.primary,
    secondary: c.secondary,
    background: c.background,
    surface: c.surface,
    text: c.text,
    error: c.error,
    success: c.success,
    warning: c.warning,
  );
}

/// Best-effort dark tokens derived from a light token set.
///
/// For now we keep it simple and default to the same tokens; users can edit
/// dark tokens later. We can improve derivation logic later.
ThemeTokens deriveDarkTokensFromLight(ThemeTokens light) {
  return light;
}
