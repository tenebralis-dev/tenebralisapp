import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/api_connection.dart';
import '../controllers/connections_list_controller.dart';
import 'source_badge.dart';

class ConnectionCard extends ConsumerWidget {
  const ConnectionCard({super.key, required this.item});

  final ConnectionListItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    final (title, subtitle, isActive, badge) = item.when(
      cloud: (connection) => (
        connection.base.name,
        connection.base.baseUrl,
        connection.base.isActive,
        const SourceBadge.cloud(),
      ),
      local: (connection) => (
        connection.base.name,
        connection.base.baseUrl,
        connection.base.isActive,
        const SourceBadge.local(),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              badge,
              const SizedBox(width: 8),
              Switch.adaptive(
                value: isActive,
                onChanged: (v) => ref
                    .read(connectionsListControllerProvider.notifier)
                    .toggleActive(item: item, isActive: v),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => ref
                      .read(connectionsListControllerProvider.notifier)
                      .quickTest(item: item, context: context),
                  icon: const Icon(Icons.bolt_outlined),
                  label: const Text('测试'),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filledTonal(
                tooltip: '更多',
                onPressed: () => _showMenu(context, ref),
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showMenu(BuildContext context, WidgetRef ref) async {
    final action = await showModalBottomSheet<_ConnectionAction>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('编辑'),
                onTap: () => Navigator.of(context).pop(_ConnectionAction.edit),
              ),
              ListTile(
                leading: const Icon(Icons.copy_all_outlined),
                title: const Text('复制为本地副本'),
                subtitle: const Text('云端连接会保留，本地新增一条'),
                onTap: () => Navigator.of(context).pop(_ConnectionAction.copyToLocal),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error),
                title: Text(
                  '删除',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () => Navigator.of(context).pop(_ConnectionAction.delete),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (action == null) return;

    switch (action) {
      case _ConnectionAction.edit:
        await ref.read(connectionsListControllerProvider.notifier).openEditor(
              item: item,
              context: context,
            );
      case _ConnectionAction.copyToLocal:
        await ref
            .read(connectionsListControllerProvider.notifier)
            .copyToLocal(item: item);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('已复制为本地连接')), 
          );
        }
      case _ConnectionAction.delete:
        final ok = await _confirmDelete(context);
        if (!ok) return;
        await ref.read(connectionsListControllerProvider.notifier).delete(item);
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除连接？'),
          content: const Text('该操作不可撤销。密钥（本地）也会一并删除。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
    return ok == true;
  }
}

enum _ConnectionAction { edit, copyToLocal, delete }
