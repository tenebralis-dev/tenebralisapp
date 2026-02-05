import 'package:dio/dio.dart';

import '../domain/api_connection.dart';

class ConnectionTester {
  ConnectionTester({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<({String? model, int latency})> test({
    required ApiConnectionBase base,
    required String apiKey,
  }) async {
    final key = apiKey.trim();
    if (key.isEmpty) throw Exception('密钥为空');

    final baseUrl = _normalizeBaseUrl(base.baseUrl);

    // Default to chat completions test for openai-compatible services.
    // For other service types, still attempt a generic /v1/chat/completions if user config says so.
    final endpoint = '$baseUrl/v1/chat/completions';

    final headers = <String, dynamic>{
      'content-type': 'application/json',
      'authorization': 'Bearer $key',
    };

    // Merge header templates (non-sensitive) but do not allow overwriting auth.
    for (final entry in base.headersTemplate.entries) {
      final k = entry.key;
      if (k.toLowerCase() == 'authorization' || k.toLowerCase() == 'x-api-key') {
        continue;
      }
      headers[k] = entry.value;
    }

    final data = <String, dynamic>{
      'model': base.defaultModel ?? 'gpt-4o-mini',
      'messages': const [
        {'role': 'user', 'content': 'test'},
      ],
      'max_tokens': 10,
      'temperature': 0,
      'stream': false,
      ...base.params,
    };

    final sw = Stopwatch()..start();

    try {
      final resp = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );

      sw.stop();
      if ((resp.statusCode ?? 500) >= 400) {
        throw Exception('服务返回异常状态码：${resp.statusCode}');
      }

      final model = resp.data?['model'] as String?;
      return (model: model, latency: sw.elapsedMilliseconds);
    } on DioException catch (e) {
      sw.stop();
      throw Exception(_dioErrorToMessage(e));
    }
  }

  String _normalizeBaseUrl(String input) {
    var url = input.trim();
    if (url.endsWith('/')) url = url.substring(0, url.length - 1);
    // Accept both https://host and https://host/v1. Normalize to https://host
    if (url.endsWith('/v1')) url = url.substring(0, url.length - 3);
    return url;
  }

  String _dioErrorToMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final err = data['error'];
      if (err is Map) {
        final msg = err['message'];
        if (msg is String && msg.isNotEmpty) return msg;
      }
      final msg = data['message'];
      if (msg is String && msg.isNotEmpty) return msg;
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return '请求超时：请检查网络或端点可用性。';
    }

    return e.message ?? '未知网络异常。';
  }
}
