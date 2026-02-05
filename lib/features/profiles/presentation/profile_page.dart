import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

import '../../../core/services/supabase_service.dart';
import '../data/profile_service.dart';
import '../domain/user_profile.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService();
});

final myProfileProvider = FutureProvider<UserProfile>((ref) async {
  final service = ref.watch(profileServiceProvider);
  return service.getMyProfile();
});

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();

  bool _editing = false;
  bool _saving = false;

  // signed url 仅客户端临时缓存（不写库）
  String? _avatarSignedUrl;
  bool _avatarSignedUrlLoading = false;

  // “上一次成功加载过的头像”缓存键（与 signed url 无关）。
  // 用于：页面打开时优先展示缓存头像（即使当前 signed url 还没签发）。
  late final String _avatarCacheKey;

  // 自定义 cache manager：可控 key，避免 signed url 每次变化导致 cache miss。
  late final CacheManager _avatarCacheManager;

  @override
  void initState() {
    super.initState();

    final uid = SupabaseService.currentUser?.id ?? 'anonymous';
    _avatarCacheKey = 'user-avatar:$uid';

    // 头像缓存策略：
    // - key 固定（与 signed url 无关）
    // - signed url 变化时仍命中同一缓存条目
    // - stalePeriod 可自行调整（这里给 30 天）
    _avatarCacheManager = CacheManager(
      Config(
        'profileAvatarCache',
        stalePeriod: const Duration(days: 30),
        maxNrOfCacheObjects: 50,
      ),
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncProfile = ref.watch(myProfileProvider);

    return asyncProfile.when(
      data: (profile) {
        // 首次进入时把值写入控制器（不覆盖用户正在编辑的内容）
        if (!_editing) {
          _displayNameController.text = profile.displayName ?? '';
          _bioController.text = profile.bio ?? '';
        }

        // profile.avatarUrl 现在是“稳定路径”（例如：{uid}/avatar.png）。
        // 页面加载后按需生成 signed url 并缓存在 state（不写库）。
        // 页面打开：优先显示本地缓存的头像（如果之前成功加载过）。
        // 同时异步签发 signed url，用于后续刷新/重新拉取（不写库）。
        if (_avatarSignedUrl == null && !_avatarSignedUrlLoading) {
          _refreshAvatarSignedUrl(profile.avatarUrl);
        }

        final scheme = Theme.of(context).colorScheme;
        final createdAt = profile.createdAt;
        final createdAtText = createdAt == null
            ? '—'
            : DateFormat('yyyy-MM-dd HH:mm').format(createdAt.toLocal());

        return Scaffold(
          appBar: AppBar(
            title: const Text('档案'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                tooltip: _editing ? '取消' : '编辑',
                icon: Icon(_editing ? Icons.close : Icons.edit_outlined),
                onPressed: _saving
                    ? null
                    : () {
                        setState(() => _editing = !_editing);
                      },
              ),
              if (_editing)
                TextButton(
                  onPressed: _saving ? null : () => _save(profile),
                  child: _saving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('保存'),
                ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // 1) 刷新档案数据
              ref.invalidate(myProfileProvider);
              final refreshed = await ref.read(myProfileProvider.future);
              // 2) 重新签发头像 signed url（仅客户端缓存）
              await _refreshAvatarSignedUrl(refreshed.avatarUrl, force: true);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                _HeaderCard(
                  profile: profile,
                  avatarSignedUrl: _avatarSignedUrl,
                  cacheManager: _avatarCacheManager,
                  cacheKey: _avatarCacheKey,
                  editing: _editing,
                  onChangeAvatar: _saving
                      ? null
                      : () async {
                          await _changeAvatar();
                        },
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  title: '基础信息',
                  child: Column(
                    children: [
                      _InfoRow(label: '系统等级', value: '${profile.systemLevel ?? 0}'),
                      const SizedBox(height: 8),
                      _InfoRow(label: '经验值', value: '${profile.expPoints ?? 0}'),
                      const SizedBox(height: 8),
                      _InfoRow(label: '创建时间', value: createdAtText),
                      const SizedBox(height: 8),
                      _InfoRow(
                        label: 'UID',
                        value: SupabaseService.currentUser?.id ?? '—',
                        monospace: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  title: '展示名',
                  child: TextField(
                    controller: _displayNameController,
                    enabled: _editing && !_saving,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: '输入展示名',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  title: '简介',
                  child: TextField(
                    controller: _bioController,
                    enabled: _editing && !_saving,
                    minLines: 3,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: '写点什么...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (!_editing)
                  Text(
                    '下拉可刷新。编辑模式下可修改展示名、简介与头像。',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(
          title: const Text('档案'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '加载失败：$e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save(UserProfile current) async {
    setState(() => _saving = true);
    try {
      final service = ref.read(profileServiceProvider);
      await service.updateMyProfile(
        displayName: _displayNameController.text.trim(),
        bio: _bioController.text.trim(),
      );

      setState(() => _editing = false);
      ref.invalidate(myProfileProvider);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _changeAvatar() async {
    setState(() => _saving = true);
    try {
      final service = ref.read(profileServiceProvider);

      // 上传并仅在“修改头像”时更新一次 stable path 到 users.avatar_url
      final updatedProfile = await service.pickAndUploadAvatar();

      // 重新生成 signed url（仅客户端缓存）
      await _refreshAvatarSignedUrl(updatedProfile.avatarUrl, force: true);

      ref.invalidate(myProfileProvider);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _refreshAvatarSignedUrl(
    String? stableAvatarPath, {
    bool force = false,
  }) async {
    if (!force && _avatarSignedUrlLoading) return;

    // 没有稳定路径：清空 signed url，并同时清掉缓存（避免显示旧头像）
    if (stableAvatarPath == null || stableAvatarPath.isEmpty) {
      if (mounted) {
        setState(() {
          _avatarSignedUrl = null;
          _avatarSignedUrlLoading = false;
        });
      }
      await _avatarCacheManager.removeFile(_avatarCacheKey);
      return;
    }

    setState(() => _avatarSignedUrlLoading = true);
    try {
      final service = ref.read(profileServiceProvider);
      final url = await service.createMyAvatarSignedUrl();
      if (!mounted) return;

      // 关键：signed url 变化会导致 URL 不同。
      // 我们用固定 cacheKey，把同一头像内容写进同一个缓存条目，
      // 下次打开页面可直接命中缓存（不需要等待网络）。
      setState(() => _avatarSignedUrl = url);
    } catch (_) {
      // 签发失败时不阻断页面：
      // - 保留已缓存的头像（如果有）
      // - signed url 置空会导致 UI 回退为默认头像，因此这里不强制置空。
      //   （避免离线时头像闪回默认）
    } finally {
      if (mounted) setState(() => _avatarSignedUrlLoading = false);
    }
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.profile,
    required this.avatarSignedUrl,
    required this.cacheManager,
    required this.cacheKey,
    required this.editing,
    required this.onChangeAvatar,
  });

  final UserProfile profile;
  final String? avatarSignedUrl;
  final CacheManager cacheManager;
  final String cacheKey;
  final bool editing;
  final VoidCallback? onChangeAvatar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          _Avatar(
            avatarUrl: avatarSignedUrl,
            cacheManager: cacheManager,
            cacheKey: cacheKey,
            onTap: editing ? onChangeAvatar : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName?.trim().isNotEmpty == true
                      ? profile.displayName!.trim()
                      : (profile.username ?? '未命名用户'),
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  (profile.bio?.trim().isNotEmpty == true)
                      ? profile.bio!.trim()
                      : '暂无简介',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (editing) ...[
                  const SizedBox(height: 10),
                  FilledButton.tonalIcon(
                    onPressed: onChangeAvatar,
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text('更换头像'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.avatarUrl,
    required this.cacheManager,
    required this.cacheKey,
    this.onTap,
  });

  final String? avatarUrl; // signed url（可能为空）
  final CacheManager cacheManager;
  final String cacheKey;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final placeholder = Icon(Icons.person, size: 40, color: scheme.onSurfaceVariant);

    final image = (avatarUrl == null || avatarUrl!.isEmpty)
        ? placeholder
        : CachedNetworkImage(
            imageUrl: avatarUrl!,
            cacheManager: cacheManager,
            cacheKey: cacheKey,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 150),
            placeholder: (_, __) => const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (_, __, ___) => placeholder,
          );

    final child = ClipOval(
      child: Container(
        width: 72,
        height: 72,
        color: scheme.surfaceContainerHighest,
        child: image,
      ),
    );

    if (onTap == null) return child;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: child,
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.monospace = false,
  });

  final String label;
  final String value;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SelectableText(
            value,
            style: monospace
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
