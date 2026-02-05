import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/font_controller.dart';
import '../../data/font_runtime_loader.dart';
import '../../../settings/data/local_font_config_provider.dart';

/// Resolved active font setting for the whole app.
///
/// Source: local font config (SharedPreferences).
///
/// - preset fonts are local (bundled)
/// - URL fonts are stored as settings.font_config.source
/// - local fonts are stored as file://... in settings.font_config.source
@immutable
class ActiveFont {
  const ActiveFont._({
    required this.kind,
    this.fontFamily,
  });

  final ActiveFontKind kind;

  /// Used when [kind] == [ActiveFontKind.materialFontFamily].
  final String? fontFamily;

  factory ActiveFont.builtIn(String family) =>
      ActiveFont._(kind: ActiveFontKind.materialFontFamily, fontFamily: family);
}

enum ActiveFontKind {
  materialFontFamily,
}

final activeFontProvider = FutureProvider<ActiveFont>((ref) async {
  final fontConfigAsync = ref.watch(localFontConfigProvider);
  final fontConfig = fontConfigAsync.valueOrNull;

  if (fontConfig != null && fontConfig.isPreset && fontConfig.preset != null) {
    return ActiveFont.builtIn(fontConfig.preset!);
  }

  if (fontConfig != null && fontConfig.isSource && fontConfig.source != null) {
    final source = fontConfig.source!;
    try {
      final family = await FontRuntimeLoader.loadFromUrl(source);
      return ActiveFont.builtIn(family);
    } catch (_) {
      // Local-only settings: if file:// missing, just fallback below.
    }
  }

  // Fallback: FontController (preset family from SharedPreferences or default)
  final family = ref.watch(fontControllerProvider);
  if (family.isNotEmpty) {
    return ActiveFont.builtIn(family);
  }
  return const ActiveFont._(kind: ActiveFontKind.materialFontFamily);
});

/// Helper to apply ActiveFont to a ThemeData.
ThemeData applyActiveFontToTheme(ThemeData base, ActiveFont font) {
  switch (font.kind) {
    case ActiveFontKind.materialFontFamily:
      final family = font.fontFamily;
      if (family == null || family.trim().isEmpty) return base;
      return base.copyWith(
        textTheme: base.textTheme.apply(fontFamily: family),
        primaryTextTheme: base.primaryTextTheme.apply(fontFamily: family),
      );
  }
}
