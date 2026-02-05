import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/llm_service.dart';
import '../../../../core/services/system_event_handler.dart';
import '../../../chronicles/data/models/chronicle_model.dart';
import '../../../chronicles/data/repositories/chronicle_repository.dart';
import '../../../worlds/data/models/world_model.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

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
  late ChronicleRepository _chronicleRepository;

  @override
  ChatState build() {
    _llmService = ref.watch(llmServiceProvider);
    _eventHandler = ref.watch(systemEventHandlerProvider);
    _chronicleRepository = ref.watch(chronicleRepositoryProvider);

    return const ChatState();
  }

  /// Initialize chat for a world/NPC
  Future<void> initializeChat({
    String? worldId,
    String? npcKey,
    WorldModel? world,
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
    await _loadChatHistory(worldId);
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
  Future<void> _loadChatHistory(String? worldId) async {
    if (worldId == null) return;

    final authState = ref.read(authControllerProvider);
    final userId = authState.user?.id;
    if (userId == null) return;

    try {
      final chronicles = await _chronicleRepository.getChatHistory(
        userId,
        worldId,
        limit: 20,
      );

      final historyMessages = chronicles.reversed.map((chronicle) {
        final content = chronicle.content;
        if (content is ChatContent) {
          return ChatMessageModel(
            id: chronicle.id,
            content: content.message,
            sender: _chronicleSenderToChatSender(content.sender),
            timestamp: chronicle.createdAt ?? DateTime.now(),
            npcName: content.npcKey,
          );
        }
        return null;
      }).whereType<ChatMessageModel>().toList();

      if (historyMessages.isNotEmpty) {
        state = state.copyWith(messages: [...historyMessages, ...state.messages]);
      }
    } catch (e) {
      // Silently fail - history is optional
    }
  }

  ChatSender _chronicleSenderToChatSender(String sender) {
    switch (sender) {
      case 'user':
        return ChatSender.user;
      case 'npc':
        return ChatSender.npc;
      case 'system':
        return ChatSender.system;
      default:
        return ChatSender.system;
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

    // Save user message to chronicles
    if (userId != null && state.currentWorldId != null) {
      _saveMessageToChronicle(userId, userMessage);
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

      // Save to chronicle
      if (userId != null && state.currentWorldId != null) {
        final finalMessage = finalMessages.firstWhere((m) => m.id == messageId);
        _saveMessageToChronicle(userId, finalMessage);
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

      // Save to chronicle
      if (userId != null && state.currentWorldId != null) {
        _saveMessageToChronicle(userId, npcMessage, response.systemEvents);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '获取响应失败: $e',
      );
    }
  }

  /// Save message to chronicle database
  Future<void> _saveMessageToChronicle(
    String userId,
    ChatMessageModel message, [
    List<SystemEvent>? events,
  ]) async {
    try {
      await _chronicleRepository.createChatChronicle(
        userId: userId,
        worldId: state.currentWorldId!,
        sender: message.sender == ChatSender.user ? 'user' : 'npc',
        message: message.content,
        npcKey: message.npcName,
        systemEvents: events,
      );
    } catch (e) {
      // Silently fail - saving is not critical
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
