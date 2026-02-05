import 'package:flutter/material.dart';

/// 主页配色：FCD1D1, ECE2E1, D3E0DC, AEE1E1
/// Icon 保持原样，仅用于背景与表面色。
class DreamOSHomeColors {
  DreamOSHomeColors._();

  static const Color softPink = Color(0xFFFCD1D1);
  static const Color warmGray = Color(0xFFECE2E1);
  static const Color sage = Color(0xFFD3E0DC);
  static const Color mint = Color(0xFFAEE1E1);

  /// 主页背景（整页）
  static const Color background = warmGray;

  /// 内容区表面（圆角卡片）
  static const Color surface = sage;

  /// 底部导航栏背景
  static const Color dockBackground = mint;

  /// 底部导航选中指示
  static const Color dockIndicator = softPink;

  /// 用于主页的浅色 ColorScheme，保证文字/图标在浅底上为深色可读
  static ColorScheme get colorScheme => ColorScheme.light(
        primary: mint,
        onPrimary: const Color(0xFF1A1A1A),
        secondary: softPink,
        onSecondary: const Color(0xFF1A1A1A),
        surface: background,
        onSurface: const Color(0xFF2D2D2D),
        surfaceContainer: dockBackground,
        surfaceContainerHighest: surface,
        onSurfaceVariant: const Color(0xFF5C5C5C),
        secondaryContainer: dockIndicator,
      );
}
