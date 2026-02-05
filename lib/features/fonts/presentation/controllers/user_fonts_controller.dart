import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/user_font_repository.dart';
import '../../domain/user_font.dart';

part 'user_fonts_controller.g.dart';

@riverpod
class UserFontsController extends _$UserFontsController {
  late UserFontRepository _repo;

  @override
  Future<List<UserFont>> build() async {
    _repo = ref.watch(userFontRepositoryProvider);
    return _repo.list();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.list());
  }

  Future<void> upsert(UserFont font) async {
    await _repo.upsert(font);
    await refresh();
  }

  Future<void> remove(String id) async {
    await _repo.removeById(id);
    await refresh();
  }

  /// Remove font and delete cached local file if any.
  Future<void> removeAndDeleteFile(UserFont font) async {
    // Best effort cleanup.
    try {
      // ignore: avoid_slow_async_io
      final p = font.localPath;
      if (p != null && p.trim().isNotEmpty) {
        final f = File(p);
        if (await f.exists()) {
          await f.delete();
        }
      }
    } catch (_) {}

    await remove(font.id);
  }
}

@riverpod
class SelectedUserFontId extends _$SelectedUserFontId {
  late UserFontRepository _repo;

  @override
  Future<String?> build() async {
    _repo = ref.watch(userFontRepositoryProvider);
    return _repo.getSelectedFontId();
  }

  Future<void> set(String? id) async {
    await _repo.setSelectedFontId(id);
    state = AsyncData(id);
  }
}
