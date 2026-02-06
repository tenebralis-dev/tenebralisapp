import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/llm_service.dart';
import '../../../../core/services/system_event_handler.dart';
import '../../data/conversation_repository.dart';
import '../../data/conversation_message_repository.dart';
import '../../../worlds/application/world_context_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../worlds/data/models/world.dart';

part 'chat_controller.g.dart';

/// Chat Message Model
class ChatMessageModel {
  ChatMessageModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.npcName,
    this.npcAvatar,
    this.isStreaming = false,
    this.systemEvents = const [],
  });

  final String id;
  String content;
  final ChatSender sender;
  final DateTime timestamp;
  final String? npcName;
  final String? npcAvatar;
  bool isStreaming;
  final List<SystemEvent> systemEvents;

  ChatMessageModel copyWith({
    String? id,
    String? content,
    ChatSender? sender,
    DateTime? timestamp,
    String? npcName,
    String? npcAvatar,
    bool? isStreaming,
    List<SystemEvent>? systemEvents,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      npcName: npcName ?? this.npcName,
      npcAvatar: npcAvatar ?? this.npcAvatar,
      isStreaming: isStreaming ?? this.isStreaming,
      systemEvents: systemEvents ?? this.systemEvents,
    );
  }
}

enum ChatSender { user, npc, system }

/// Chat State
class ChatState {
  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isStreaming = false,
    this.error,
    this.currentWorldId,
    this.currentNpcKey,
    this.systemPrompt,
  });

  final List<ChatMessageModel> messages;
  final bool isLoading;
  final bool isStreaming;
  final String? error;
  final String? currentWorldId;
  final String? currentNpcKey;
  final String? systemPrompt;

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    bool? isStreaming,
    String? error,
    String? currentWorldId,
    String? currentNpcKey,
    String? systemPrompt,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isStreaming: isStreaming ?? this.isStreaming,
      error: error,
      currentWorldId: currentWorldId ?? this.currentWorldId,
      currentNpcKey: currentNpcKey ?? this.currentNpcKey,
      systemPrompt: systemPrompt ?? this.systemPrompt,
    );
  }
}

/// Chat Controller
@riverpod
class ChatController extends _$ChatController {
  late LLMService _llmService;
  late SystemEventHandler _eventHandler;
  late ConversationRepository _conversationRepository;
  late ConversationMessageRepository _messageRepository;

  @override
  ChatState build() {
    _llmService = ref.watch(llmServiceProvider);
    _eventHandler = ref.watch(systemEventHandlerProvider);
    _conversationRepository = ref.watch(conversationRepositoryProvider);
    _messageRepository = ref.watch(conversationMessageRepositoryProvider);

    return const ChatState();
  }

  /// Initialize chat for a world/NPC
  Future<void> initializeChat({
    String? worldId,
    String? npcKey,
    World? world,
  }) async {
    // Build system prompt from world settings
    String systemPrompt = _buildDefaultSystemPrompt();

    if (world?.settings != null) {
      final settings = world!.settings!;
      systemPrompt = '''
${settings.systemPrompt ?? ''}

${settings.worldPrompt ?? ''}

${settings.stylePrompt ?? ''}
''';
    }

    state = state.copyWith(
      currentWorldId: worldId,
      currentNpcKey: npcKey,
      systemPrompt: systemPrompt,
      messages: [],
    );

    // Add welcome message
    _addSystemMessage('欢迎进入梦境世界。开始你的故事吧。');

    // Load chat history if available
    await _loadChatHistory();
  }

  /// Build default system prompt
  String _buildDefaultSystemPrompt() {
    return '''
你是一个沉浸式叙事游戏的AI向导。你的任务是：
1. 以第二人称描述场景和事件
2. 扮演游戏中的NPC与用户互动
3. 根据用户的选择推进故事
4. 在适当时机触发游戏事件

保持回复简洁生动，营造沉浸感。
''';
  }

  /// Load chat history
  Future<void> _loadChatHistory() async {
    final authState = ref.read(authControllerProvider);
    final userId = authState.user?.id;
    if (userId == null) return;

    final ctx = ref.read(worldContextControllerProvider);
    final saveId = ctx.saveId;
    if (saveId == null) return;

    // For MVP, we use a single per-save conversation thread.
    // npc_id must be a real row; until NPC UI exists, this will be provided by backend seeding.
    // Here we fallback to a stable placeholder value that must exist.
    const npcId = '00000000-0000-0000-0000-000000000000';
    const threadKey = 'main';

    try {
      final conversation = await _conversationRepository.getOrCreate(
        saveId: saveId,
        npcId: npcId,
        threadKey: threadKey,
      );

      final conversationId = conversation['id'] as String;

      // Load last 50 messages (descending) then reverse to display.
      final rows = await _messageRepository.list(
        conversationId: conversationId,
        limit: 50,
      );

      final history = rows.reversed.map((row) {
        final role = row['role'] as String? ?? 'system';
        final content = row['content'] as String? ?? '';
        final createdAtStr = row['created_at'] as String?;
        final createdAt = createdAtStr == null ? DateTime.now() : DateTime.tryParse(createdAtStr) ?? DateTime.now();

        return ChatMessageModel(
          id: row['id'] as String,
          content: content,
          sender: role == 'user'
              ? ChatSender.user
              : role == 'assistant'
                  ? ChatSender.npc
                  : ChatSender.system,
          timestamp: createdAt,
          npcName: role == 'assistant' ? '向导' : null,
        );
      }).toList();

      if (history.isNotEmpty) {
        state = state.copyWith(messages: history);
      }
    } catch (_) {
      // history is optional
    }
  }

  /// Add a system message
  void _addSystemMessage(String content) {
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      sender: ChatSender.system,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  /// Send a user message
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (state.isLoading || state.isStreaming) return;

    final authState = ref.read(authControllerProvider);
    final userId = authState.user?.id;

    // Add user message
    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      sender: ChatSender.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    // Persist user message
    if (userId != null) {
      await _persistMessage(role: 'user', content: userMessage.content);
    }

    // Get AI response
    await _getAIResponse(text, userId);
  }

  /// Get AI response (streaming or non-streaming)
  Future<void> _getAIResponse(String userMessage, String? userId) async {
    // Build conversation history
    final history = state.messages
        .where((m) => m.sender != ChatSender.system)
        .take(20)
        .map((m) => LLMMessage(
              role: m.sender == ChatSender.user ? LLMRole.user : LLMRole.assistant,
              content: m.content,
            ))
        .toList();

    // Use streaming for narrative feel
    await _streamResponse(history, userId);
  }

  /// Stream AI response (Narrative Mode)
  Future<void> _streamResponse(List<LLMMessage> history, String? userId) async {
    // Create placeholder message
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    final npcMessage = ChatMessageModel(
      id: messageId,
      content: '',
      sender: ChatSender.npc,
      timestamp: DateTime.now(),
      npcName: '向导',
      isStreaming: true,
    );

    state = state.copyWith(
      messages: [...state.messages, npcMessage],
      isLoading: false,
      isStreaming: true,
    );

    try {
      final stream = _llmService.streamResponse(
        messages: history,
        systemPrompt: state.systemPrompt,
      );

      final buffer = StringBuffer();

      await for (final chunk in stream) {
        buffer.write(chunk);

        // Update message content
        final updatedMessages = state.messages.map((m) {
          if (m.id == messageId) {
            return m.copyWith(content: buffer.toString());
          }
          return m;
        }).toList();

        state = state.copyWith(messages: updatedMessages);
      }

      // Mark streaming as complete
      final finalMessages = state.messages.map((m) {
        if (m.id == messageId) {
          return m.copyWith(isStreaming: false);
        }
        return m;
      }).toList();

      state = state.copyWith(
        messages: finalMessages,
        isStreaming: false,
      );

      // Persist assistant message
      if (userId != null) {
        final finalMessage = finalMessages.firstWhere((m) => m.id == messageId);
        await _persistMessage(role: 'assistant', content: finalMessage.content);
      }
    } catch (e) {
      state = state.copyWith(
        isStreaming: false,
        error: '获取响应失败: $e',
      );
    }
  }

  /// Get structured AI response (System Mode - for game logic)
  Future<void> getStructuredResponse(String userMessage, String? userId) async {
    final history = state.messages
        .where((m) => m.sender != ChatSender.system)
        .take(20)
        .map((m) => LLMMessage(
              role: m.sender == ChatSender.user ? LLMRole.user : LLMRole.assistant,
              content: m.content,
            ))
        .toList();

    try {
      final response = await _llmService.getResponse(
        messages: history,
        systemPrompt: state.systemPrompt,
        expectJson: true,
      );

      // Add AI message
      final npcMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response.dialogue,
        sender: ChatSender.npc,
        timestamp: DateTime.now(),
        npcName: '向导',
        systemEvents: response.systemEvents,
      );

      state = state.copyWith(
        messages: [...state.messages, npcMessage],
        isLoading: false,
      );

      // Process system events
      if (response.systemEvents.isNotEmpty && userId != null) {
        await _eventHandler.processEvents(
          userId: userId,
          worldId: state.currentWorldId,
          events: response.systemEvents,
        );
      }

      // Persist assistant message
      if (userId != null) {
        await _persistMessage(
          role: 'assistant',
          content: npcMessage.content,
          metadata: {
            if (response.systemEvents.isNotEmpty)
              'system_events': response.systemEvents.map((e) => e.toJson()).toList(),
          },
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '获取响应失败: $e',
      );
    }
  }

  Future<void> _persistMessage({
    required String role,
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final ctx = ref.read(worldContextControllerProvider);
    final saveId = ctx.saveId;
    if (saveId == null) return;

    const npcId = '00000000-0000-0000-0000-000000000000';
    const threadKey = 'main';

    try {
      final conversation = await _conversationRepository.getOrCreate(
        saveId: saveId,
        npcId: npcId,
        threadKey: threadKey,
      );
      final conversationId = conversation['id'] as String;

      await _messageRepository.insert(
        conversationId: conversationId,
        role: role,
        content: content,
        metadata: metadata,
      );

      await _conversationRepository.touchLastMessageAt(conversationId);
    } catch (_) {
      // best-effort
    }
  }

  /// Clear chat
  void clearChat() {
    state = state.copyWith(
      messages: [],
      error: null,
    );
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
