import 'package:flutter/material.dart';

/// Extra theme tokens for the Auth background.
///
/// Auth uses gradients/glows which are not represented by ColorScheme.
class AuthTokens extends ThemeExtension<AuthTokens> {
  const AuthTokens({
    required this.bgGradientStart,
    required this.bgGradientEnd,
    required this.glow1,
    required this.glow2,
    required this.glow3,
  });

  final Color bgGradientStart;
  final Color bgGradientEnd;
  final Color glow1;
  final Color glow2;
  final Color glow3;

  static AuthTokens fromScheme(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;

    final start = scheme.background;
    final end = scheme.surface;

    return AuthTokens(
      bgGradientStart: start,
      bgGradientEnd: end,
      glow1: scheme.primary.withValues(alpha: isDark ? 0.30 : 0.22),
      glow2: scheme.tertiary.withValues(alpha: isDark ? 0.22 : 0.18),
      glow3: scheme.secondary.withValues(alpha: isDark ? 0.18 : 0.14),
    );
  }

  @override
  AuthTokens copyWith({
    Color? bgGradientStart,
    Color? bgGradientEnd,
    Color? glow1,
    Color? glow2,
    Color? glow3,
  }) {
    return AuthTokens(
      bgGradientStart: bgGradientStart ?? this.bgGradientStart,
      bgGradientEnd: bgGradientEnd ?? this.bgGradientEnd,
      glow1: glow1 ?? this.glow1,
      glow2: glow2 ?? this.glow2,
      glow3: glow3 ?? this.glow3,
    );
  }

  @override
  AuthTokens lerp(ThemeExtension<AuthTokens>? other, double t) {
    if (other is! AuthTokens) return this;
    return AuthTokens(
      bgGradientStart: Color.lerp(bgGradientStart, other.bgGradientStart, t)!,
      bgGradientEnd: Color.lerp(bgGradientEnd, other.bgGradientEnd, t)!,
      glow1: Color.lerp(glow1, other.glow1, t)!,
      glow2: Color.lerp(glow2, other.glow2, t)!,
      glow3: Color.lerp(glow3, other.glow3, t)!,
    );
  }
}
