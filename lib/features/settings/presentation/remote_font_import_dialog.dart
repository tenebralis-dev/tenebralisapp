import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog that returns a font URL (http/https .ttf or .otf).
/// Caller persists to user_settings.ui_config.font and loads via FontRuntimeLoader.
class RemoteFontImportDialog extends ConsumerStatefulWidget {
  const RemoteFontImportDialog({super.key});

  @override
  ConsumerState<RemoteFontImportDialog> createState() =>
      _RemoteFontImportDialogState();
}

class _RemoteFontImportDialogState extends ConsumerState<RemoteFontImportDialog> {
  final _urlController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('字体直链'),
      content: SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('粘贴 .ttf 或 .otf 的 http/https 直链。'),
            const SizedBox(height: 12),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: '字体直链（必填）',
                hintText: 'https://example.com/font.ttf',
                border: const OutlineInputBorder(),
                errorText: _error,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _loading ? null : _onConfirm,
          child: _loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('确定'),
        ),
      ],
    );
  }

  Future<void> _onConfirm() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() => _error = '请填写字体直链');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !(uri.scheme == 'http' || uri.scheme == 'https') ||
        !(url.toLowerCase().endsWith('.ttf') || url.toLowerCase().endsWith('.otf'))) {
      setState(() => _error = '请输入 http/https 的 .ttf 或 .otf 链接');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    if (!mounted) return;
    Navigator.pop<String>(context, url);
  }
}
