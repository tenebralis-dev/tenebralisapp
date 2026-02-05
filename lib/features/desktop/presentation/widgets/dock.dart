import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/strings.dart';
import '../../icon_customization/presentation/controllers/icon_customization_controller.dart';
import 'app_icon.dart';
import '../controllers/wallpaper_controller.dart';
import '../controllers/wallpaper_contrast_controller.dart';

/// Bottom Dock for Dream OS
/// Contains the main navigation apps: dream, chat, quest, profile
class DreamOSDock extends ConsumerWidget {
  const DreamOSDock({
    super.key,
    required this.items,
    this.selectedId,
    required this.onItemTap,
    this.height = 80,
  });

  bool get _hasSelection => selectedId != null;

  /// List of dock items
  final List<DockItem> items;

  /// Currently selected item ID
  final String? selectedId;

  /// Callback when an item is tapped
  final void Function(DockItem item) onItemTap;

  /// Dock height
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    final hasWallpaper = ref.watch(wallpaperControllerProvider).isNone == false;
    final useLightFg = ref.watch(wallpaperLightForegroundProvider);
    final fgColor = hasWallpaper
        ? (useLightFg ? Colors.white : Colors.black)
        : scheme.onSurface;

    final dockKeys = items.map((e) => e.id).toList(growable: false);
    final dockHasAnyCustom = ref.watch(dockHasAnyCustomIconProvider(dockKeys));
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: dockHasAnyCustom
                  ? Colors.transparent
                  : (hasWallpaper
                      ? scheme.surface.withValues(alpha: 0.18)
                      : scheme.surfaceContainer),
              borderRadius: BorderRadius.circular(24),
            ),
            child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor:
                  _hasSelection ? scheme.secondaryContainer : Colors.transparent,
            ),
            child: Row(
              children: [
                for (final item in items)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => onItemTap(item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(
                              id: item.id,
                              label: item.id,
                              icon: item.icon,
                              color: item.color,
                              size: 40,
                              showLabel: false,
                              onTap: () => onItemTap(item),
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  item.label,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: fgColor.withValues(alpha: 0.86),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic);
  }
}

// 旧的 Dock 自绘按钮已由 Material 3 的 NavigationBar 替代。
/// Dock Item Data
class DockItem {
  const DockItem({
    required this.id,
    required this.label,
    required this.icon,
    this.color = const Color(0xFF6C63FF),
    this.route,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final String? route;
}

/// Default dock items for Dream OS
class DockItems {
  static List<DockItem> localized(AppStrings s) {
    return [
      DockItem(
        id: 'dream',
        label: s.dockDream,
        icon: Icons.auto_awesome,
        color: const Color(0xFF6C63FF),
        route: '/os/apps/dream',
      ),
      DockItem(
        id: 'chat',
        label: s.dockChat,
        icon: Icons.chat_bubble_outline,
        color: const Color(0xFF00D9FF),
        route: '/os/apps/chat',
      ),
      DockItem(
        id: 'quest',
        label: s.dockQuest,
        icon: Icons.flag_outlined,
        color: const Color(0xFFFF6B9D),
        route: '/os/apps/quest',
      ),
      DockItem(
        id: 'profile',
        label: s.dockProfile,
        icon: Icons.person_outline,
        color: const Color(0xFF4CAF50),
        route: '/os/apps/profile',
      ),
    ];
  }
}
