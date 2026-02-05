import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_font.freezed.dart';
part 'user_font.g.dart';

enum UserFontSourceType {
  builtIn,
  remoteUrl,
  localFile,
}

/// A user-manageable font definition.
///
/// Note: Only accept TTF/OTF.
@freezed
class UserFont with _$UserFont {
  const factory UserFont({
    required String id,
    required UserFontSourceType sourceType,

    /// Display base name (usually filename or user provided)
    required String originalName,

    /// Optional user tag, displayed as: tagName（originalName）
    String? tagName,

    /// Remote font direct URL (ttf/otf)
    String? remoteUrl,

    /// Imported local font file path (ttf/otf)
    String? localPath,

    /// Runtime registered family key, e.g. userfont_<id>
    String? family,

    /// File format: ttf | otf
    String? format,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserFont;

  factory UserFont.fromJson(Map<String, dynamic> json) => _$UserFontFromJson(json);
}

extension UserFontDisplayX on UserFont {
  String get displayTitle {
    final tag = tagName?.trim();
    if (tag != null && tag.isNotEmpty) {
      return '$tag（$originalName）';
    }
    return originalName;
  }
}
