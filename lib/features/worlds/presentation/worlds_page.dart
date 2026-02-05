import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../data/models/world_model.dart';

/// Worlds Page - List and explore available worlds
class WorldsPage extends ConsumerStatefulWidget {
  const WorldsPage({super.key});

  @override
  ConsumerState<WorldsPage> createState() => _WorldsPageState();
}

class _WorldsPageState extends ConsumerState<WorldsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedGenre = 'all';

  final List<String> _genres = ['all', 'fantasy', 'sci-fi', 'modern', 'horror'];
  final Map<String, String> _genreLabels = {
    'all': '全部',
    'fantasy': '奇幻',
    'sci-fi': '科幻',
    'modern': '现代',
    'horror': '恐怖',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // App Bar
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
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: Implement search
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // TODO: Create new world
                    _showCreateWorldDialog();
                  },
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
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF6C63FF),
                tabs: const [
                  Tab(text: '探索'),
                  Tab(text: '我的'),
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            // Genre Filter
            _buildGenreFilter()
                .animate()
                .fadeIn(delay: 100.ms),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Explore Tab
                  _buildWorldsList(isPublic: true),
                  // My Worlds Tab
                  _buildWorldsList(isPublic: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          final genre = _genres[index];
          final isSelected = genre == _selectedGenre;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedGenre = genre;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6C63FF)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6C63FF)
                      : Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                _genreLabels[genre] ?? genre,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorldsList({required bool isPublic}) {
    // For now, show mock data
    // In production, this would use ref.watch(publicWorldsProvider) or similar
    final mockWorlds = _getMockWorlds();

    if (mockWorlds.isEmpty) {
      return _buildEmptyState(isPublic);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockWorlds.length,
      itemBuilder: (context, index) {
        final world = mockWorlds[index];
        return WorldCard(
          world: world,
          onTap: () => _onWorldTap(world),
        )
            .animate(delay: Duration(milliseconds: 50 * index))
            .fadeIn()
            .slideX(begin: 0.1);
      },
    );
  }

  Widget _buildEmptyState(bool isPublic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isPublic ? Icons.public_off : Icons.folder_open,
            size: 64,
            color: Colors.white30,
          ),
          const SizedBox(height: 16),
          Text(
            isPublic ? '暂无公开世界' : '你还没有创建世界',
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 8),
          if (!isPublic)
            TextButton.icon(
              onPressed: _showCreateWorldDialog,
              icon: const Icon(Icons.add),
              label: const Text('创建第一个世界'),
            ),
        ],
      ),
    );
  }

  void _onWorldTap(WorldModel world) {
    // TODO: Navigate to world detail or enter world
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WorldDetailSheet(world: world),
    );
  }

  void _showCreateWorldDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('创建世界功能即将推出'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  List<WorldModel> _getMockWorlds() {
    return [
      WorldModel(
        id: '1',
        name: '星际迷途',
        genre: 'sci-fi',
        description: '在遥远的未来，人类已经殖民了银河系。你是一名星际探险家...',
        settings: const WorldSettings(
          systemPrompt: 'You are a sci-fi world narrator...',
        ),
      ),
      WorldModel(
        id: '2',
        name: '魔法学院',
        genre: 'fantasy',
        description: '欢迎来到艾德拉魔法学院，这里是培养年轻法师的圣地...',
        settings: const WorldSettings(
          systemPrompt: 'You are a fantasy world narrator...',
        ),
      ),
      WorldModel(
        id: '3',
        name: '都市传说',
        genre: 'modern',
        description: '繁华都市的背后，隐藏着不为人知的秘密...',
        settings: const WorldSettings(
          systemPrompt: 'You are a modern world narrator...',
        ),
      ),
      WorldModel(
        id: '4',
        name: '暗夜庄园',
        genre: 'horror',
        description: '古老的庄园在夜色中显得格外诡异，据说这里曾发生过...',
        settings: const WorldSettings(
          systemPrompt: 'You are a horror world narrator...',
        ),
      ),
    ];
  }
}

/// World Card Widget
class WorldCard extends StatelessWidget {
  const WorldCard({
    super.key,
    required this.world,
    required this.onTap,
  });

  final WorldModel world;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final genreColor = _getGenreColor(world.genre);

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
                          _getGenreIcon(world.genre),
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
                                _getGenreLabel(world.genre),
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
                        icon: Icons.people_outline,
                        label: '${world.settings?.npcs.length ?? 0} NPC',
                      ),
                      const SizedBox(width: 12),
                      _StatChip(
                        icon: Icons.flag_outlined,
                        label: '${world.settings?.quests.length ?? 0} 任务',
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

  Color _getGenreColor(String genre) {
    switch (genre) {
      case 'fantasy':
        return const Color(0xFF9C27B0);
      case 'sci-fi':
        return const Color(0xFF00BCD4);
      case 'modern':
        return const Color(0xFF4CAF50);
      case 'horror':
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF6C63FF);
    }
  }

  IconData _getGenreIcon(String genre) {
    switch (genre) {
      case 'fantasy':
        return Icons.auto_fix_high;
      case 'sci-fi':
        return Icons.rocket_launch;
      case 'modern':
        return Icons.location_city;
      case 'horror':
        return Icons.nightlight;
      default:
        return Icons.public;
    }
  }

  String _getGenreLabel(String genre) {
    switch (genre) {
      case 'fantasy':
        return '奇幻';
      case 'sci-fi':
        return '科幻';
      case 'modern':
        return '现代';
      case 'horror':
        return '恐怖';
      default:
        return genre;
    }
  }
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
class WorldDetailSheet extends StatelessWidget {
  const WorldDetailSheet({super.key, required this.world});

  final WorldModel world;

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
