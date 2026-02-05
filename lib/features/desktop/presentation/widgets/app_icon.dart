import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/strings.dart';
import '../../icon_customization/presentation/controllers/icon_customization_controller.dart';
import '../../icon_customization/presentation/controllers/icon_shape_controller.dart';
import '../../icon_customization/domain/icon_customization.dart';
import '../../icon_customization/domain/icon_shape.dart';
import '../constants/dream_os_home_colors.dart';
import '../controllers/wallpaper_controller.dart';
import '../controllers/wallpaper_contrast_controller.dart';

String resolveAppLabel(AppStrings s, String labelKey) {
    switch (labelKey) {
    case 'affection':
      return s.appAffection;
    case 'identity':
      return s.appIdentity;
    case 'worlds':
      return s.appWorlds;
    case 'forum':
      return s.appForum;
    case 'shop':
      return s.appShop;
    case 'achievement':
      return s.appAchievement;
    case 'memo':
      return s.appMemo;
    case 'ledger':
      return s.appLedger;
    case 'gallery':
      return s.appGallery;
    case 'calendar':
      return s.appCalendar;
    case 'pomodoro':
      return s.appPomodoro;
    case 'music':
      return s.appMusic;
    case 'connection':
      return s.appConnection;
    case 'settings':
      return s.appSettings;
    case 'customize':
      return s.appCustomize;
    // Dock
    case 'dream':
      return s.dockDream;
    case 'chat':
      return s.dockChat;
    case 'quest':
      return s.dockQuest;
    case 'profile':
      return s.dockProfile;
    default:
      return labelKey;
  }
}

/// App Icon Widget for the Desktop Grid
/// Displays an app with icon, label, and optional badge
class AppIcon extends ConsumerStatefulWidget {
  const AppIcon({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
    this.color,
    this.badge,
    this.onTap,
    this.onLongPress,
    this.size = 64,
    this.showLabel = true,
    this.animationDelay = Duration.zero,
  });

  final String id;

  /// labelKey, e.g. 'settings', 'connection'
  final String label;
  final IconData icon;
  final Color? color;
  final String? badge;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double size;
  final bool showLabel;
  final Duration animationDelay;

  @override
  ConsumerState<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends ConsumerState<AppIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
    HapticFeedback.selectionClick();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final resolvedLabel = resolveAppLabel(s, widget.label);
    final iconColor = widget.color ?? const Color(0xFF6C63FF);

    final customization = ref.watch(
      iconCustomizationControllerProvider.select(
        (v) => v.valueOrNull?[widget.id],
      ),
    );

    final iconShape = ref.watch(iconShapeControllerProvider).valueOrNull ??
        IconShape.roundedRect;
    // 使用壁纸时：根据壁纸明暗，为 icon/label 提供统一的前景色。
    // 未使用壁纸时：保持原有主题色。
    final hasWallpaper = ref.watch(wallpaperControllerProvider).isNone == false;
    final useLightFg = ref.watch(wallpaperLightForegroundProvider);
    final fgColor = hasWallpaper
        ? (useLightFg ? Colors.white : Colors.black)
        : Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      // 仍保留轻触缩放 + 触觉反馈，但点击行为交给 InkWell（符合 Material）。
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: SizedBox(
          width: widget.size + 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container（Material 3：使用 tonal surface + 明确的状态层）
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Material(
                    color: _tileBackgroundColor(
                      iconColor: iconColor,
                      customization: customization,
                      isDock: _isDockKey(widget.id),
                    ),
                    borderRadius: BorderRadius.circular(_tileRadius(widget.size, iconShape)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(_tileRadius(widget.size, iconShape)),
                      onTap: widget.onTap,
                      onLongPress: widget.onLongPress,
                      child: SizedBox(
                        width: widget.size,
                        height: widget.size,
                        child: Center(
                          child: _AppIconGlyph(
                            defaultIcon: widget.icon,
                            tileSize: widget.size,
                            fgColor: fgColor,
                            customization: customization,
                            shape: iconShape,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Badge
                  if (widget.badge != null)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Badge(
                        label: Text(widget.badge!),
                      ),
                    ),
                ],
              ),
              // Label
              if (widget.showLabel) ...[
                const SizedBox(height: 8),
                Text(
                  resolvedLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: fgColor,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    )
        .animate(delay: widget.animationDelay)
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }
}

class _AppIconGlyph extends StatelessWidget {
  const _AppIconGlyph({
    required this.defaultIcon,
    required this.tileSize,
    required this.fgColor,
    required this.customization,
    required this.shape,
  });

  final IconData defaultIcon;

  /// 外层 tile 的尺寸（也就是 AppIcon 的正方形区域）。
  final double tileSize;

  final Color fgColor;
  final IconCustomization? customization;
  final IconShape shape;

  @override
  Widget build(BuildContext context) {
    final c = customization;

    // 目标：自定义 icon（图片）尺寸对齐 tile 尺寸，而不是默认 icon 的 glyph 尺寸。
    // - 自定义图片（file/url）：使用 tileSize 作为绘制宽高。
    // - 默认 IconData：仍使用更小的 glyph 尺寸，保持原先的“图标”观感。
    final glyphSize = tileSize * 0.52;

    if (c == null) {
      return Icon(defaultIcon, size: glyphSize, color: fgColor);
    }

    switch (c.type) {
      case IconCustomizationType.preset:
        // 预设图标仍按 glyph 显示（否则会变成“贴图”效果）。
        final presetIcon = _presetIconData[c.presetId] ?? defaultIcon;
        return Icon(presetIcon, size: glyphSize, color: fgColor);

      case IconCustomizationType.file:
        final path = c.filePath;
        if (path == null || path.isEmpty) {
          return Icon(defaultIcon, size: glyphSize, color: fgColor);
        }

        final file = File(path);
        if (!file.existsSync()) {
          return Icon(defaultIcon, size: glyphSize, color: fgColor);
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(_glyphRadius(tileSize, shape)),
          child: Image.file(
            file,
            width: tileSize,
            height: tileSize,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(defaultIcon, size: glyphSize, color: fgColor),
          ),
        );

      case IconCustomizationType.url:
        final url = c.url;
        if (url == null || url.isEmpty) {
          return Icon(defaultIcon, size: glyphSize, color: fgColor);
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(_glyphRadius(tileSize, shape)),
          child: CachedNetworkImage(
            imageUrl: url,
            width: tileSize,
            height: tileSize,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 120),
            placeholder: (_, __) => Icon(defaultIcon, size: glyphSize, color: fgColor),
            errorWidget: (_, __, ___) => Icon(defaultIcon, size: glyphSize, color: fgColor),
          ),
        );
    }
  }
}

/// 预设图标占位映射。
///
/// 你后续提供图标包/资源后，我们把 presetId 替换成更完整的集合。
const Map<String, IconData> _presetIconData = {
  'tune': Icons.tune,
  'star': Icons.star_outline,
  'heart': Icons.favorite_outline,
  'spark': Icons.auto_awesome,
};

bool _isDockKey(String appKey) {
  return appKey == 'dream' ||
      appKey == 'chat' ||
      appKey == 'quest' ||
      appKey == 'profile';
}

double _glyphRadius(double glyphSize, IconShape shape) {
  switch (shape) {
    case IconShape.square:
      return 0;
    case IconShape.roundedRect:
      return glyphSize * 0.22;
    case IconShape.superRoundedRect:
      return glyphSize * 0.42;
    case IconShape.circle:
      return glyphSize;
  }
}

double _tileRadius(double tileSize, IconShape shape) {
  // tile 的圆角可以比 glyph 略大一点，视觉更柔和。
  switch (shape) {
    case IconShape.square:
      return 0;
    case IconShape.roundedRect:
      return tileSize * 0.28;
    case IconShape.superRoundedRect:
      return tileSize * 0.46;
    case IconShape.circle:
      return tileSize;
  }
}

Color _tileBackgroundColor({
  required Color iconColor,
  required IconCustomization? customization,
  required bool isDock,
}) {
  // 规则（来自你的反馈）：
  // 1) Dock 内默认只有 dock container 背景，不要 tile 背景。
  // 2) Dock 内一旦有自定义图标，会去掉 dock container 背景；同时 tile 仍保持无背景。
  // 3) Dock 外：默认有 tile 背景；但如果该 icon 被自定义，则 tile 背景去掉。
  if (isDock) return Colors.transparent;
  if (customization != null) return Colors.transparent;
  return iconColor.withValues(alpha: 0.16);
}

/// App Item Data Model
class AppItem {
  const AppItem({
    required this.id,
    required this.label,
    required this.icon,
    this.color,
    this.route,
    this.badge,
  });

  final String id;

  /// labelKey, e.g. 'settings'
  final String label;
  final IconData icon;
  final Color? color;
  final String? route;
  final String? badge;

  /// Create AppItem from ID with default values
  factory AppItem.fromId(String id) {
    return _appRegistry[id] ??
        AppItem(id: id, label: id, icon: Icons.apps_outlined);
  }
}

/// Registry of all available apps
///
/// 注意：这里的 label 只是一个 key（如 'settings'），实际显示文案在 `resolveAppLabel()`
/// 中根据 `stringsProvider` 的 locale 动态解析。
final Map<String, AppItem> _appRegistry = {
  // Page 1 Apps
  'affection': const AppItem(
    id: 'affection',
    label: 'affection',
    icon: Icons.favorite_outline,
    color: Color(0xFFE91E63),
    route: '/os/apps/affection',
  ),
  'identity': const AppItem(
    id: 'identity',
    label: 'identity',
    icon: Icons.badge_outlined,
    color: Color(0xFF9C27B0),
    route: '/os/apps/identity',
  ),
  'worlds': const AppItem(
    id: 'worlds',
    label: 'worlds',
    icon: Icons.public,
    color: Color(0xFF2196F3),
    route: '/os/apps/worlds',
  ),
  'forum': const AppItem(
    id: 'forum',
    label: 'forum',
    icon: Icons.forum_outlined,
    color: Color(0xFF00BCD4),
    route: '/os/apps/forum',
  ),
  'shop': const AppItem(
    id: 'shop',
    label: 'shop',
    icon: Icons.shopping_bag_outlined,
    color: Color(0xFFFF9800),
    route: '/os/apps/shop',
  ),
  'achievement': const AppItem(
    id: 'achievement',
    label: 'achievement',
    icon: Icons.emoji_events_outlined,
    color: Color(0xFFFFD700),
    route: '/os/apps/achievement',
  ),

  // Page 2 Apps
  'memo': const AppItem(
    id: 'memo',
    label: 'memo',
    icon: Icons.note_outlined,
    color: Color(0xFFFFEB3B),
    route: '/os/apps/memo',
  ),
  'ledger': const AppItem(
    id: 'ledger',
    label: 'ledger',
    icon: Icons.account_balance_wallet_outlined,
    color: Color(0xFF4CAF50),
    route: '/os/apps/ledger',
  ),
  'gallery': const AppItem(
    id: 'gallery',
    label: 'gallery',
    icon: Icons.photo_library_outlined,
    color: Color(0xFF03A9F4),
    route: '/os/apps/gallery',
  ),
  'calendar': const AppItem(
    id: 'calendar',
    label: 'calendar',
    icon: Icons.calendar_today_outlined,
    color: Color(0xFFFF5722),
    route: '/os/apps/calendar',
  ),
  'pomodoro': const AppItem(
    id: 'pomodoro',
    label: 'pomodoro',
    icon: Icons.timer_outlined,
    color: Color(0xFFF44336),
    route: '/os/apps/pomodoro',
  ),
  'music': const AppItem(
    id: 'music',
    label: 'music',
    icon: Icons.music_note_outlined,
    color: Color(0xFF1DB954),
    route: '/os/apps/music',
  ),

  // Page 3 Apps
  'connection': AppItem(
    id: 'connection',
    label: 'connection',
    icon: Icons.link,
    color: DreamOSHomeColors.colorScheme.tertiary,
    route: '/os/connection',
  ),
  'settings': const AppItem(
    id: 'settings',
    label: 'settings',
    icon: Icons.settings_outlined,
    color: Color(0xFF9E9E9E),
    route: '/os/apps/settings',
  ),
  'customize': const AppItem(
    id: 'customize',
    label: 'customize',
    icon: Icons.tune,
    color: Color(0xFF8E24AA),
    route: '/os/apps/customize',
  ),
};

/// Get all apps for the grid pages
class AppGridConfig {
  static const List<List<String>> pages = [
    ['affection', 'identity', 'worlds', 'forum', 'shop', 'achievement'],
    ['memo', 'ledger', 'gallery', 'calendar', 'pomodoro', 'music'],
    ['customize', 'connection', 'settings'],
  ];

  static List<List<AppItem>> getAppPages() {
    return pages.map((page) {
      return page.map((id) => AppItem.fromId(id)).toList();
    }).toList();
  }
}
