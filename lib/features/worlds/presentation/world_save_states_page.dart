import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/async_value_widget.dart';
import '../data/models/world_save_state.dart';
import '../data/world_save_state_repository.dart';
import '../application/world_context_controller.dart';

class WorldSaveStatesPage extends ConsumerWidget {
  const WorldSaveStatesPage({
    super.key,
    required this.worldId,
    required this.identityId,
  });

  final String worldId;
  final String identityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final asyncItems = ref.watch(_savesProvider(identityId));

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        title: const Text('选择存档'),
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
      body: AsyncValueWidget<List<WorldSaveState>>(
        value: asyncItems,
        empty: (items) => items.isEmpty,
        emptyTitle: '还没有存档',
        emptyPrimaryAction: FilledButton.icon(
          onPressed: () => _showCreateDialog(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('创建存档'),
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
                title: Text(it.title ?? 'Slot ${it.slot}'),
                subtitle: it.summary == null ? null : Text(it.summary!),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  ref.read(worldContextControllerProvider.notifier).setSave(
                        worldId: worldId,
                        identityId: identityId,
                        saveId: it.id,
                      );
                  await ref
                      .read(worldSaveStateRepositoryProvider)
                      .touchLastPlayed(it.id);

                  // Temporary: jump into chat placeholder for now.
                  context.go('/os/apps/chat');
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
    final slotController = TextEditingController(text: '1');
    final titleController = TextEditingController();

    try {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('创建存档'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: slotController,
                  decoration: const InputDecoration(labelText: 'Slot（正整数）'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: '标题（可选）'),
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
      final slot = int.tryParse(slotController.text.trim());
      if (slot == null || slot <= 0) return;

      final repo = ref.read(worldSaveStateRepositoryProvider);
      await repo.create(
        worldId: worldId,
        identityId: identityId,
        slot: slot,
        title: titleController.text.trim().isEmpty ? null : titleController.text.trim(),
      );

      ref.invalidate(_savesProvider(identityId));
    } finally {
      slotController.dispose();
      titleController.dispose();
    }
  }
}

final _savesProvider = FutureProvider.family<List<WorldSaveState>, String>(
  (ref, identityId) async {
    final repo = ref.watch(worldSaveStateRepositoryProvider);
    return repo.listByIdentity(identityId);
  },
);
