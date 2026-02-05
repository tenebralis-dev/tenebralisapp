import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../fonts/data/font_runtime_loader.dart';
import '../../fonts/data/font_storage.dart';

/// Picks a local .ttf/.otf file, caches it into app support dir, and returns a
/// file:// URL that will be stored into user_settings.ui_config.font.source.
///
/// IMPORTANT: This does NOT upload anything.
class LocalFontImportDialog extends ConsumerStatefulWidget {
  const LocalFontImportDialog({super.key});

  @override
  ConsumerState<LocalFontImportDialog> createState() =>
      _LocalFontImportDialogState();
}

class _LocalFontImportDialogState extends ConsumerState<LocalFontImportDialog> {
  bool _loading = false;
  String? _error;
  String? _pickedPath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择本地字体'),
      content: SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('选择本地 .ttf 或 .otf 文件（仅本地缓存，不上传）。'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _loading ? null : _pickFile,
              icon: const Icon(Icons.folder_open),
              label: Text(
                _pickedPath == null ? '选择文件' : '已选择：${_short(_pickedPath!)}',
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: (_loading || _pickedPath == null) ? null : _onCacheAndUse,
          child: _loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('使用'),
        ),
      ],
    );
  }

  String _short(String p) {
    final sep = p.contains('\\') ? '\\' : '/';
    final parts = p.split(sep);
    return parts.isNotEmpty ? parts.last : p;
  }

  Future<void> _pickFile() async {
    setState(() {
      _error = null;
      _pickedPath = null;
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['ttf', 'otf'],
      withData: false,
    );

    final path = result?.files.single.path;
    if (path == null || path.trim().isEmpty) return;

    setState(() => _pickedPath = path);
  }

  Future<void> _onCacheAndUse() async {
    final path = _pickedPath;
    if (path == null) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final src = File(path);
      if (!await src.exists()) {
        setState(() => _error = '文件不存在');
        return;
      }
      if (!FontStorage.isTtfOrOtfPath(src.path)) {
        setState(() => _error = '仅支持 .ttf 或 .otf');
        return;
      }

      // Cache into app support dir, so runtime loader can load consistently.
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final target = await FontStorage.targetFileForId(
        id: 'local_$id',
        sourcePathOrUrl: src.path,
      );
      await src.copy(target.path);

      // Preload once to validate.
      await FontRuntimeLoader.ensureLoaded(
        family: FontRuntimeLoader.urlFontFamily,
        filePath: target.path,
      );

      final fileUrl = Uri.file(target.path).toString();
      if (!mounted) return;
      Navigator.pop<String>(context, fileUrl);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
