import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/api_connection.dart';
import 'controllers/connections_list_controller.dart';
import 'connection_editor_page.dart';
import 'widgets/connection_card.dart';

class ConnectionsPage extends ConsumerWidget {
  const ConnectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(connectionsListControllerProvider);
    final filter = ref.watch(connectionFilterProvider);

    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('连接'),
        actions: [
          IconButton(
            tooltip: '新增连接',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ConnectionEditorPage(),
                ),
              );
              // Refresh list immediately after returning from editor.
              await ref.read(connectionsListControllerProvider.notifier).refreshAll();
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _FilterBar(
              value: filter,
              onChanged: (next) =>
                  ref.read(connectionFilterProvider.notifier).state = next,
            ),
          ),
          Expanded(
            child: asyncState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorView(message: e.toString()),
              data: (state) {
                final showCloud =
                    filter == ConnectionListFilter.all ||
                    filter == ConnectionListFilter.cloudOnly;
                final showLocal =
                    filter == ConnectionListFilter.all ||
                    filter == ConnectionListFilter.localOnly;

                final cloudItems = state.cloud
                    .where((c) => showCloud)
                    .map((c) => ConnectionListItem.cloud(connection: c))
                    .toList();
                final localItems = state.local
                    .where((c) => showLocal)
                    .map((c) => ConnectionListItem.local(connection: c))
                    .toList();

                if (!showCloud && !showLocal) {
                  return const Center(child: Text('无可用筛选结果'));
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  children: [
                    if (showCloud)
                      _Section(
                        title: '云端连接',
                        subtitle: '同步到 Supabase（不含密钥）',
                        children: cloudItems.isEmpty
                            ? [const _EmptyHint(text: '暂无云端连接')]
                            : cloudItems
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ConnectionCard(item: item),
                                  ),
                                )
                                .toList(),
                      ),
                    if (showCloud && showLocal) const SizedBox(height: 16),
                    if (showLocal)
                      _Section(
                        title: '本地连接',
                        subtitle: '仅当前设备可见',
                        children: localItems.isEmpty
                            ? [const _EmptyHint(text: '暂无本地连接')]
                            : localItems
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ConnectionCard(item: item),
                                  ),
                                )
                                .toList(),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum ConnectionListFilter { all, cloudOnly, localOnly }

final connectionFilterProvider =
    StateProvider<ConnectionListFilter>((_) => ConnectionListFilter.all);

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.value, required this.onChanged});

  final ConnectionListFilter value;
  final ValueChanged<ConnectionListFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ConnectionListFilter>(
      segments: const [
        ButtonSegment(
          value: ConnectionListFilter.all,
          label: Text('全部'),
          icon: Icon(Icons.layers_outlined),
        ),
        ButtonSegment(
          value: ConnectionListFilter.cloudOnly,
          label: Text('仅云端'),
          icon: Icon(Icons.cloud_outlined),
        ),
        ButtonSegment(
          value: ConnectionListFilter.localOnly,
          label: Text('仅本地'),
          icon: Icon(Icons.phone_android_outlined),
        ),
      ],
      selected: {value},
      onSelectionChanged: (set) {
        if (set.isEmpty) return;
        onChanged(set.first);
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 40),
            const SizedBox(height: 12),
            Text(
              '加载失败',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
