import 'dart:convert';

/// 单个 appKey 的图标自定义配置。
///
/// 说明：仅本地存储，不做 Supabase 同步。
class IconCustomization {
  const IconCustomization({
    required this.appKey,
    required this.type,
    this.presetId,
    this.filePath,
    this.url,
  });

  final String appKey;
  final IconCustomizationType type;

  /// 预设图标 id（来自预设表/图标包映射）
  final String? presetId;

  /// 本地图片路径
  final String? filePath;

  /// 直链 URL
  final String? url;

  Map<String, Object?> toJson() => {
        'appKey': appKey,
        'type': type.name,
        'presetId': presetId,
        'filePath': filePath,
        'url': url,
      };

  factory IconCustomization.fromJson(Map<String, Object?> json) {
    final typeRaw = (json['type'] as String?) ?? IconCustomizationType.preset.name;
    final type = IconCustomizationType.values.firstWhere(
      (e) => e.name == typeRaw,
      orElse: () => IconCustomizationType.preset,
    );

    return IconCustomization(
      appKey: (json['appKey'] as String?) ?? '',
      type: type,
      presetId: json['presetId'] as String?,
      filePath: json['filePath'] as String?,
      url: json['url'] as String?,
    );
  }

  static Map<String, IconCustomization> decodeMap(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return {};

    final result = <String, IconCustomization>{};
    for (final entry in decoded.entries) {
      final key = entry.key.toString();
      final value = entry.value;
      if (value is Map) {
        result[key] = IconCustomization.fromJson(
          value.map((k, v) => MapEntry(k.toString(), v)),
        );
      }
    }
    return result;
  }

  static String encodeMap(Map<String, IconCustomization> map) {
    final jsonMap = map.map((k, v) => MapEntry(k, v.toJson()));
    return jsonEncode(jsonMap);
  }
}

enum IconCustomizationType {
  preset,
  file,
  url,
}
