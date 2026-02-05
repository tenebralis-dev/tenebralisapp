import 'dart:io';

import 'package:dio/dio.dart';

import '../domain/user_font.dart';
import 'font_runtime_loader.dart';
import 'font_storage.dart';

class FontImportException implements Exception {
  FontImportException(this.message);
  final String message;

  @override
  String toString() => message;
}

class FontImporter {
  FontImporter({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<UserFont> importFromRemoteUrl({
    required String id,
    required String url,
    String? tagName,
  }) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !(uri.scheme == 'http' || uri.scheme == 'https')) {
      throw FontImportException('无效链接：仅支持 http/https');
    }
    if (!FontStorage.isTtfOrOtfPath(uri.path)) {
      throw FontImportException('只允许 .ttf 或 .otf 直链');
    }

    final target = await FontStorage.targetFileForId(id: id, sourcePathOrUrl: uri.path);

    try {
      await _dio.download(
        uri.toString(),
        target.path,
        options: Options(responseType: ResponseType.bytes, followRedirects: true),
      );
    } on DioException catch (e) {
      throw FontImportException('下载失败：${e.message}');
    }

    final family = FontStorage.familyKey(id);
    await FontRuntimeLoader.ensureLoaded(family: family, filePath: target.path);

    final ext = uri.path.toLowerCase().endsWith('.otf') ? 'otf' : 'ttf';

    return UserFont(
      id: id,
      sourceType: UserFontSourceType.remoteUrl,
      originalName: uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'Remote font',
      tagName: tagName?.trim().isEmpty == true ? null : tagName?.trim(),
      remoteUrl: uri.toString(),
      localPath: target.path,
      family: family,
      format: ext,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<UserFont> importFromLocalFile({
    required String id,
    required String sourcePath,
    String? tagName,
  }) async {
    final src = File(sourcePath);
    if (!await src.exists()) {
      throw FontImportException('文件不存在');
    }
    if (!FontStorage.isTtfOrOtfPath(src.path)) {
      throw FontImportException('只允许 .ttf 或 .otf 文件');
    }

    final target = await FontStorage.targetFileForId(id: id, sourcePathOrUrl: src.path);
    await src.copy(target.path);

    final family = FontStorage.familyKey(id);
    await FontRuntimeLoader.ensureLoaded(family: family, filePath: target.path);

    final ext = src.path.toLowerCase().endsWith('.otf') ? 'otf' : 'ttf';

    return UserFont(
      id: id,
      sourceType: UserFontSourceType.localFile,
      originalName: src.uri.pathSegments.isNotEmpty ? src.uri.pathSegments.last : 'Local font',
      tagName: tagName?.trim().isEmpty == true ? null : tagName?.trim(),
      localPath: target.path,
      family: family,
      format: ext,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
