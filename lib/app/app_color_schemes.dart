import 'package:flutter/material.dart';



/// Additional app color schemes.

///

/// NOTE: The existing default Light palette must remain unchanged.

/// This file only defines alternative schemes.

class AppColorSchemes {

  AppColorSchemes._();



  /// Rosa (玫粉)

  /// Palette: FEFCF3, F5EBE0, F0DBDB, DBA39A

  static const Color _rosa1 = Color(0xFFFEFCF3);

  static const Color _rosa2 = Color(0xFFF5EBE0);

  static const Color _rosa3 = Color(0xFFF0DBDB);

  static const Color _rosa4 = Color(0xFFDBA39A);

  /// Mint (薄荷，浅色)
  /// Palette: E3FDFD, CBF1F5, A6E3E9, 71C9CE
  static const Color _mint1 = Color(0xFFE3FDFD);
  static const Color _mint2 = Color(0xFFCBF1F5);
  static const Color _mint3 = Color(0xFFA6E3E9);
  static const Color _mint4 = Color(0xFF71C9CE);

  /// Lavender (薰衣草，浅色)
  /// Palette: F4EEFF, DCD6F7, A6B1E1, 424874
  static const Color _lav1 = Color(0xFFF4EEFF);
  static const Color _lav2 = Color(0xFFDCD6F7);
  static const Color _lav3 = Color(0xFFA6B1E1);
  static const Color _lav4 = Color(0xFF424874);

  /// Kraft (牛皮纸，深色)
  /// Palette: 2C3639, 3F4E4F, A27B5C, DCD7C9
  static const Color _kraft1 = Color(0xFF2C3639);
  static const Color _kraft2 = Color(0xFF3F4E4F);
  static const Color _kraft3 = Color(0xFFA27B5C);
  static const Color _kraft4 = Color(0xFFDCD7C9);

  static ThemeData rosaLight(ThemeData base) {

    final scheme = ColorScheme.light(

      primary: _rosa4,

      onPrimary: const Color(0xFF1A1A1A),

      secondary: _rosa3,

      onSecondary: const Color(0xFF1A1A1A),

      surface: _rosa1,

      onSurface: const Color(0xFF2D2D2D),

      surfaceContainer: _rosa2,

      surfaceContainerHighest: _rosa3,

      onSurfaceVariant: const Color(0xFF5C5C5C),

      outlineVariant: const Color(0xFFE3D8D1),

      secondaryContainer: _rosa2,

    );



    return base.copyWith(

      colorScheme: scheme,

      scaffoldBackgroundColor: _rosa1,

      appBarTheme: base.appBarTheme.copyWith(

        backgroundColor: Colors.transparent,

      ),

    );

  }



  /// Slate (石板)

  /// Palette: F0F5F9, C9D6DF, 52616B, 1E2022

  static const Color _slate1 = Color(0xFFF0F5F9);

  static const Color _slate2 = Color(0xFFC9D6DF);

  static const Color _slate3 = Color(0xFF52616B);

  static const Color _slate4 = Color(0xFF1E2022);



  static ThemeData slateLight(ThemeData base) {

    final scheme = ColorScheme.light(

      primary: _slate3,

      onPrimary: Colors.white,

      secondary: _slate2,

      onSecondary: _slate4,

      surface: _slate1,

      onSurface: _slate4,

      surfaceContainer: _slate2,

      surfaceContainerHighest: _slate1,

      onSurfaceVariant: _slate3,

      outlineVariant: const Color(0xFFB8C6D0),

      secondaryContainer: _slate2,

    );

    return base.copyWith(

      colorScheme: scheme,

      scaffoldBackgroundColor: _slate1,

      appBarTheme: base.appBarTheme.copyWith(

        backgroundColor: Colors.transparent,

      ),

    );

  }

  static ThemeData mintLight(ThemeData base) {
    final scheme = ColorScheme.light(
      primary: _mint4,
      onPrimary: const Color(0xFF062A2B),
      secondary: _mint3,
      onSecondary: const Color(0xFF062A2B),
      surface: _mint1,
      onSurface: const Color(0xFF083233),
      surfaceContainer: _mint2,
      surfaceContainerHighest: _mint3,
      onSurfaceVariant: const Color(0xFF2A5D60),
      outlineVariant: const Color(0xFFBDE6EA),
      secondaryContainer: _mint2,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: _mint1,
      appBarTheme: base.appBarTheme.copyWith(backgroundColor: Colors.transparent),
    );
  }

  static ThemeData lavenderLight(ThemeData base) {
    final scheme = ColorScheme.light(
      primary: _lav4,
      onPrimary: Colors.white,
      secondary: _lav3,
      onSecondary: const Color(0xFF1C1F2C),
      surface: _lav1,
      onSurface: const Color(0xFF1C1F2C),
      surfaceContainer: _lav2,
      surfaceContainerHighest: _lav1,
      onSurfaceVariant: _lav4,
      outlineVariant: const Color(0xFFCFC7F1),
      secondaryContainer: _lav2,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: _lav1,
      appBarTheme: base.appBarTheme.copyWith(backgroundColor: Colors.transparent),
    );
  }

  static ThemeData kraftDark(ThemeData base) {
    final scheme = ColorScheme.dark(
      primary: _kraft3,
      onPrimary: const Color(0xFF1B1B1B),
      secondary: _kraft2,
      onSecondary: _kraft4,
      surface: _kraft1,
      onSurface: _kraft4,
      background: _kraft1,
      onBackground: _kraft4,
      surfaceContainerHighest: _kraft2,
      onSurfaceVariant: _kraft4,
      outline: const Color(0xFF546264),
      outlineVariant: const Color(0xFF4A585A),
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: _kraft1,
      appBarTheme: base.appBarTheme.copyWith(backgroundColor: Colors.transparent),
      cardTheme: base.cardTheme.copyWith(
        color: _kraft2,
        surfaceTintColor: _kraft3,
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        backgroundColor: _kraft2,
        contentTextStyle: const TextStyle(color: _kraft4),
      ),
    );
  }

}

