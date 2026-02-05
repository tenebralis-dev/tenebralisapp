import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'app_icon.dart';
import 'dream_clock_card.dart';

/// App Grid Widget - Horizontal PageView with app icons
class AppGrid extends StatefulWidget {
  const AppGrid({
    super.key,
    required this.pages,
    required this.onAppTap,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 24,
    this.crossAxisSpacing = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  /// List of pages, each containing a list of AppItems
  final List<List<AppItem>> pages;

  /// Callback when an app is tapped
  final void Function(AppItem app) onAppTap;

  /// Number of columns in the grid
  final int crossAxisCount;

  /// Spacing between rows
  final double mainAxisSpacing;

  /// Spacing between columns
  final double crossAxisSpacing;

  /// Padding around the grid
  final EdgeInsets padding;

  @override
  State<AppGrid> createState() => _AppGridState();
}

class _AppGridState extends State<AppGrid> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main PageView
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, pageIndex) {
              return _buildPage(widget.pages[pageIndex], pageIndex);
            },
          ),
        ),

        // Material 3：使用更“克制”的指示器（不抢视觉层级）
        _PageIndicator(
          pageCount: widget.pages.length,
          currentPage: _currentPage,
          onPageTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPage(List<AppItem> apps, int pageIndex) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          if (pageIndex == 0) ...[
            const DreamClockCard(),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: AlignedGridView.count(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing,
              itemCount: apps.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final app = apps[index];
                // Calculate staggered animation delay
                final delay = Duration(milliseconds: 50 * index);

                return Center(
                  child: AppIcon(
                    id: app.id,
                    label: app.label,
                    icon: app.icon,
                    color: app.color,
                    badge: app.badge,
                    animationDelay: delay,
                    onTap: () => widget.onAppTap(app),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Page Indicator Dots
class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.pageCount,
    required this.currentPage,
    this.onPageTap,
  });

  final int pageCount;
  final int currentPage;
  final void Function(int index)? onPageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;
          return GestureDetector(
            onTap: () => onPageTap?.call(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          );
        }),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms, delay: 400.ms);
  }
}

/// Alternative Grid Layout - Staggered Grid for varied sizes
class StaggeredAppGrid extends StatelessWidget {
  const StaggeredAppGrid({
    super.key,
    required this.apps,
    required this.onAppTap,
    this.padding = const EdgeInsets.all(16),
  });

  final List<AppItem> apps;
  final void Function(AppItem app) onAppTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: apps.asMap().entries.map((entry) {
          final index = entry.key;
          final app = entry.value;

          // First app is larger (featured)
          final crossAxisCellCount = index == 0 ? 2 : 1;
          final mainAxisCellCount = index == 0 ? 2 : 1;

          return StaggeredGridTile.count(
            crossAxisCellCount: crossAxisCellCount,
            mainAxisCellCount: mainAxisCellCount,
            child: _LargeAppTile(
              app: app,
              onTap: () => onAppTap(app),
              isLarge: index == 0,
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Large App Tile for featured apps
class _LargeAppTile extends StatelessWidget {
  const _LargeAppTile({
    required this.app,
    required this.onTap,
    this.isLarge = false,
  });

  final AppItem app;
  final VoidCallback onTap;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final iconSize = isLarge ? 48.0 : 32.0;
    final fontSize = isLarge ? 16.0 : 12.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (app.color ?? const Color(0xFF6C63FF)).withValues(alpha: 0.4),
              (app.color ?? const Color(0xFF6C63FF)).withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              app.icon,
              size: iconSize,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              app.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search Bar Widget for the desktop
class DesktopSearchBar extends StatelessWidget {
  const DesktopSearchBar({
    super.key,
    this.onTap,
    this.hintText,
  });

  final String? hintText;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.5),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              hintText ?? 'Search apps...',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.2, curve: Curves.easeOut);
  }
}
