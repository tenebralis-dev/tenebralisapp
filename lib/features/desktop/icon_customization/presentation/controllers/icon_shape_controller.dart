import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/icon_shape_prefs.dart';
import '../../domain/icon_shape.dart';
class IconShapeController extends AutoDisposeAsyncNotifier<IconShape> {
  @override
  Future<IconShape> build() async {
    final prefs = await ref.watch(iconShapePrefsProvider.future);
    final shape = await prefs.load();

    return shape;
  }

  Future<void> setShape(IconShape shape) async {
    state = AsyncValue.data(shape);
    final prefs = await ref.watch(iconShapePrefsProvider.future);
    await prefs.save(shape);
  }
}

final iconShapeControllerProvider =
    AsyncNotifierProvider.autoDispose<IconShapeController, IconShape>(
  IconShapeController.new,
);
