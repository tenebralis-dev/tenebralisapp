import 'dart:io';

import 'package:flutter/material.dart';

/// DreamOSScaffold - 登录后主界面外壳。
///
/// 目标：让主界面更贴近 Material 3（Material Design）而不是“玻璃拟物”。
///
/// 保留：可选壁纸背景。
/// 移除：强玻璃化、星空/渐变遮罩等会与 Material 3 的“surface 层级”冲突的表现。
class DreamOSScaffold extends StatelessWidget {
  const DreamOSScaffold({
    super.key,
    required this.body,
    required this.dock,
    this.statusBar,
    this.wallpaperPath,
    this.showStatusBar = false,
  });

  /// Main content area (usually AppGrid)
  final Widget body;

  /// Bottom dock widget
  final Widget dock;

  /// Custom status bar widget (optional)
  final Widget? statusBar;

  /// Custom wallpaper image path
  final String? wallpaperPath;

  /// Whether to show the status bar
  final bool showStatusBar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.background,
      body: Stack(
        children: [
          if (wallpaperPath != null) _buildBackground(context),

          // Material 3 关键：把内容放在“surface 容器”上，避免直接叠在复杂背景上。
          SafeArea(
            child: Column(
              children: [
                if (showStatusBar) statusBar ?? _DreamOSStatusBar(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Material(
                      // 使用壁纸时，去除“整体内容容器”的背景层，让图标/小组件直接浮在壁纸之上。
                      color: wallpaperPath == null
                          ? scheme.surfaceContainerHighest
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: body,
                      ),
                    ),
                  ),
                ),

                dock,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the background layer
  Widget _buildBackground(BuildContext context) {
    final path = wallpaperPath;
    if (path == null || path.trim().isEmpty) {
      return _buildDefaultBackground(context);
    }

    final uri = Uri.tryParse(path);
    final isRemote = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');

    final ImageProvider provider;
    if (isRemote) {
      provider = NetworkImage(path);
    } else {
      // Try local file first (picked from device). If it doesn't exist, fall back to asset.
      final file = File(path);
      if (file.existsSync()) {
        provider = FileImage(file);
      } else {
        provider = AssetImage(path);
      }
    }

    return Positioned.fill(
      child: Image(
        image: provider,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultBackground(context),
      ),
    );
  }

  /// Default background：Material 3 下使用纯色 surface，避免强装饰背景干扰层级。
  Widget _buildDefaultBackground(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(color: Theme.of(context).colorScheme.background),
    );
  }
}

/// Default Status Bar for Dream OS
class _DreamOSStatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          _TimeWidget(),

          // System Indicators
          Row(
            children: [
              Icon(
                Icons.signal_cellular_4_bar,
                size: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.wifi,
                size: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.battery_full,
                size: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Animated Time Widget
class _TimeWidget extends StatefulWidget {
  @override
  State<_TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<_TimeWidget> {
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 60 - _currentTime.second), () {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');

    final scheme = Theme.of(context).colorScheme;

    return Text(
      '$hour:$minute',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: scheme.onBackground,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
    );
  }
}

// （已移除星空装饰绘制，避免与 Material 3 的 surface 层级冲突。）

// 旧的玻璃遮罩组件已保留注释位（如后续需要做 Dialog 统一样式，可改用 Material 3 的 Dialog/AlertDialog）。
