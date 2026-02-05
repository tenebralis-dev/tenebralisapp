import 'package:flutter/material.dart';

import '../../../auth/domain/user_identity.dart';

class IdentityStatusBar extends StatelessWidget {
  const IdentityStatusBar({
    super.key,
    required this.identity,
  });

  final UserIdentity? identity;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final current = identity;
    if (current == null) {
      return _Card(
        child: Row(
          children: [
            Icon(Icons.power_settings_new_rounded,
                size: 18, color: scheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '系统待机中 / No World Loaded',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      );
    }

    final bars = current.statusBars;
    final hp = bars['hp'] ?? bars['HP'] ?? 0;
    final mp = bars['mp'] ?? bars['MP'] ?? 0;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.badge_rounded, size: 18, color: scheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current.roleName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (current.roleTitle.trim().isNotEmpty)
                      Text(
                        current.roleTitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (current.worldId != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: scheme.secondary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: scheme.secondary.withValues(alpha: 0.20),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    current.worldId!,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _Bar(label: 'HP', value: hp, color: const Color(0xFFE0565B)),
          const SizedBox(height: 8),
          _Bar(label: 'MP', value: mp, color: const Color(0xFF4D9DE0)),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.40),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final clamped = value.clamp(0, 100);

    return Row(
      children: [
        SizedBox(
          width: 34,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 10,
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: clamped / 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.95),
                          color.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$clamped%',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
