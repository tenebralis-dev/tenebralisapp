import 'package:flutter/material.dart';

/// A "mirror" card: thick outline + soft highlight + lifted shadow.
///
/// Still a standard Material `Card` under the hood.
class AuthMirrorCard extends StatelessWidget {
  const AuthMirrorCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
        side: BorderSide(
          color: scheme.primary.withValues(alpha: 0.55),
          width: 3,
        ),
      ),
      child: Stack(
        children: [
          // Soft sticker-like highlight
          Positioned(
            top: 14,
            right: 18,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.20),
                    blurRadius: 32,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: child,
          ),
        ],
      ),
    );
  }
}
