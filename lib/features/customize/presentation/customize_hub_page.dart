import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../theme/presentation/theme_customization_page.dart';
import '../../settings/presentation/font_settings_page.dart';
import '../../settings/presentation/wallpaper_settings_sheet.dart';
import '../../desktop/icon_customization/presentation/icon_customize_page.dart';

/// Customize Hub
///
/// Aggressive migration (H3): move UI-related settings (theme/font/wallpaper)
/// into Customize entry.
class CustomizeHubPage extends ConsumerWidget {
  const CustomizeHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(s.appCustomize)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _NavCard(
            icon: Icons.palette_outlined,
            title: '自定义全局配色',
            subtitle: '创建/保存/应用配色方案，可选同步到云端',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ThemeCustomizationPage()),
            ),
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Icons.font_download_outlined,
            title: s.fontTitle,
            subtitle: s.fontSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FontSettingsPage()),
            ),
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Icons.wallpaper_outlined,
            title: s.wallpaperTitle,
            subtitle: s.wallpaperSubtitle,
            onTap: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (_) => const WallpaperSettingsSheet(),
            ),
          ),
          const SizedBox(height: 12),
          _NavCard(
            icon: Icons.apps_outlined,
            title: '图标与布局',
            subtitle: '图标形状与每个 App 的图标自定义',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const IconCustomizePage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
