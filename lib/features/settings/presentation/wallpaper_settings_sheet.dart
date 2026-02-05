import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../desktop/presentation/controllers/wallpaper_controller.dart';

class WallpaperSettingsSheet extends ConsumerStatefulWidget {
  const WallpaperSettingsSheet({super.key});

  @override
  ConsumerState<WallpaperSettingsSheet> createState() =>
      _WallpaperSettingsSheetState();
}

class _WallpaperSettingsSheetState extends ConsumerState<WallpaperSettingsSheet> {
  late final TextEditingController _urlController;
  String? _preview;

  @override
  void initState() {
    super.initState();
    final current = ref.read(wallpaperControllerProvider);
    _preview = current.isNone ? null : current.value;
    _urlController = TextEditingController(
      text: current.type == 'url' ? current.value : '',
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final scheme = Theme.of(context).colorScheme;
    final current = ref.watch(wallpaperControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              s.wallpaperTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            _PreviewCard(path: _preview, scheme: scheme),
            const SizedBox(height: 12),

            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: s.wallpaperUrlLabel,
                hintText: s.wallpaperUrlHint,
                prefixIcon: const Icon(Icons.link),
                border: const OutlineInputBorder(),
              ),
              onChanged: (v) {
                setState(() => _preview = v.trim().isEmpty ? null : v.trim());
              },
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text(s.wallpaperPickLocal),
                    onPressed: _pickLocal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: Text(s.wallpaperClear),
                    onPressed: current.isNone
                        ? null
                        : () async {
                            await ref
                                .read(wallpaperControllerProvider.notifier)
                                .setNone();
                            if (!mounted) return;
                            Navigator.pop(context);
                          },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final url = _urlController.text.trim();
                if (url.isEmpty) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.wallpaperUrlEmpty)),
                  );
                  return;
                }

                final uri = Uri.tryParse(url);
                final ok = uri != null &&
                    (uri.scheme == 'http' || uri.scheme == 'https') &&
                    (url.toLowerCase().endsWith('.jpg') ||
                        url.toLowerCase().endsWith('.jpeg') ||
                        url.toLowerCase().endsWith('.png'));

                if (!ok) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.wallpaperUrlInvalid)),
                  );
                  return;
                }

                await ref
                    .read(wallpaperControllerProvider.notifier)
                    .setUrl(url);
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: Text(s.wallpaperApplyUrl),
            ),

            const SizedBox(height: 8),
            Text(
              s.wallpaperCurrent(current),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickLocal() async {
    final s = ref.read(stringsProvider);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png'],
        withData: false,
      );
      if (result == null || result.files.isEmpty) return;

      final path = result.files.single.path;
      if (path == null || path.trim().isEmpty) return;

      final f = File(path);
      if (!f.existsSync()) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.wallpaperLocalNotFound)),
        );
        return;
      }

      // Local wallpapers are per-device; do NOT upload.
      await ref.read(wallpaperControllerProvider.notifier).setFile(path);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${s.wallpaperPickFailed}：$e')),
      );
    }
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.path, required this.scheme});

  final String? path;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final p = path;
    final uri = p == null ? null : Uri.tryParse(p);
    final isRemote = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');

    ImageProvider? provider;
    if (p != null && p.trim().isNotEmpty) {
      if (isRemote) {
        provider = NetworkImage(p);
      } else {
        final file = File(p);
        if (file.existsSync()) {
          provider = FileImage(file);
        }
      }
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        image: provider != null
            ? DecorationImage(image: provider, fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: provider == null
          ? Text(
              'Preview',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: scheme.onSurfaceVariant),
            )
          : null,
    );
  }
}
