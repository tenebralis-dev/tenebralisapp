import 'package:flutter/material.dart';

import '../../../../app/auth_tokens.dart';

/// A soft dreamy background inspired by the web lock screen:
/// - warm pink cloud glows
/// - a few floating "charms" (sparkle/bow/candy)
///
/// NOTE: Keeps to Material widgets only; no extra UI libraries.
class AuthCharmBackground extends StatelessWidget {
  const AuthCharmBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final auth = Theme.of(context).extension<AuthTokens>() ?? AuthTokens.fromScheme(scheme);

    final c1 = auth.glow1;
    final c2 = auth.bgGradientStart;
    final c3 = auth.bgGradientEnd;
    final c4 = auth.glow2;

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                c2,
                c3,
              ],
            ),
          ),
        ),

        // Calm glows (no emoji / no animation)
        Positioned(
          top: -140,
          left: -140,
          child: _GlowBlob(
            diameter: 340,
            color: c1,
          ),
        ),
        Positioned(
          top: 120,
          right: -160,
          child: _GlowBlob(
            diameter: 420,
            color: c4,
          ),
        ),
        Positioned(
          bottom: -220,
          left: 40,
          child: _GlowBlob(
            diameter: 520,
            color: c3,
          ),
        ),

        // Subtle radial overlay
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.6, -0.7),
                radius: 1.2,
                colors: [
                  c1,
                  c1.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        SafeArea(child: child),
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({
    required this.diameter,
    required this.color,
  });

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: diameter * 0.35,
            spreadRadius: diameter * 0.05,
          ),
        ],
      ),
    );
  }
}
