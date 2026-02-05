import 'package:flutter/material.dart';

/// Sakura Dream (Soft Pink) Material 3 theme.
///
/// Requirements:
/// - Strict Material Design 3
/// - Rounded corners (28dp for cards)
/// - Elevation-based depth
/// - Roboto typography (Flutter default)
/// - Standard Material widgets only
class SakuraTheme {
  SakuraTheme._();

  static ThemeData darkWithFont(String fontFamily) {
    final base = dark;
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: fontFamily),
      primaryTextTheme: base.primaryTextTheme.apply(fontFamily: fontFamily),
    );
  }

  // Color tokens from requirements.
  static const Color primary = Color(0xFFF48FB1);
  static const Color secondary = Color(0xFFCE93D8);
  static const Color surface = Color(0xFF2D1B2E);
  static const Color onSurface = Color(0xFFF5E6E8);

  static ThemeData get dark {
    const base = Color(0xFFECE2E1);
    const primary = Color(0xFFAEE1E1);
    const secondary = Color(0xFFFCD1D1);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      surface: base,
    );

    // Use local Noto font (assets/fonts/Noto/...).
    final baseTextTheme = Typography.material2021(platform: TargetPlatform.android)
        .black
        .apply(fontFamily: 'NotoSansSC');

    // Noto Sans SC variable font tends to look light in some UIs.
    // Give a slightly heavier baseline, while keeping hierarchy intact.
    final textTheme = baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      bodyMedium:
          baseTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      bodySmall: baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      labelLarge:
          baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      labelMedium:
          baseTextTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      labelSmall:
          baseTextTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
      titleMedium:
          baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleLarge:
          baseTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      headlineSmall:
          baseTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFECE2E1),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFECE2E1),
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFECE2E1),
        surfaceTintColor: primary,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: const Color(0xFFD3E0DC),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        contentTextStyle: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }
}
