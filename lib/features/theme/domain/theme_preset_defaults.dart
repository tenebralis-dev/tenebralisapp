import 'theme_tokens.dart';

/// 内置默认主题 tokens（全局唯一默认主题入口）。
///
/// 设计目标：
/// - App 在“没有任何用户 preset”时也能稳定渲染。
/// - 以后要改默认色板，只改这里，不要在 UI 或 main.dart 写死颜色。
class ThemePresetDefaults {
  ThemePresetDefaults._();

  // 目前沿用你项目里最常见的紫/青默认（原 0xFF6C63FF / 0xFF00D9FF）。
  // 注意：tokens 存储的是 hex string（支持 #RRGGBB 或 #AARRGGBB）。
  static const ThemeTokens lightTokens = ThemeTokens(
    primary: '#FF6C63FF',
    secondary: '#FF00D9FF',
    background: '#FFECE2E1',
    surface: '#FFD3E0DC',
    text: '#FF1A1A1A',
    // 可选
    error: '#FFB00020',
  );

  static const ThemeTokens darkTokens = ThemeTokens(
    primary: '#FF6C63FF',
    secondary: '#FF00D9FF',
    background: '#FF0A0E21',
    surface: '#FF1D1E33',
    text: '#FFFFFFFF',
    // 可选
    error: '#FFFF5252',
  );

  /// Slate（石板）浅色方案：来自用户提供的四色色板。
  ///
  /// 映射：background / surface / primary / secondary
  /// text 将在创建 preset 时自动计算（此处先留占位）。
  static const ThemeTokens slateLightTokens = ThemeTokens(
    primary: '#FF52616B',
    secondary: '#FF52616B',
    background: '#FFF0F5F9',
    surface: '#FFC9D6DF',
    // 占位：真实值在构建 preset 时会被 auto-text 覆盖。
    text: '#FF1E2022',
  );

  /// 深海（Deep Sea）深色方案：
  /// background：#1B262C
  /// surface：#0F4C75
  /// primary：#BBE1FA
  /// secondary：#3282B8
  ///
  /// 其他颜色会在构建 ColorScheme 时由这四个基色衍生。
  /// text 同样会在创建 preset 时自动计算（此处先留占位）。
  static const ThemeTokens deepSeaDarkTokens = ThemeTokens(
    primary: '#BBE1FA',
    secondary: '#3282B8',
    background: '#1B262C',
    surface: '#0F4C75',
    // 占位：真实值在构建 preset 时会被 auto-text 覆盖。
    text: '#FFFFFF',
  );
}

