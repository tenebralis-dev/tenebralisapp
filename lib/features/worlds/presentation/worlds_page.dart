import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/async_value_widget.dart';
import '../application/worlds_providers.dart';
import '../data/models/world.dart';

/// Worlds Page - List and explore available worlds
class WorldsPage extends ConsumerStatefulWidget {
  const WorldsPage({super.key});

  @override
  ConsumerState<WorldsPage> createState() => _WorldsPageState();
}

class _WorldsPageState extends ConsumerState<WorldsPage> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final asyncWorlds = ref.watch(myWorldsProvider);

    return Scaffold(
      backgroundColor: scheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showCreateWorldDialog(context),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('世界'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF2196F3).withValues(alpha: 0.3),
                        scheme.background,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: AsyncValueWidget<List<World>>(
          value: asyncWorlds,
          empty: (items) => items.isEmpty,
          emptyTitle: '你还没有创建世界',
          emptyPrimaryAction: TextButton.icon(
            onPressed: () => _showCreateWorldDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('创建第一个世界'),
          ),
          data: (worlds) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: worlds.length,
              itemBuilder: (context, index) {
                final world = worlds[index];
                return _WorldCard(
                  world: world,
                  onTap: () => _onWorldTap(world),
                )
                    .animate(delay: Duration(milliseconds: 50 * index))
                    .fadeIn()
                    .slideX(begin: 0.1);
              },
            );
          },
        ),
      ),
    );
  }

  void _onWorldTap(World world) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _WorldDetailSheet(world: world),
    );
  }

  Future<void> _showCreateWorldDialog(BuildContext context) async {
    final repo = ref.read(worldsRepositoryProvider);

    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    try {
      final created = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('创建世界'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '名称',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '简介（可选）',
                  ),
                  minLines: 1,
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('创建'),
              ),
            ],
          );
        },
      );

      if (created != true) return;

      final name = nameController.text.trim();
      final description = descriptionController.text.trim();

      if (name.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('名称不能为空')),
          );
        }
        return;
      }

      await repo.createWorld(
        name: name,
        description: description.isEmpty ? null : description,
      );

      ref.invalidate(myWorldsProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('创建成功')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('创建失败：$e')),
        );
      }
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }
}

/// World Card Widget
class _WorldCard extends StatelessWidget {
  const _WorldCard({
    required this.world,
    required this.onTap,
  });

  final World world;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final genreColor = _getGenreColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              genreColor.withValues(alpha: 0.2),
              genreColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: genreColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      // Genre Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: genreColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getGenreIcon(),
                          color: genreColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title & Genre
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              world.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: genreColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _getGenreLabel(),
                                style: TextStyle(
                                  color: genreColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Arrow
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                  // Description
                  if (world.description != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      world.description!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  // Stats
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _StatChip(
                        icon: Icons.person_outline,
                        label: world.slug ?? '未设置 slug',
                      ),
                      const SizedBox(width: 12),
                      _StatChip(
                        icon: Icons.update,
                        label: world.updatedAt == null
                            ? '未同步'
                            : '已同步',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getGenreColor() => const Color(0xFF6C63FF);

  IconData _getGenreIcon() => Icons.public;

  String _getGenreLabel() => '世界';
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white54),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/// World Detail Bottom Sheet
class _WorldDetailSheet extends StatelessWidget {
  const _WorldDetailSheet({required this.world});

  final World world;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  world.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                // Description
                if (world.description != null)
                  Text(
                    world.description!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                const SizedBox(height: 24),
                // Enter Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Enter world and start chat
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('正在进入 ${world.name}...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('进入世界'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
