import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/chronicles/data/models/chronicle_model.dart';
import '../../features/chronicles/data/repositories/chronicle_repository.dart';
import '../../features/auth/domain/users_repository.dart';
import '../../features/auth/domain/host_profile.dart';

part 'system_event_handler.g.dart';

/// System Event Types
abstract class SystemEventTypes {
  static const String pointChange = 'point_change';
  static const String updateQuest = 'update_quest';
  static const String updateAffection = 'update_affection';
  static const String unlockItem = 'unlock_item';
  static const String unlockAchievement = 'unlock_achievement';
  static const String unlockWorld = 'unlock_world';
  static const String setFlag = 'set_flag';
  static const String notification = 'notification';
}

/// Result of processing a system event
class EventProcessingResult {
  const EventProcessingResult({
    required this.event,
    required this.success,
    this.message,
    this.data,
  });

  final SystemEvent event;
  final bool success;
  final String? message;
  final dynamic data;
}

/// System Event Handler
/// Processes system events from AI responses and updates game state
class SystemEventHandler {
  SystemEventHandler({
    required this.usersRepository,
    required this.chronicleRepository,
  });

  final UsersRepository usersRepository;
  final ChronicleRepository chronicleRepository;

  /// Process a list of system events
  Future<List<EventProcessingResult>> processEvents({
    required String userId,
    required String? worldId,
    required List<SystemEvent> events,
  }) async {
    final results = <EventProcessingResult>[];

    for (final event in events) {
      final result = await _processEvent(userId, worldId, event);
      results.add(result);
    }

    return results;
  }

  /// Process a single system event
  Future<EventProcessingResult> _processEvent(
    String userId,
    String? worldId,
    SystemEvent event,
  ) async {
    try {
      switch (event.type) {
        case SystemEventTypes.pointChange:
          return await _handlePointChange(userId, worldId, event);

        case SystemEventTypes.updateQuest:
        case SystemEventTypes.updateAffection:
        case SystemEventTypes.unlockItem:
        case SystemEventTypes.unlockAchievement:
        case SystemEventTypes.unlockWorld:
          // Legacy profile/relationship/inventory features were stored in `profiles`.
          // New DB baseline (users/user_settings + Part2~Part7 tables) does not include them.
          // These events will be re-implemented on top of tasks/achievements/currency/inventory later.
          return EventProcessingResult(
            event: event,
            success: false,
            message: '该事件类型尚未迁移到新数据模型: ${event.type}',
          );

        case SystemEventTypes.notification:
          return _handleNotification(event);

        default:
          return EventProcessingResult(
            event: event,
            success: false,
            message: '未知事件类型: ${event.type}',
          );
      }
    } catch (e) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '处理失败: $e',
      );
    }
  }

  /// Handle point change event
  Future<EventProcessingResult> _handlePointChange(
    String userId,
    String? worldId,
    SystemEvent event,
  ) async {
    final amount = event.amount ?? 0;
    final reason = event.reason ?? '未知原因';

    // Update profile points
    // New DB baseline doesn't support server-side "global points" mutations yet.
    // Keep event processing best-effort and return current host profile snapshot.
    final HostProfile? profile = await usersRepository.getCurrent();

    // Create transaction chronicle
    await chronicleRepository.createTransactionChronicle(
      userId: userId,
      worldId: worldId,
      transactionType: 'point_change',
      amount: amount,
      reason: reason,
    );

    final message = amount >= 0 ? '获得 $amount 积分' : '消耗 ${-amount} 积分';

    return EventProcessingResult(
      event: event,
      success: true,
      message: message,
      data: {'newPoints': profile?.expPoints},
    );
  }

  // Legacy handlers removed (profiles/relationships/inventory-based).

  /// Handle notification event (no database changes, just UI notification)
  EventProcessingResult _handleNotification(SystemEvent event) {
    final message = event.data['message'] as String? ?? '通知';
    final notificationType = event.data['notification_type'] as String? ?? 'info';

    return EventProcessingResult(
      event: event,
      success: true,
      message: message,
      data: {'type': notificationType},
    );
  }

}

/// Provider for System Event Handler
@riverpod
SystemEventHandler systemEventHandler(Ref ref) {
  return SystemEventHandler(
    usersRepository: ref.watch(usersRepositoryProvider),
    chronicleRepository: ref.watch(chronicleRepositoryProvider),
  );
}

/// Provider for processing events and showing results
@riverpod
class EventProcessor extends _$EventProcessor {
  @override
  List<EventProcessingResult> build() {
    return [];
  }

  /// Process events and update state
  Future<void> processEvents({
    required String userId,
    required String? worldId,
    required List<SystemEvent> events,
  }) async {
    final handler = ref.read(systemEventHandlerProvider);
    final results = await handler.processEvents(
      userId: userId,
      worldId: worldId,
      events: events,
    );

    state = results;
  }

  /// Clear results
  void clear() {
    state = [];
  }
}
