import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/users_repository.dart';
import 'widgets/widgets.dart';

/// A small HUD panel that shows Host(Profile) + Identity(current_session).
class HomeHudPanel extends ConsumerWidget {
  const HomeHudPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProfile = ref.watch(currentHostProfileProvider);

    return asyncProfile.when(
      data: (profile) {
        final points = profile?.expPoints ?? 0;
        final identity = profile?.legacyCurrentSession;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HostCard(points: points),
            const SizedBox(height: 12),
            IdentityStatusBar(identity: identity),
          ],
        );
      },
      loading: () => const _Skeleton(),
      error: (e, _) => _ErrorCard(message: e.toString()),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget block(double h) => Container(
          height: h,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(18),
          ),
        );

    return Column(
      children: [
        block(92),
        const SizedBox(height: 12),
        block(122),
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.error.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: scheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
