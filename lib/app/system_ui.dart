import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Apply system UI style for the whole app.
///
/// Requirement:
/// - Light themes => status bar icons/text are black.
/// - Dark themes  => status bar icons/text are white.
void applyStatusBarForBrightness(Brightness brightness) {
  final style = brightness == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

  // Keep status bar background transparent to match existing design.
  SystemChrome.setSystemUIOverlayStyle(
    style.copyWith(statusBarColor: Colors.transparent),
  );
}

/// Apply status bar foreground (icons/text) based on wallpaper contrast.
///
/// When wallpaper is used, we want the system status bar icons to follow the
/// same black/white decision as home icons.
void applyStatusBarForWallpaper({
  required bool useLightForeground,
  Color statusBarColor = Colors.transparent,
}) {
  // Android:
  // - statusBarIconBrightness controls status bar *icons* color.
  // - statusBarBrightness is used by iOS.
  //
  // We set both for consistency.
  final iconBrightness = useLightForeground ? Brightness.light : Brightness.dark;

  final base = SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: iconBrightness,
    statusBarBrightness: iconBrightness,
    // Some Android builds also consult navigation bar values; keeping them in
    // sync helps avoid OEM quirks.
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: iconBrightness,
    systemNavigationBarDividerColor: Colors.transparent,
  );

  // Call twice to fight OEM overrides (some devices apply a default style after
  // the first frame).
  SystemChrome.setSystemUIOverlayStyle(base);
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setSystemUIOverlayStyle(base);
  });
}

