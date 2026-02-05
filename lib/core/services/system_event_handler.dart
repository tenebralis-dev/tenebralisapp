import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/chronicles/data/models/chronicle_model.dart';
import '../../features/profiles/data/repositories/profile_repository.dart';
import '../../features/profiles/data/models/profile_model.dart';
import '../../features/profiles/data/models/relationship_model.dart';
import '../../features/chronicles/data/repositories/chronicle_repository.dart';

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
    required this.profileRepository,
    required this.chronicleRepository,
  });

  final ProfileRepository profileRepository;
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
          return await _handleQuestUpdate(userId, worldId!, event);

        case SystemEventTypes.updateAffection:
          return await _handleAffectionUpdate(userId, worldId!, event);

        case SystemEventTypes.unlockItem:
          return await _handleUnlockItem(userId, event);

        case SystemEventTypes.unlockAchievement:
          return await _handleUnlockAchievement(userId, event);

        case SystemEventTypes.unlockWorld:
          return await _handleUnlockWorld(userId, event);

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
    final profile = await profileRepository.updateGlobalPoints(userId, amount);

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
      data: {'newPoints': profile.globalPoints},
    );
  }

  /// Handle quest update event
  Future<EventProcessingResult> _handleQuestUpdate(
    String userId,
    String worldId,
    SystemEvent event,
  ) async {
    final questId = event.questId;
    final status = event.status;

    if (questId == null || status == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '缺少任务ID或状态',
      );
    }

    // Update relationship (quest progress)
    await profileRepository.upsertRelationship(
      RelationshipModel(
        id: '',
        userId: userId,
        worldId: worldId,
        targetType: RelationshipTargetType.quest,
        targetKey: questId,
        value: _questStatusToValue(status),
        state: {'status': status},
      ),
    );

    String message;
    switch (status) {
      case 'completed':
        message = '任务完成！';
        break;
      case 'in_progress':
        message = '任务进行中';
        break;
      case 'failed':
        message = '任务失败';
        break;
      default:
        message = '任务状态更新: $status';
    }

    return EventProcessingResult(
      event: event,
      success: true,
      message: message,
    );
  }

  /// Handle affection update event
  Future<EventProcessingResult> _handleAffectionUpdate(
    String userId,
    String worldId,
    SystemEvent event,
  ) async {
    final npcKey = event.npcKey;
    final value = event.value ?? 0;

    if (npcKey == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '缺少NPC Key',
      );
    }

    // Update relationship (affection)
    await profileRepository.updateRelationshipValue(
      userId,
      worldId,
      RelationshipTargetType.npc,
      npcKey,
      value,
    );

    final message = value >= 0 ? '好感度 +$value' : '好感度 $value';

    return EventProcessingResult(
      event: event,
      success: true,
      message: message,
    );
  }

  /// Handle unlock item event
  Future<EventProcessingResult> _handleUnlockItem(
    String userId,
    SystemEvent event,
  ) async {
    final itemId = event.data['item_id'] as String?;
    if (itemId == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '缺少物品ID',
      );
    }

    final profile = await profileRepository.getProfile(userId);
    if (profile == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '用户不存在',
      );
    }

    final currentItems = profile.inventory?.items ?? [];
    if (currentItems.contains(itemId)) {
      return EventProcessingResult(
        event: event,
        success: true,
        message: '物品已拥有',
      );
    }

    final newInventory = profile.inventory?.copyWith(
          items: [...currentItems, itemId],
        ) ??
        UserInventory(items: [itemId]);

    await profileRepository.updateInventory(userId, newInventory);

    return EventProcessingResult(
      event: event,
      success: true,
      message: '获得新物品！',
      data: {'itemId': itemId},
    );
  }

  /// Handle unlock achievement event
  Future<EventProcessingResult> _handleUnlockAchievement(
    String userId,
    SystemEvent event,
  ) async {
    final achievementId = event.data['achievement_id'] as String?;
    if (achievementId == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '缺少成就ID',
      );
    }

    final profile = await profileRepository.getProfile(userId);
    if (profile == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '用户不存在',
      );
    }

    final currentAchievements = profile.inventory?.achievements ?? [];
    if (currentAchievements.contains(achievementId)) {
      return EventProcessingResult(
        event: event,
        success: true,
        message: '成就已解锁',
      );
    }

    final newInventory = profile.inventory?.copyWith(
          achievements: [...currentAchievements, achievementId],
        ) ??
        UserInventory(achievements: [achievementId]);

    await profileRepository.updateInventory(userId, newInventory);

    return EventProcessingResult(
      event: event,
      success: true,
      message: '成就解锁！',
      data: {'achievementId': achievementId},
    );
  }

  /// Handle unlock world event
  Future<EventProcessingResult> _handleUnlockWorld(
    String userId,
    SystemEvent event,
  ) async {
    final worldId = event.data['world_id'] as String?;
    if (worldId == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '缺少世界ID',
      );
    }

    final profile = await profileRepository.getProfile(userId);
    if (profile == null) {
      return EventProcessingResult(
        event: event,
        success: false,
        message: '用户不存在',
      );
    }

    final currentWorlds = profile.inventory?.unlockedWorlds ?? [];
    if (currentWorlds.contains(worldId)) {
      return EventProcessingResult(
        event: event,
        success: true,
        message: '世界已解锁',
      );
    }

    final newInventory = profile.inventory?.copyWith(
          unlockedWorlds: [...currentWorlds, worldId],
        ) ??
        UserInventory(unlockedWorlds: [worldId]);

    await profileRepository.updateInventory(userId, newInventory);

    return EventProcessingResult(
      event: event,
      success: true,
      message: '新世界解锁！',
      data: {'worldId': worldId},
    );
  }

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

  /// Convert quest status string to numeric value
  int _questStatusToValue(String status) {
    switch (status) {
      case 'not_started':
        return 0;
      case 'in_progress':
        return 1;
      case 'completed':
        return 2;
      case 'failed':
        return -1;
      default:
        return 0;
    }
  }
}

/// Provider for System Event Handler
@riverpod
SystemEventHandler systemEventHandler(Ref ref) {
  return SystemEventHandler(
    profileRepository: ref.watch(profileRepositoryProvider),
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
