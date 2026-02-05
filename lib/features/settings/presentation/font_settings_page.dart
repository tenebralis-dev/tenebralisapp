import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/font_controller.dart';
import '../../../app/strings.dart';
import '../../fonts/data/font_runtime_loader.dart';
import '../data/local_settings_font_config.dart';
import '../data/local_font_config_provider.dart';
import '../../fonts/presentation/controllers/active_font_controller.dart';
import 'remote_font_import_dialog.dart';
import 'local_font_import_dialog.dart';

/// Font Settings: preset list + single custom font (URL or local file).
/// Local-only font config (no cloud sync).
///
/// - URL font: settings.font_config.source = https://...
/// - Local font: settings.font_config.source = file://... (per-device)
class FontSettingsPage extends ConsumerStatefulWidget {
  const FontSettingsPage({super.key});

  @override
  ConsumerState<FontSettingsPage> createState() => _FontSettingsPageState();
}

class _FontSettingsPageState extends ConsumerState<FontSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final fontConfigAsync = ref.watch(localFontConfigProvider);
    final currentPreset = ref.watch(fontControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.fontTitle),
        actions: [
          IconButton(
            tooltip: s.isZh ? '字体直链' : 'Font URL',
            icon: const Icon(Icons.link),
            onPressed: () => _applyUrlFont(context),
          ),
          IconButton(
            tooltip: s.isZh ? '本地字体' : 'Local font',
            icon: const Icon(Icons.folder_open),
            onPressed: () => _applyLocalFont(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            s.fontSubtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Text(
            s.fontCurrent,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          fontConfigAsync.when(
            loading: () => const LinearProgressIndicator(minHeight: 2),
            error: (e, _) => Text(
              (s.isZh ? '加载失败：' : 'Load failed: ') + e.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            data: (config) {
              String title;
              if (config != null && config.isPreset) {
                title = fontDisplayName(config.preset!, isZh: s.isZh);
              } else if (config != null && config.isSource) {
                final source = config.source!;
                final uri = Uri.tryParse(source);
                final isLocal = uri != null && uri.scheme == 'file';
                title = isLocal
                    ? (s.isZh ? '自定义（本地）' : 'Custom (Local)')
                    : (s.isZh ? '自定义（链接）' : 'Custom (URL)');
              } else {
                title = currentPreset.isEmpty
                    ? (s.isZh ? '默认' : 'Default')
                    : fontDisplayName(currentPreset, isZh: s.isZh);
              }
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.font_download),
                title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            s.isZh ? '预设字体' : 'Preset fonts',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          ...AppFontFamily.all.map((family) {
            final config = fontConfigAsync.valueOrNull;
            final selectedPreset = config != null && config.isPreset
                ? config.preset
                : (config == null ? currentPreset : null);
            return RadioListTile<String>(
              value: family,
              groupValue: selectedPreset,
              onChanged: (v) async {
                if (v == null) return;
                await _applyPresetFont(v);
              },
              title: Text(
                fontDisplayName(family, isZh: s.isZh),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontFamily: family),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }),
          const SizedBox(height: 16),
          Text(
            s.fontHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.fontApply),
          ),
        ],
      ),
    );
  }

  Future<void> _applyPresetFont(String family) async {
    final config = LocalFontConfig.fromJson({'type': 'preset', 'preset': family})!;
    await _persistFontConfig(config);
    await ref.read(fontControllerProvider.notifier).setFont(family);
    ref.invalidate(localFontConfigProvider);
    ref.invalidate(activeFontProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(stringsProvider).isZh ? '已应用' : 'Applied')),
      );
    }
  }

  Future<void> _applyUrlFont(BuildContext context) async {
    final url = await showDialog<String>(
      context: context,
      builder: (_) => const RemoteFontImportDialog(),
    );
    if (url == null || url.isEmpty) return;
    final config = LocalFontConfig.fromJson({'type': 'url', 'source': url})!;
    await _persistFontConfig(config);
    try {
      await FontRuntimeLoader.loadFromUrl(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${ref.read(stringsProvider).isZh ? '加载失败' : 'Load failed'}: $e')),
        );
      }
      return;
    }
    await ref.read(fontControllerProvider.notifier).setFont(FontRuntimeLoader.familyForSource(url));
    ref.invalidate(localFontConfigProvider);
    ref.invalidate(activeFontProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(stringsProvider).isZh ? '已应用' : 'Applied')),
      );
    }
  }

  Future<void> _applyLocalFont(BuildContext context) async {
    final fileUrl = await showDialog<String>(
      context: context,
      builder: (_) => const LocalFontImportDialog(),
    );
    if (fileUrl == null || fileUrl.isEmpty) return;

    final config = LocalFontConfig.fromJson({'type': 'url', 'source': fileUrl})!;
    await _persistFontConfig(config);

    try {
      // For local file url, activeFontProvider will load it.
      await FontRuntimeLoader.loadFromUrl(fileUrl);
    } catch (_) {
      // ignore here; activeFontProvider will fallback.
    }

    await ref
        .read(fontControllerProvider.notifier)
        .setFont(FontRuntimeLoader.familyForSource(fileUrl));
    ref.invalidate(localFontConfigProvider);
    ref.invalidate(activeFontProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(stringsProvider).isZh ? '已应用本地字体' : 'Local font applied')),
      );
    }
  }

  Future<void> _persistFontConfig(LocalFontConfig config) async {
    await LocalFontConfigStore.save(config);
    ref.invalidate(localFontConfigProvider);
  }
}

