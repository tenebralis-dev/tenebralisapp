import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'widgets/message_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/typing_indicator.dart';

/// Chat Message Model (local UI model)
class ChatMessage {
  ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.npcName,
    this.npcAvatar,
    this.isStreaming = false,
  });

  final String id;
  String content;
  final MessageSender sender;
  final DateTime timestamp;
  final String? npcName;
  final String? npcAvatar;
  bool isStreaming;
}

enum MessageSender { user, npc, system }

/// Chat Page - Main chat interface with AI
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, this.worldId, this.npcKey});

  final String? worldId;
  final String? npcKey;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _isTyping = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _initializeChat() {
    // Add welcome message
    _addSystemMessage('欢迎来到梦境对话。在这里，你可以与AI进行沉浸式的故事互动。');

    // Add initial NPC message (mock)
    Future.delayed(500.ms, () {
      _addNpcMessage(
        '你好，旅行者。我是这个世界的向导。你想要开始怎样的冒险？',
        npcName: '向导',
      );
    });
  }

  void _addSystemMessage(String content) {
    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        sender: MessageSender.system,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String content) {
    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addNpcMessage(String content, {String? npcName, bool streaming = false}) {
    setState(() {
      _messages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        sender: MessageSender.npc,
        timestamp: DateTime.now(),
        npcName: npcName ?? 'NPC',
        isStreaming: streaming,
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _textController.clear();
    _addUserMessage(text);

    setState(() {
      _isTyping = true;
      _isLoading = true;
    });

    // Simulate AI response with typewriter effect
    await _simulateAiResponse(text);

    setState(() {
      _isTyping = false;
      _isLoading = false;
    });
  }

  Future<void> _simulateAiResponse(String userMessage) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock AI response based on user input
    final response = _getMockResponse(userMessage);

    // Add streaming message
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    setState(() {
      _messages.add(ChatMessage(
        id: messageId,
        content: '',
        sender: MessageSender.npc,
        timestamp: DateTime.now(),
        npcName: '向导',
        isStreaming: true,
      ));
    });

    // Typewriter effect
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((m) => m.id == messageId);
          if (index != -1) {
            _messages[index].content = response.substring(0, i + 1);
          }
        });
        _scrollToBottom();
      }
    }

    // Mark as complete
    setState(() {
      final index = _messages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        _messages[index].isStreaming = false;
      }
    });
  }

  String _getMockResponse(String userMessage) {
    final lowered = userMessage.toLowerCase();

    if (lowered.contains('你好') || lowered.contains('hi') || lowered.contains('hello')) {
      return '你好呀！很高兴见到你。在这片梦境之地，每一次相遇都是命运的安排。今天你想要探索什么呢？';
    } else if (lowered.contains('任务') || lowered.contains('quest')) {
      return '【系统提示】当前可接取的任务：\n\n1. 「迷雾森林的秘密」- 探索被迷雾笼罩的古老森林\n2. 「失落的遗迹」- 寻找传说中的神器碎片\n3. 「月夜的约定」- 帮助神秘的旅人完成他的心愿\n\n你想要接受哪个任务？';
    } else if (lowered.contains('探索') || lowered.contains('冒险')) {
      return '前方是一片广袤的平原，远处的山脉在云雾中若隐若现。你可以选择：\n\n🏔️ 向北前往雪山\n🌲 向东进入森林\n🏛️ 向南探索古堡\n\n你想往哪个方向走？';
    } else if (lowered.contains('积分') || lowered.contains('points')) {
      return '【系统】你当前拥有 1,250 积分。可以在商店中兑换各种物品和能力。继续探索和完成任务可以获得更多积分哦！';
    } else {
      return '我理解你的意思了。在这个梦境世界中，一切皆有可能。让我们继续这段奇妙的旅程吧。你还有什么想要问的或者想要做的吗？';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: _buildMessagesList(),
          ),

          // Typing Indicator
          if (_isTyping)
            const TypingIndicator()
                .animate()
                .fadeIn(duration: 200.ms),

          // Input Area
          ChatInput(
            controller: _textController,
            onSend: _handleSendMessage,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: Row(
        children: [
          // NPC Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF00D9FF)],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: const Icon(Icons.auto_awesome, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          // NPC Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '向导',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                _isTyping ? '正在输入...' : '在线',
                style: TextStyle(
                  fontSize: 12,
                  color: _isTyping ? const Color(0xFF00D9FF) : Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // TODO: Show chat options
          },
        ),
      ],
    );
  }

  Widget _buildMessagesList() {
    if (_messages.isEmpty) {
      return const Center(
        child: Text(
          '开始对话吧...',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final showAvatar = index == 0 ||
            _messages[index - 1].sender != message.sender;

        return MessageBubble(
          message: message,
          showAvatar: showAvatar,
        ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.1);
      },
    );
  }
}
