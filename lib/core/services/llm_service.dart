import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/chronicles/data/models/chronicle_model.dart';

part 'llm_service.g.dart';

/// LLM Configuration
class LLMConfig {
  const LLMConfig({
    required this.apiKey,
    required this.baseUrl,
    this.model = 'gpt-4',
    this.maxTokens = 2048,
    this.temperature = 0.8,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
  final int maxTokens;
  final double temperature;

  /// Default config (placeholder - user should provide their own)
  static const LLMConfig defaultConfig = LLMConfig(
    apiKey: 'YOUR_API_KEY',
    baseUrl: 'https://api.openai.com/v1',
    model: 'gpt-4',
  );
}

/// LLM Message Role
enum LLMRole {
  system,
  user,
  assistant,
}

/// LLM Message
class LLMMessage {
  const LLMMessage({
    required this.role,
    required this.content,
  });

  final LLMRole role;
  final String content;

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'content': content,
      };
}

/// AI Response with parsed system events
class AIResponse {
  const AIResponse({
    this.thought,
    required this.dialogue,
    this.systemEvents = const [],
    this.rawResponse,
  });

  /// Internal AI reasoning (hidden from user)
  final String? thought;

  /// Visible dialogue text
  final String dialogue;

  /// System events to process
  final List<SystemEvent> systemEvents;

  /// Raw response for debugging
  final String? rawResponse;

  /// Parse from JSON response (System Mode)
  factory AIResponse.fromJson(Map<String, dynamic> json) {
    List<SystemEvent> events = [];
    if (json['system_events'] != null) {
      events = (json['system_events'] as List)
          .map((e) => SystemEvent.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return AIResponse(
      thought: json['thought'] as String?,
      dialogue: json['dialogue'] as String? ?? '',
      systemEvents: events,
      rawResponse: jsonEncode(json),
    );
  }

  /// Create from plain text (Narrative Mode)
  factory AIResponse.fromText(String text) {
    return AIResponse(
      dialogue: text,
      rawResponse: text,
    );
  }
}

/// LLM Service - Handles AI communication
class LLMService {
  LLMService({LLMConfig? config})
      : _config = config ?? LLMConfig.defaultConfig,
        _dio = Dio() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  final LLMConfig _config;
  final Dio _dio;

  /// Update configuration
  void updateConfig(LLMConfig config) {
    // Create new instance with updated config if needed
  }

  /// Get authorization header
  Map<String, String> get _authHeaders => {
        'Authorization': 'Bearer ${_config.apiKey}',
      };

  /// Send a message and get a streaming response (Narrative Mode)
  /// Returns a stream of text chunks for typewriter effect
  Stream<String> streamResponse({
    required List<LLMMessage> messages,
    String? systemPrompt,
  }) async* {
    final allMessages = [
      if (systemPrompt != null)
        LLMMessage(role: LLMRole.system, content: systemPrompt),
      ...messages,
    ];

    try {
      final response = await _dio.post<ResponseBody>(
        '${_config.baseUrl}/chat/completions',
        options: Options(
          headers: _authHeaders,
          responseType: ResponseType.stream,
        ),
        data: {
          'model': _config.model,
          'messages': allMessages.map((m) => m.toJson()).toList(),
          'max_tokens': _config.maxTokens,
          'temperature': _config.temperature,
          'stream': true,
        },
      );

      // Parse SSE stream
      await for (final chunk in _parseSSEStream(response.data!.stream)) {
        yield chunk;
      }
    } on DioException catch (e) {
      yield '[Error: ${e.message}]';
    } catch (e) {
      yield '[Error: $e]';
    }
  }

  /// Parse SSE (Server-Sent Events) stream
  Stream<String> _parseSSEStream(Stream<List<int>> stream) async* {
    String buffer = '';

    await for (final chunk in stream) {
      buffer += utf8.decode(chunk);

      // Split by newlines and process complete events
      while (buffer.contains('\n')) {
        final index = buffer.indexOf('\n');
        final line = buffer.substring(0, index).trim();
        buffer = buffer.substring(index + 1);

        if (line.startsWith('data: ')) {
          final data = line.substring(6);

          if (data == '[DONE]') {
            return;
          }

          try {
            final json = jsonDecode(data) as Map<String, dynamic>;
            final choices = json['choices'] as List?;
            if (choices != null && choices.isNotEmpty) {
              final delta = choices[0]['delta'] as Map<String, dynamic>?;
              final content = delta?['content'] as String?;
              if (content != null) {
                yield content;
              }
            }
          } catch (_) {
            // Skip malformed JSON
          }
        }
      }
    }
  }

  /// Send a message and get a complete response (System Mode)
  /// Returns structured JSON response for game logic
  Future<AIResponse> getResponse({
    required List<LLMMessage> messages,
    String? systemPrompt,
    bool expectJson = true,
  }) async {
    final allMessages = [
      if (systemPrompt != null)
        LLMMessage(role: LLMRole.system, content: _buildSystemPrompt(systemPrompt, expectJson)),
      ...messages,
    ];

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '${_config.baseUrl}/chat/completions',
        options: Options(
          headers: _authHeaders,
        ),
        data: {
          'model': _config.model,
          'messages': allMessages.map((m) => m.toJson()).toList(),
          'max_tokens': _config.maxTokens,
          'temperature': _config.temperature,
          'stream': false,
          if (expectJson) 'response_format': {'type': 'json_object'},
        },
      );

      final choices = response.data?['choices'] as List?;
      if (choices != null && choices.isNotEmpty) {
        final content = choices[0]['message']['content'] as String;

        if (expectJson) {
          try {
            final json = jsonDecode(content) as Map<String, dynamic>;
            return AIResponse.fromJson(json);
          } catch (_) {
            return AIResponse.fromText(content);
          }
        } else {
          return AIResponse.fromText(content);
        }
      }

      return const AIResponse(dialogue: '无法获取响应');
    } on DioException catch (e) {
      return AIResponse(dialogue: '[网络错误: ${e.message}]');
    } catch (e) {
      return AIResponse(dialogue: '[错误: $e]');
    }
  }

  /// Build system prompt with JSON format instructions
  String _buildSystemPrompt(String basePrompt, bool expectJson) {
    if (!expectJson) return basePrompt;

    return '''
$basePrompt

你必须始终以下列JSON格式响应：
{
  "thought": "你的内部思考过程（用户不可见）",
  "dialogue": "你要对用户说的话",
  "system_events": [
    // 可选的系统事件数组，例如：
    // {"type": "point_change", "amount": -10, "reason": "购买物品"}
    // {"type": "update_quest", "quest_id": "q01", "status": "completed"}
    // {"type": "update_affection", "npc_key": "npc01", "value": 5}
  ]
}

确保你的响应是有效的JSON格式。
''';
  }
}

/// Provider for LLM Service
@riverpod
LLMService llmService(Ref ref) {
  // In production, get config from user settings or environment
  return LLMService();
}

/// Provider for LLM Configuration
@riverpod
class LLMConfigNotifier extends _$LLMConfigNotifier {
  @override
  LLMConfig build() {
    return LLMConfig.defaultConfig;
  }

  void updateConfig({
    String? apiKey,
    String? baseUrl,
    String? model,
    int? maxTokens,
    double? temperature,
  }) {
    state = LLMConfig(
      apiKey: apiKey ?? state.apiKey,
      baseUrl: baseUrl ?? state.baseUrl,
      model: model ?? state.model,
      maxTokens: maxTokens ?? state.maxTokens,
      temperature: temperature ?? state.temperature,
    );
  }
}
