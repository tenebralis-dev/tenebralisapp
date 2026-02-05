import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FontStorage {
  FontStorage._();

  static const _dirName = 'user_fonts';

  static Future<Directory> _baseDir() async {
    // Use application support directory (not user-visible).
    final base = await getApplicationSupportDirectory();
    return Directory('${base.path}${Platform.pathSeparator}$_dirName');
  }

  static Future<Directory> ensureFontsDir() async {
    final dir = await _baseDir();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static String familyKey(String id) => 'userfont_$id';

  static String _extFromPath(String pathOrUrl) {
    final lower = pathOrUrl.toLowerCase();
    if (lower.endsWith('.otf')) return 'otf';
    return 'ttf';
  }

  static bool isTtfOrOtfPath(String pathOrUrl) {
    final lower = pathOrUrl.toLowerCase();
    return lower.endsWith('.ttf') || lower.endsWith('.otf');
  }

  static Future<File> targetFileForId({
    required String id,
    required String sourcePathOrUrl,
  }) async {
    final dir = await ensureFontsDir();
    final ext = _extFromPath(sourcePathOrUrl);
    return File('${dir.path}${Platform.pathSeparator}$id.$ext');
  }

  static Future<void> deleteIfExists(String? path) async {
    if (path == null || path.trim().isEmpty) return;
    final f = File(path);
    if (await f.exists()) {
      await f.delete();
    }
  }
}
