import 'package:flutter/material.dart';

/// Ocean Dark theme based on the provided palette:
/// - #1B262C
/// - #0F4C75
/// - #3282B8
/// - #BBE1FA
class OceanDarkTheme {
  OceanDarkTheme._();

  static const Color bg = Color(0xFF1B262C);
  static const Color surface = Color(0xFF0F4C75);
  static const Color primary = Color(0xFF3282B8);
  static const Color onPrimary = Color(0xFFBBE1FA);

  // Slightly lifted surfaces for Material3 containers.
  static const Color surfaceContainer = Color(0xFF123B57);
  static const Color outline = Color(0xFF2E5F7E);

  static ThemeData darkWithFont(String fontFamily) {
    final base = dark;
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: fontFamily),
      primaryTextTheme: base.primaryTextTheme.apply(fontFamily: fontFamily),
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      secondary: surface,
      onSecondary: onPrimary,
      tertiary: onPrimary,
      onTertiary: bg,
      surface: surface,
      onSurface: onPrimary,
      background: bg,
      onBackground: onPrimary,
      error: Color(0xFFFF6B6B),
      outline: outline,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: onPrimary,
        textColor: onPrimary,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: surfaceContainer,
        contentTextStyle: TextStyle(color: onPrimary),
      ),
      dividerTheme: const DividerThemeData(color: outline),
    );
  }
}
