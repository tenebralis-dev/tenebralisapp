import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/async_value_widget.dart';
import '../data/models/world_identity.dart';
import '../data/world_identity_repository.dart';
import '../application/world_context_controller.dart';

class WorldIdentityPage extends ConsumerWidget {
  const WorldIdentityPage({super.key, required this.worldId});

  final String worldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    final asyncItems = ref.watch(_identitiesProvider(worldId));

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        title: const Text('选择身份'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context, ref),
          ),
        ],
      ),
      body: AsyncValueWidget<List<WorldIdentity>>(
        value: asyncItems,
        empty: (items) => items.isEmpty,
        emptyTitle: '还没有身份',
        emptyPrimaryAction: FilledButton.icon(
          onPressed: () => _showCreateDialog(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('创建身份'),
        ),
        data: (items) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final it = items[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                title: Text(it.identityName),
                subtitle: it.promptIdentityText == null
                    ? null
                    : Text(
                        it.promptIdentityText!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ref
                      .read(worldContextControllerProvider.notifier)
                      .setIdentity(worldId: worldId, identityId: it.id);
                  context.push('/os/apps/worlds/$worldId/identities/${it.id}/saves');
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: items.length,
          );
        },
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final promptController = TextEditingController();

    try {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('创建身份'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: '身份名'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: promptController,
                  decoration: const InputDecoration(labelText: '身份描述（可选）'),
                  minLines: 1,
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('创建'),
              ),
            ],
          );
        },
      );

      if (ok != true) return;
      final name = nameController.text.trim();
      if (name.isEmpty) return;

      final repo = ref.read(worldIdentityRepositoryProvider);
      await repo.create(
        worldId: worldId,
        identityName: name,
        promptIdentityText:
            promptController.text.trim().isEmpty ? null : promptController.text.trim(),
      );

      ref.invalidate(_identitiesProvider(worldId));
    } finally {
      nameController.dispose();
      promptController.dispose();
    }
  }
}

final _identitiesProvider = FutureProvider.family<List<WorldIdentity>, String>(
  (ref, worldId) async {
    final repo = ref.watch(worldIdentityRepositoryProvider);
    return repo.listByWorld(worldId);
  },
);
