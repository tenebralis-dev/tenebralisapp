import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/debug/runtime_log.dart';
import '../domain/theme_preset.dart';
import '../domain/theme_tokens.dart';
import 'widgets/preset_json_dialogs.dart';
import 'preset_json_io.dart';
import '../presentation/theme_scheme_builder.dart';
import 'controllers/theme_presets_controller.dart';
import 'preset_catalog.dart';

class ThemeCustomizationPage extends ConsumerWidget {
  const ThemeCustomizationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(themePresetsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('自定义配色')),
      body: stateAsync.when(
        data: (state) {
          final active = state.activePresetId;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _SectionCard(
                title: '当前方案',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(active == null ? '未启用自定义方案（使用内置主题）' : '已启用自定义方案'),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () => _openPresetsSheet(context),
                      icon: const Icon(Icons.palette_outlined),
                      label: const Text('方案库'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: '快速新建',
                child: FilledButton.icon(
                  onPressed: () async {
    final colors = ThemeTokens(
      primary: '#6C63FF',
      secondary: '#00D9FF',
      background: '#0A0E21',
      surface: '#1D1E33',
      text: '#FFFFFF',
      error: '#FF5252',
    );

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ThemePresetEditorPage(
                          initialName: '新方案',
                          initialLightTokens: colors,
                          initialDarkTokens: deriveDarkTokens(colors),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('从默认模板创建'),
                ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: '所有方案',
                child: Column(
                  children: [
                    for (final p in state.presets) ...[
                      _PresetTile(preset: p),
                      const SizedBox(height: 8),
                    ],
                    if (state.presets.isEmpty)
                      Text(
                        '还没有方案，点击“从默认模板创建”开始。',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (e, _) => Center(child: Text('加载失败：$e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _openPresetsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => const _PresetLibrarySheet(),
    );
  }
}

class _PresetLibrarySheet extends ConsumerWidget {
  const _PresetLibrarySheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themePresetsControllerProvider).valueOrNull;
    if (state == null) {
      return const SafeArea(child: Padding(padding: EdgeInsets.all(16), child: Text('加载中...')));
    }

    final builtins = builtinThemePresets();

    // #region agent log
    RuntimeLog.log(
      hypothesisId: 'A',
      location: 'theme_customization_page.dart:_PresetLibrarySheet',
      message: 'build',
      data: {
        'userPresets': state.presets.length,
        'builtinPresets': builtins.length,
        'viewInsetsBottom': MediaQuery.of(context).viewInsets.bottom,
        'sizeH': MediaQuery.of(context).size.height,
      },
    );
    // #endregion

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // #region agent log
              Builder(
                builder: (context) {
                  RuntimeLog.log(
                    hypothesisId: 'B',
                    location: 'theme_customization_page.dart:_PresetLibrarySheet',
                    message: 'renderingColumn',
                    data: {
                      'childrenApprox': state.presets.length + builtins.length,
                    },
                  );
                  return const SizedBox.shrink();
                },
              ),
              // #endregion
              Text('方案库', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Text('我的方案', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    for (final p in state.presets) ...[
                      _PresetTile(preset: p, dense: true),
                      const SizedBox(height: 8),
                    ],
                    if (state.presets.isEmpty)
                      Text(
                        '暂无方案',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),

                    const SizedBox(height: 16),
                    Text('预置方案', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    for (final p in builtins) ...[
                      _BuiltinPresetTile(preset: p, dense: true),
                      const SizedBox(height: 8),
                    ],
                    if (builtins.isEmpty)
                      Text(
                        '暂无预置方案',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('关闭'),
              ),
              // #region agent log
              Builder(
                builder: (context) {
                  RuntimeLog.log(
                    hypothesisId: 'C',
                    location: 'theme_customization_page.dart:_PresetLibrarySheet',
                    message: 'afterCloseButton',
                    data: const {},
                  );
                  return const SizedBox.shrink();
                },
              ),
              // #endregion
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetTile extends ConsumerWidget {
  const _PresetTile({required this.preset, this.dense = false});

  final ThemePreset preset;
  final bool dense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId =
        ref.watch(themePresetsControllerProvider).valueOrNull?.activePresetId;
    final isActive = activeId == preset.id;

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        dense: dense,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: _ColorPreview(colors: preset.lightTokens),
        title: Text(preset.name),
        subtitle: Text(
          isActive ? '当前启用' : (preset.syncEnabled ? '将同步到云端' : '仅本地'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (v) async {
            final ctrl = ref.read(themePresetsControllerProvider.notifier);
            switch (v) {
              case 'apply':
                await ctrl.setActivePreset(preset.id);
                break;
              case 'edit':
                if (!context.mounted) return;
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ThemePresetEditorPage(
                      presetId: preset.id,
                      initialName: preset.name,
                      initialLightTokens: preset.lightTokens,
                      initialDarkTokens: preset.darkTokens,
                      initialSyncEnabled: preset.syncEnabled,
                    ),
                  ),
                );
                break;
              case 'export_json':
                if (!context.mounted) return;
                await showDialog(
                  context: context,
                  builder: (_) => PresetJsonDialog(preset: preset),
                );
                break;
              case 'import_json':
                if (!context.mounted) return;
                await showDialog(
                  context: context,
                  builder: (_) => const PresetJsonImportDialog(),
                );
                break;
              case 'delete':
                await ctrl.deletePreset(preset.id);
                break;
              case 'disable':
                await ctrl.setActivePreset(null);
                break;
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'apply', child: Text('应用')),
            const PopupMenuItem(value: 'edit', child: Text('编辑')),
            const PopupMenuItem(value: 'export_json', child: Text('导出 JSON')),
            const PopupMenuItem(value: 'import_json', child: Text('从 JSON 导入')),
            const PopupMenuItem(value: 'delete', child: Text('删除')),
            if (isActive)
              const PopupMenuItem(value: 'disable', child: Text('停止使用自定义方案')),
          ],
        ),
      ),
    );
  }
}

class _BuiltinPresetTile extends ConsumerWidget {
  const _BuiltinPresetTile({required this.preset, this.dense = false});

  final ThemePreset preset;
  final bool dense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId =
        ref.watch(themePresetsControllerProvider).valueOrNull?.activePresetId;

    // Built-in is never "active" directly (active always points to user preset).
    // We still show active state if user currently uses a copied "（预置）xxx".
    final isPseudoActive = activeId != null &&
        (ref.watch(themePresetsControllerProvider).valueOrNull?.presets.any(
                  (p) =>
                      p.id == activeId && p.lightTokens == preset.lightTokens && p.darkTokens == preset.darkTokens,
                ) ??
            false);

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        dense: dense,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: _ColorPreview(colors: preset.lightTokens),
        title: Text(preset.name),
        subtitle: Text(
          isPseudoActive ? '当前启用（来自预置）' : '预置',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (v) async {
            final ctrl = ref.read(themePresetsControllerProvider.notifier);
            switch (v) {
              case 'apply':
                await ctrl.applyBuiltinAsUserPreset(preset);
                break;
              case 'copy':
                if (!context.mounted) return;
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ThemePresetEditorPage(
                      initialName: preset.name,
                      initialLightTokens: preset.lightTokens,
                      initialDarkTokens: preset.darkTokens,
                      initialSyncEnabled: false,
                    ),
                  ),
                );
                break;
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'apply', child: Text('应用')),
            PopupMenuItem(value: 'copy', child: Text('复制为我的方案')),
          ],
        ),
      ),
    );
  }
}

class _ColorPreview extends StatelessWidget {
  const _ColorPreview({required this.colors});

  final ThemeTokens colors;

  Color _hex(String s) {
    var raw = s.trim();
    if (raw.startsWith('#')) raw = raw.substring(1);
    if (raw.length == 6) raw = 'FF$raw';
    return Color(int.parse(raw, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final c1 = _hex(colors.primary);
    final c2 = _hex(colors.secondary);
    final c3 = _hex(colors.background);

    return SizedBox(
      width: 44,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
          gradient: LinearGradient(colors: [c1, c2]),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: c3,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
          ),
        ),
      ),
    );
  }
}

class ThemePresetEditorPage extends ConsumerStatefulWidget {
  const ThemePresetEditorPage({
    super.key,
    this.presetId,
    required this.initialName,
    required this.initialLightTokens,
    required this.initialDarkTokens,
    this.initialSyncEnabled = false,
  });

  final String? presetId;
  final String initialName;
  final ThemeTokens initialLightTokens;
  final ThemeTokens initialDarkTokens;
  final bool initialSyncEnabled;

  @override
  ConsumerState<ThemePresetEditorPage> createState() =>
      _ThemePresetEditorPageState();
}

class _ThemePresetEditorPageState extends ConsumerState<ThemePresetEditorPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _nameCtrl;
  late bool _syncEnabled;

  late final TabController _tabCtrl;

  // Light
  late final TextEditingController _lPrimaryCtrl;
  late final TextEditingController _lSecondaryCtrl;
  late final TextEditingController _lBackgroundCtrl;
  late final TextEditingController _lSurfaceCtrl;
  late final TextEditingController _lTextCtrl;
  late final TextEditingController _lErrorCtrl;

  // Dark
  late final TextEditingController _dPrimaryCtrl;
  late final TextEditingController _dSecondaryCtrl;
  late final TextEditingController _dBackgroundCtrl;
  late final TextEditingController _dSurfaceCtrl;
  late final TextEditingController _dTextCtrl;
  late final TextEditingController _dErrorCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);

    _nameCtrl = TextEditingController(text: widget.initialName);
    _syncEnabled = widget.initialSyncEnabled;

    // Light tokens.
    _lPrimaryCtrl = TextEditingController(text: widget.initialLightTokens.primary);
    _lSecondaryCtrl = TextEditingController(text: widget.initialLightTokens.secondary);
    _lBackgroundCtrl = TextEditingController(text: widget.initialLightTokens.background);
    _lSurfaceCtrl = TextEditingController(text: widget.initialLightTokens.surface);
    _lTextCtrl = TextEditingController(text: widget.initialLightTokens.text);
    _lErrorCtrl = TextEditingController(text: widget.initialLightTokens.error ?? '');

    // Dark tokens.
    _dPrimaryCtrl = TextEditingController(text: widget.initialDarkTokens.primary);
    _dSecondaryCtrl = TextEditingController(text: widget.initialDarkTokens.secondary);
    _dBackgroundCtrl = TextEditingController(text: widget.initialDarkTokens.background);
    _dSurfaceCtrl = TextEditingController(text: widget.initialDarkTokens.surface);
    _dTextCtrl = TextEditingController(text: widget.initialDarkTokens.text);
    _dErrorCtrl = TextEditingController(text: widget.initialDarkTokens.error ?? '');
  }

  @override
  void dispose() {
    _tabCtrl.dispose();

    _nameCtrl.dispose();

    _lPrimaryCtrl.dispose();
    _lSecondaryCtrl.dispose();
    _lBackgroundCtrl.dispose();
    _lSurfaceCtrl.dispose();
    _lTextCtrl.dispose();
    _lErrorCtrl.dispose();

    _dPrimaryCtrl.dispose();
    _dSecondaryCtrl.dispose();
    _dBackgroundCtrl.dispose();
    _dSurfaceCtrl.dispose();
    _dTextCtrl.dispose();
    _dErrorCtrl.dispose();

    super.dispose();
  }

  ThemeTokens _lightTokens() {
    return ThemeTokens(
      primary: _lPrimaryCtrl.text.trim(),
      secondary: _lSecondaryCtrl.text.trim(),
      background: _lBackgroundCtrl.text.trim(),
      surface: _lSurfaceCtrl.text.trim(),
      text: _lTextCtrl.text.trim(),
      error: _lErrorCtrl.text.trim().isEmpty ? null : _lErrorCtrl.text.trim(),
    );
  }

  ThemeTokens _darkTokens() {
    return ThemeTokens(
      primary: _dPrimaryCtrl.text.trim(),
      secondary: _dSecondaryCtrl.text.trim(),
      background: _dBackgroundCtrl.text.trim(),
      surface: _dSurfaceCtrl.text.trim(),
      text: _dTextCtrl.text.trim(),
      error: _dErrorCtrl.text.trim().isEmpty ? null : _dErrorCtrl.text.trim(),
    );
  }

  void _deriveDarkFromLight() {
    final derived = deriveDarkTokens(_lightTokens());
    _dPrimaryCtrl.text = derived.primary;
    _dSecondaryCtrl.text = derived.secondary;
    _dBackgroundCtrl.text = derived.background;
    _dSurfaceCtrl.text = derived.surface;
    _dTextCtrl.text = derived.text;
    _dErrorCtrl.text = derived.error ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.presetId == null ? '新建方案' : '编辑方案'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('保存'),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          24 + MediaQuery.of(context).viewInsets.bottom,
        ),
        children: [
          _SectionCard(
            title: '基础',
            child: Column(
              children: [
                TextField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: '方案名称'),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('同步到 Supabase'),
                  subtitle: const Text('开启后，该方案会写入云端表（RLS 私有）'),
                  value: _syncEnabled,
                  onChanged: (v) => setState(() => _syncEnabled = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TabBar(
            controller: _tabCtrl,
            tabs: const [
              Tab(text: '浅色'),
              Tab(text: '深色'),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _tabCtrl,
            builder: (context, _) {
              final isDarkTab = _tabCtrl.index == 1;
              return _SectionCard(
                title: isDarkTab ? '深色（HEX）' : '浅色（HEX）',
                child: Column(
                  children: [
                    if (isDarkTab)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: _deriveDarkFromLight,
                          icon: const Icon(Icons.auto_fix_high_outlined),
                          label: const Text('从浅色派生深色'),
                        ),
                      ),
                    _HexField(
                      label: 'Primary',
                      controller: isDarkTab ? _dPrimaryCtrl : _lPrimaryCtrl,
                    ),
                    _HexField(
                      label: 'Secondary',
                      controller: isDarkTab ? _dSecondaryCtrl : _lSecondaryCtrl,
                    ),
                    _HexField(
                      label: 'Background',
                      controller: isDarkTab ? _dBackgroundCtrl : _lBackgroundCtrl,
                    ),
                    _HexField(
                      label: 'Surface',
                      controller: isDarkTab ? _dSurfaceCtrl : _lSurfaceCtrl,
                    ),
                    _HexField(
                      label: 'Text',
                      controller: isDarkTab ? _dTextCtrl : _lTextCtrl,
                    ),
                    _HexField(
                      label: 'Error（可选）',
                      controller: isDarkTab ? _dErrorCtrl : _lErrorCtrl,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: '预览',
            child: _PreviewCard(
              lightTokens: _lightTokens(),
              darkTokens: _darkTokens(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '提示：HEX 支持 #RRGGBB 或 #AARRGGBB。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    await ref.read(themePresetsControllerProvider.notifier).createOrUpdatePreset(
          id: widget.presetId,
          name: name,
          lightTokens: _lightTokens(),
          darkTokens: _darkTokens(),
          syncEnabled: _syncEnabled,
        );

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class _HexField extends StatelessWidget {
  const _HexField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: '#RRGGBB',
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.lightTokens,
    required this.darkTokens,
  });

  final ThemeTokens lightTokens;
  final ThemeTokens darkTokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ThemePreviewMini(
          title: '浅色预览',
          tokens: lightTokens,
          brightness: Brightness.light,
        ),
        const SizedBox(height: 12),
        _ThemePreviewMini(
          title: '深色预览',
          tokens: darkTokens,
          brightness: Brightness.dark,
        ),
      ],
    );
  }
}

class _ThemePreviewMini extends StatelessWidget {
  const _ThemePreviewMini({
    required this.title,
    required this.tokens,
    required this.brightness,
  });

  final String title;
  final ThemeTokens tokens;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final scheme = buildColorSchemeFromTokens(tokens, brightness);

    final previewTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );

    return Theme(
      data: previewTheme,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.onBackground)),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'TextField',
                hintText: 'Preview',
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.palette_outlined),
              title: const Text('ListTile'),
              subtitle: const Text('Subtitle'),
              trailing: const Icon(Icons.chevron_right),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Primary'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outline'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
