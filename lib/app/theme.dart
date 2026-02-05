import 'package:flutter/material.dart';
/// Dream OS Theme Configuration
/// Glassmorphism design with dark mode as default
class DreamTheme {
  DreamTheme._();

  // Primary Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00D9FF);
  static const Color accentColor = Color(0xFFFF6B9D);

  // Background Colors
  static const Color backgroundColor = Color(0xFF0A0E21);
  static const Color surfaceColor = Color(0xFF1D1E33);
  static const Color cardColor = Color(0xFF1D1E33);

  // Glass Colors
  static const Color glassColor = Color(0x1AFFFFFF);
  static const Color glassBorderColor = Color(0x33FFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF666666);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0A0E21),
      Color(0xFF1A1A2E),
    ],
  );

  /// Dark Theme (Default)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        error: Color(0xFFFF5252),
      ),
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, color: textPrimary),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, color: textPrimary),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: textPrimary),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: textPrimary),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: textPrimary),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textPrimary),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: textSecondary),
      ),
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
      ),
      // Card Theme
      cardTheme: CardThemeData(
        color: glassColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: glassBorderColor, width: 1),
        ),
      ),
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glassColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: glassBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: glassBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: textMuted,
        ),
      ),
      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
      ),
    );
  }
}
