import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'world_context_controller.g.dart';

/// Current narrative context selected by user.
///
/// This is intentionally local-only state (can be persisted later).
@riverpod
class WorldContextController extends _$WorldContextController {
  @override
  WorldContextState build() {
    return const WorldContextState();
  }

  void setWorld({required String worldId}) {
    state = state.copyWith(worldId: worldId, identityId: null, saveId: null);
  }

  void setIdentity({required String worldId, required String identityId}) {
    state = state.copyWith(worldId: worldId, identityId: identityId, saveId: null);
  }

  void setSave({
    required String worldId,
    required String identityId,
    required String saveId,
  }) {
    state = state.copyWith(worldId: worldId, identityId: identityId, saveId: saveId);
  }

  void clear() {
    state = const WorldContextState();
  }
}

class WorldContextState {
  const WorldContextState({this.worldId, this.identityId, this.saveId});

  final String? worldId;
  final String? identityId;
  final String? saveId;

  WorldContextState copyWith({
    String? worldId,
    String? identityId,
    String? saveId,
  }) {
    return WorldContextState(
      worldId: worldId ?? this.worldId,
      identityId: identityId,
      saveId: saveId,
    );
  }
}
