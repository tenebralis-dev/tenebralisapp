import 'package:flutter/material.dart';

import 'auth_tokens.dart';

/// Build the app ThemeData from a given Material3 ColorScheme.
///
/// Keep all component theming centralized so pages don't hardcode colors.

ThemeData buildAppThemeData({
  required ColorScheme scheme,
  required Brightness brightness,
  required String fontFamily,
}) {
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    fontFamily: fontFamily,
    extensions: <ThemeExtension<dynamic>>[
      AuthTokens.fromScheme(scheme),
    ],
  );

  final radius = BorderRadius.circular(16);

  return base.copyWith(
    scaffoldBackgroundColor: scheme.background,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: scheme.onBackground,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: base.cardTheme.copyWith(
      color: scheme.surfaceContainerHighest,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: radius),
      surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: base.listTileTheme.copyWith(
      iconColor: scheme.onSurfaceVariant,
      textColor: scheme.onSurface,
    ),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(color: scheme.onInverseSurface),
    ),
    dividerTheme: base.dividerTheme.copyWith(color: scheme.outlineVariant),
    dialogTheme: base.dialogTheme.copyWith(
      backgroundColor: scheme.surfaceContainerHighest,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    bottomSheetTheme: base.bottomSheetTheme.copyWith(
      backgroundColor: scheme.surfaceContainerHighest,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outlineVariant),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: scheme.surfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surfaceContainer,
      indicatorColor: scheme.secondaryContainer,
      labelTextStyle: WidgetStatePropertyAll(
        base.textTheme.labelMedium?.copyWith(color: scheme.onSurface),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
        );
      }),
    ),
  );
}
