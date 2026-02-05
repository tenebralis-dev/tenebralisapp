import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/strings.dart';
import 'controllers/icon_customization_controller.dart';
import 'controllers/icon_shape_controller.dart';
import '../domain/icon_shape.dart';
import '../../presentation/widgets/app_icon.dart';
import '../domain/icon_customization.dart';
import '../../../../app/router.dart';

/// Icon 自定义入口页面。
///
/// 目标：管理 Dock + 主界面三屏所有 appKey 的 icon 覆盖。
class IconCustomizePage extends ConsumerWidget {
  const IconCustomizePage({super.key});

  static const allGridKeys = <String>[
    // Page 1
    'affection',
    'identity',
    'worlds',
    'forum',
    'shop',
    'achievement',
    // Page 2
    'memo',
    'ledger',
    'gallery',
    'calendar',
    'pomodoro',
    'music',
    // Page 3
    'connection',
    'settings',
    'customize',
  ];

  static const dockKeys = <String>['dream', 'chat', 'quest', 'profile'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);

    final state = ref.watch(iconCustomizationControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${s.appCustomize} · 图标与布局'),
      ),
      body: state.when(
        data: (map) {
          final keys = [...dockKeys, ...allGridKeys];

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _GlobalShapeSelector(current: ref.watch(iconShapeControllerProvider).valueOrNull),
              const SizedBox(height: 12),
              for (int i = 0; i < keys.length; i++) ...[
                _AppRow(appKey: keys[i]),
                const SizedBox(height: 12),
              ],
            ],
          );
        },
        error: (e, _) => Center(child: Text('加载失败：$e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _AppRow extends ConsumerWidget {
  const _AppRow({required this.appKey});

  final String appKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final map = ref.watch(iconCustomizationControllerProvider).valueOrNull ?? {};

    final app = AppItem.fromId(appKey);
    final hasCustom = map.containsKey(appKey);

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: AppIcon(
          id: app.id,
          label: app.label,
          icon: app.icon,
          color: app.color,
          showLabel: false,
          size: 46,
          onTap: null,
        ),
        title: Text(resolveAppLabel(s, app.label)),
        subtitle: Text(
          hasCustom ? '已自定义' : '默认',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => IconCustomizeDetailPage(appKey: appKey),
            ),
          );
        },
      ),
    );
  }
}

class _GlobalShapeSelector extends ConsumerWidget {
  const _GlobalShapeSelector({required this.current});

  final IconShape? current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = current ?? IconShape.roundedRect;

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('图标形状', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ShapeChip(
                  label: '方形',
                  selected: c == IconShape.square,
                  onTap: () => ref
                      .read(iconShapeControllerProvider.notifier)
                      .setShape(IconShape.square),
                ),
                _ShapeChip(
                  label: '圆角矩形',
                  selected: c == IconShape.roundedRect,
                  onTap: () => ref
                      .read(iconShapeControllerProvider.notifier)
                      .setShape(IconShape.roundedRect),
                ),
                _ShapeChip(
                  label: '更圆',
                  selected: c == IconShape.superRoundedRect,
                  onTap: () => ref
                      .read(iconShapeControllerProvider.notifier)
                      .setShape(IconShape.superRoundedRect),
                ),
                _ShapeChip(
                  label: '圆形',
                  selected: c == IconShape.circle,
                  onTap: () => ref
                      .read(iconShapeControllerProvider.notifier)
                      .setShape(IconShape.circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShapeChip extends StatelessWidget {
  const _ShapeChip({required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: selected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}


/// 单个 appKey 的自定义详情页。
///
/// 注意：这里先做最小可用版本（预设/URL/清除），
/// 以及 Android 相册选择（image_picker）会在下一步补齐。
class IconCustomizeDetailPage extends ConsumerStatefulWidget {
  const IconCustomizeDetailPage({super.key, required this.appKey});

  final String appKey;

  @override
  ConsumerState<IconCustomizeDetailPage> createState() =>
      _IconCustomizeDetailPageState();
}

class _IconCustomizeDetailPageState
    extends ConsumerState<IconCustomizeDetailPage> {
  final _urlCtrl = TextEditingController();

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final current = ref
        .watch(iconCustomizationControllerProvider)
        .valueOrNull?[widget.appKey];

    return Scaffold(
      appBar: AppBar(
        title: Text('${s.appCustomize} · ${widget.appKey}'),
        actions: [
          if (current != null)
            TextButton(
              onPressed: () async {
                await ref
                    .read(iconCustomizationControllerProvider.notifier)
                    .removeCustomization(widget.appKey);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: Text(
                '清除',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '当前：${current?.type.name ?? 'default'}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text('预设图标（占位）', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                _PresetButton(
                  label: 'tune',
                  icon: Icons.tune,
                  onTap: () => _setPreset('tune'),
                ),
                _PresetButton(
                  label: 'star',
                  icon: Icons.star_outline,
                  onTap: () => _setPreset('star'),
                ),
                _PresetButton(
                  label: 'heart',
                  icon: Icons.favorite_outline,
                  onTap: () => _setPreset('heart'),
                ),
                _PresetButton(
                  label: 'spark',
                  icon: Icons.auto_awesome,
                  onTap: () => _setPreset('spark'),
                ),
                ],
              ),
              const SizedBox(height: 24),
              Text('本地图片（相册）', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _pickLocalImage,
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('从相册选择'),
            ),
            const SizedBox(height: 24),
            Text('URL 图标', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _urlCtrl,
              decoration: const InputDecoration(
                hintText: 'https://.../icon.png',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _applyUrl,
              icon: const Icon(Icons.link),
              label: const Text('应用 URL'),
            ),
            const SizedBox(height: 20),
            Text(
              '提示：本地图片仅保存在手机本地路径，不会上传/同步。',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65),
                  ),
            ),
          ],
          ),
        ),
      ),
    );
  }

  Future<void> _setPreset(String presetId) async {
    await ref.read(iconCustomizationControllerProvider.notifier).setCustomization(
          IconCustomization(
            appKey: widget.appKey,
            type: IconCustomizationType.preset,
            presetId: presetId,
          ),
        );
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已应用预设图标')));
    }
  }

  Future<void> _pickLocalImage() async {
    final picker = ImagePicker();

    try {
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 92,
      );
      if (picked == null) return;

      await ref
          .read(iconCustomizationControllerProvider.notifier)
          .setCustomization(
            IconCustomization(
              appKey: widget.appKey,
              type: IconCustomizationType.file,
              filePath: picked.path,
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('已应用本地图片图标')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('选择失败：$e')));
      }
    }
  }

  Future<void> _applyUrl() async {
    final raw = _urlCtrl.text.trim();
    if (raw.isEmpty) return;

    final uri = Uri.tryParse(raw);
    if (uri == null || !(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('URL 不合法')));
      }
      return;
    }

    await ref.read(iconCustomizationControllerProvider.notifier).setCustomization(
          IconCustomization(
            appKey: widget.appKey,
            type: IconCustomizationType.url,
            url: raw,
          ),
        );

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已应用 URL 图标')));
    }
  }
}

class _PresetButton extends StatelessWidget {
  const _PresetButton({required this.label, required this.icon, this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 88,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 6),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
