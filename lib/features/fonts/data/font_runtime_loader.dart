import 'dart:io';

import 'package:flutter/services.dart';

import 'font_storage.dart';

// Optional: use package:http or dio for download; here we use dart:io to avoid extra deps.

class FontRuntimeLoader {
  FontRuntimeLoader._();

  static final Set<String> _loadedSources = <String>{};

  /// Load font from local file path (TTF/OTF).
  static Future<void> ensureLoaded({
    required String family,
    required String filePath,
  }) async {
    if (_loadedSources.contains('family:$family')) return;

    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('字体文件不存在：$filePath');
    }

    final bytes = await file.readAsBytes();
    final byteData = ByteData.view(Uint8List.fromList(bytes).buffer);

    final loader = FontLoader(family);
    loader.addFont(Future.value(byteData));
    await loader.load();

    _loadedSources.add('family:$family');
  }

  /// Family name used for the single custom URL font in user_settings.
  static const String urlFontFamily = 'userfont_url';

  static String familyForSource(String urlOrFileUrl) {
    final uri = Uri.tryParse(urlOrFileUrl);
    if (uri == null) return urlFontFamily;
    // Use a stable family name per source, so switching between different
    // custom sources actually updates the rendered font.
    return 'userfont_${uri.toString().hashCode.abs()}';
  }

  /// Download font from URL to cache and load. Uses [urlFontFamily] as family.
  static Future<String> loadFromUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      throw Exception('Invalid font source: $url');
    }

    final family = familyForSource(url);
    if (_loadedSources.contains('source:${uri.toString()}')) return family;
    // Local file:// URL
    if (uri.scheme == 'file') {
      final p = uri.toFilePath(windows: Platform.isWindows);
      if (!FontStorage.isTtfOrOtfPath(p)) {
        throw Exception('Local font must be .ttf or .otf');
      }
      await ensureLoaded(family: family, filePath: p);
      _loadedSources.add('source:${uri.toString()}');
      return family;
    }

    // Remote http(s) URL
    if (!(uri.scheme == 'http' || uri.scheme == 'https')) {
      throw Exception('Invalid font URL scheme: ${uri.scheme}');
    }
    if (!FontStorage.isTtfOrOtfPath(uri.path)) {
      throw Exception('Font URL must point to .ttf or .otf');
    }

    final id = 'url_${uri.hashCode.abs()}';
    final target = await FontStorage.targetFileForId(
      id: id,
      sourcePathOrUrl: uri.path,
    );
    if (!await target.exists()) {
      final client = HttpClient();
      try {
        final request = await client.getUrl(uri);
        final response = await request.close();
        if (response.statusCode != 200) {
          throw Exception('Download failed: ${response.statusCode}');
        }
        final list = <int>[];
        await for (final chunk in response) {
          list.addAll(chunk);
        }
        await target.writeAsBytes(list);
      } finally {
        client.close();
      }
    }

    await ensureLoaded(family: family, filePath: target.path);
    _loadedSources.add('source:${uri.toString()}');
    return family;
  }
}

