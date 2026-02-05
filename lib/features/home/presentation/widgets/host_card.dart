import 'dart:ui';

import 'package:flutter/material.dart';

class HostCard extends StatelessWidget {
  const HostCard({
    super.key,
    required this.points,
    this.avatar,
  });

  final int points;
  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.35),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _Avatar(avatar: avatar),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '宿主 / Host',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.stars_rounded,
                            size: 18, color: scheme.primary),
                        const SizedBox(width: 6),
                        Text(
                          '$points',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Intergalactic Points',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _SystemTagRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatar});

  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.60),
            scheme.tertiary.withValues(alpha: 0.45),
          ],
        ),
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: ClipOval(
        child: avatar == null
            ? Icon(Icons.person_rounded,
                color: scheme.onPrimaryContainer.withValues(alpha: 0.9))
            : Image(image: avatar!, fit: BoxFit.cover),
      ),
    );
  }
}

class _SystemTagRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget chip(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: scheme.primary.withValues(alpha: 0.18),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        chip('后台'),
        chip('同步中'),
      ],
    );
  }
}
