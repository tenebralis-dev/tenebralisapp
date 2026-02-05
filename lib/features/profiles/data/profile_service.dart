import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import '../domain/user_profile.dart';

/// ProfileService
///
/// - 只负责 public.users 表（档案）的读取/更新
/// - 头像存储在 Storage 私有桶 user-avatars
class ProfileService {
  ProfileService({SupabaseClient? client})
      : _client = client ?? SupabaseService.client;

  final SupabaseClient _client;

  static const String _usersTable = 'users';
  static const String _avatarBucket = 'user-avatars';

  String _requireUid() {
    final user = _client.auth.currentUser;
    if (user == null) throw const AuthException('Not authenticated');
    return user.id;
  }

  /// 读取当前登录用户的档案（public.users）。
  Future<UserProfile> getMyProfile() async {
    final uid = _requireUid();

    final row = await _client.from(_usersTable).select().eq('id', uid).single();
    return UserProfile.fromJson(Map<String, dynamic>.from(row));
  }

  /// 更新 display_name / bio / avatar_url（任意组合）。
  Future<UserProfile> updateMyProfile({
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) async {
    final uid = _requireUid();

    final patch = <String, dynamic>{};
    if (displayName != null) patch['display_name'] = displayName;
    if (bio != null) patch['bio'] = bio;
    if (avatarUrl != null) patch['avatar_url'] = avatarUrl;

    if (patch.isEmpty) {
      return getMyProfile();
    }

    final row = await _client
        .from(_usersTable)
        .update(patch)
        .eq('id', uid)
        .select()
        .single();

    return UserProfile.fromJson(Map<String, dynamic>.from(row));
  }

  /// 生成当前用户头像的 Storage 路径：
  /// user-avatars/{uid}/avatar.png
  String avatarObjectPathForUid(String uid) => '$uid/avatar.png';

  /// 对当前用户头像生成 signed url。
  ///
  /// 备注：bucket 是 private，禁止 getPublicUrl。
  Future<String> createMyAvatarSignedUrl({
    Duration expiresIn = const Duration(hours: 1),
  }) async {
    final uid = _requireUid();
    final path = avatarObjectPathForUid(uid);

    final url = await _client.storage
        .from(_avatarBucket)
        .createSignedUrl(path, expiresIn.inSeconds);

    return url;
  }

  /// 选择图片并上传到 Storage（upsert），并且只在“真正修改头像”时更新一次：
  ///
  /// - Storage 路径恒定：user-avatars/{uid}/avatar.png
  /// - public.users.avatar_url 存“稳定路径”（而不是 signed url）
  /// - signed url 由客户端按需临时生成并缓存（不写回数据库）
  Future<UserProfile> pickAndUploadAvatar({
    ImageSource source = ImageSource.gallery,
    int maxWidth = 1024,
    int imageQuality = 85,
  }) async {
    final uid = _requireUid();

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: maxWidth.toDouble(),
      imageQuality: imageQuality,
    );

    if (picked == null) {
      // 用户取消
      return getMyProfile();
    }

    final bytes = await picked.readAsBytes();
    await _uploadAvatarBytes(uid: uid, bytes: bytes);

    // 注意：这里只写“稳定路径”，不写 signed url。
    final stablePath = avatarObjectPathForUid(uid);
    return updateMyProfile(avatarUrl: stablePath);
  }

  Future<void> _uploadAvatarBytes({
    required String uid,
    required Uint8List bytes,
  }) async {
    final path = avatarObjectPathForUid(uid);

    await _client.storage.from(_avatarBucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/png',
          ),
        );
  }

}
