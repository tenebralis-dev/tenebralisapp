import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';

import '../../../app/system_ui.dart';

import 'constants/dream_os_home_colors.dart';
import '../../../app/strings.dart';
import 'widgets/dream_os_scaffold.dart';
import 'widgets/dock.dart';
import 'widgets/app_icon.dart';
import 'widgets/app_grid.dart';
import 'controllers/wallpaper_controller.dart';
import 'controllers/wallpaper_contrast_controller.dart';

/// Dream OS Main Page - The "fake" phone interface
/// This is the main wrapper that contains:
/// - Full-screen wallpaper background
/// - App Grid (PageView)
/// - Bottom Dock
class DreamOSPage extends ConsumerStatefulWidget {
  const DreamOSPage({super.key});

  @override
  ConsumerState<DreamOSPage> createState() => _DreamOSPageState();
}

class _DreamOSPageState extends ConsumerState<DreamOSPage> {
  String? _selectedDockItem;

  @override
  void initState() {
    super.initState();
    // Dock 不需要默认选中“梦境”，保持未选中状态。
    _selectedDockItem = null;
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final appPages = AppGridConfig.getAppPages();

    final wallpaper = ref.watch(wallpaperControllerProvider);
    final hasWallpaper = wallpaper.isNone == false;
    final useLightFg = ref.watch(wallpaperLightForegroundProvider);

    // 状态栏：有壁纸时跟随壁纸对比度（黑/白）；无壁纸时跟随主题。
    if (hasWallpaper) {
      applyStatusBarForWallpaper(useLightForeground: useLightFg);
    } else {
      applyStatusBarForBrightness(Theme.of(context).brightness);
    }

    final overlayStyle = hasWallpaper
        ? SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                useLightFg ? Brightness.light : Brightness.dark,
            statusBarBrightness: useLightFg ? Brightness.light : Brightness.dark,
          )
        : (Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: DreamOSScaffold(
        wallpaperPath: wallpaper.isNone ? null : wallpaper.value,
        body: Column(
          children: [
            // App Grid
            Expanded(
              child: AppGrid(
                pages: appPages,
                onAppTap: _handleAppTap,
              ),
            ),
          ],
        ),
        dock: DreamOSDock(
          items: DockItems.localized(s),
          selectedId: _selectedDockItem,
          onItemTap: _handleDockTap,
        ),
      ),
    );
  }

  /// Build the welcome header
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting based on time
          Text(
            _getGreeting(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          // Main Title
          Row(
            children: [
              Text(
                '界影浮光',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              // Material 3：使用 Chip 来表达“状态/标签”
              Chip(
                label: const Text('Dream OS'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.1, curve: Curves.easeOut);
  }

  /// Get greeting based on time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return '夜深了，注意休息';
    if (hour < 12) return '早安，新的一天开始了';
    if (hour < 14) return '中午好，记得吃饭';
    if (hour < 18) return '下午好，继续加油';
    if (hour < 22) return '晚上好，辛苦了一天';
    return '夜深了，注意休息';
  }

  /// Handle app icon tap
  void _handleAppTap(AppItem app) {
    if (app.route != null) {
      context.push(app.route!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${resolveAppLabel(ref.read(stringsProvider), app.label)} 即将推出'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// Handle dock item tap
  void _handleDockTap(DockItem item) {
    setState(() {
      _selectedDockItem = item.id;
    });

    if (item.route != null) {
      context.push(item.route!);
    }

    // Reset selection after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _selectedDockItem = null;
        });
      }
    });
  }
}

/// Points Display Widget
class PointsDisplay extends StatelessWidget {
  const PointsDisplay({
    super.key,
    required this.points,
    this.onTap,
  });

  final int points;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.stars,
              size: 16,
              color: Color(0xFFFFD700),
            ),
            const SizedBox(width: 4),
            Text(
              _formatPoints(points),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPoints(int points) {
    if (points >= 1000000) {
      return '${(points / 1000000).toStringAsFixed(1)}M';
    } else if (points >= 1000) {
      return '${(points / 1000).toStringAsFixed(1)}K';
    }
    return points.toString();
  }
}

/// Quick Action Button Widget
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? const Color(0xFF6C63FF);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              buttonColor.withValues(alpha: 0.3),
              buttonColor.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: buttonColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: buttonColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
