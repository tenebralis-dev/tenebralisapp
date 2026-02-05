import 'package:flutter/material.dart';

/// Material 3 system-style authentication card.
///
/// - Max width 420dp
/// - 28dp rounded corners
/// - 16-24dp spacing
/// - Scroll-friendly (caller should place it inside a scroll view)
class AuthSystemCard extends StatelessWidget {
  const AuthSystemCard({
    super.key,
    required this.child,
  });

  static const maxWidth = 420.0;
  static const radius = 28.0;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Card(
        elevation: 2,
        color: scheme.surface,
        surfaceTintColor: scheme.primary.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
