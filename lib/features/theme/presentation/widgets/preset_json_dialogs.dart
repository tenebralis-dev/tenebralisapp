import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/theme_preset.dart';
import '../controllers/theme_presets_controller.dart';
import '../preset_json_io.dart';

class PresetJsonDialog extends StatelessWidget {
  const PresetJsonDialog({super.key, required this.preset});
  final ThemePreset preset;

  @override
  Widget build(BuildContext context) {
    final json = exportPresetToJson(preset);
    return AlertDialog(
      title: const Text('导出 JSON'),
      content: SizedBox(
        width: double.maxFinite,
        child: SelectableText(json),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('关闭'),
        ),
      ],
    );
  }
}

class PresetJsonImportDialog extends ConsumerStatefulWidget {
  const PresetJsonImportDialog({super.key});

  @override
  ConsumerState<PresetJsonImportDialog> createState() =>
      _PresetJsonImportDialogState();
}

class _PresetJsonImportDialogState extends ConsumerState<PresetJsonImportDialog> {
  final _ctrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('从 JSON 导入'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _ctrl,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: '粘贴单个 preset 的 JSON...',
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _import,
          child: const Text('导入'),
        ),
      ],
    );
  }

  Future<void> _import() async {
    setState(() => _error = null);
    final raw = _ctrl.text.trim();
    if (raw.isEmpty) return;

    try {
      final id = const Uuid().v4();
      final preset = importPresetFromJson(jsonString: raw, newId: id);
      await ref.read(themePresetsControllerProvider.notifier).createOrUpdatePreset(
            id: preset.id,
            name: preset.name,
            lightTokens: preset.lightTokens,
            darkTokens: preset.darkTokens,
            syncEnabled: false,
          );

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      setState(() => _error = '导入失败：$e');
    }
  }
}
