import 'package:dio/dio.dart';

import '../domain/api_connection.dart';

/// Fetch model list from a connection.
///
/// - For OpenAI-compatible endpoints, it tries GET {baseUrl}/v1/models.
/// - Users can override with `base.config['models_endpoint']`.
///   - If it starts with http(s), it is treated as absolute.
///   - Otherwise it is treated as relative to normalized baseUrl.
class ModelsFetcher {
  ModelsFetcher({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<List<String>> fetch({
    required ApiConnectionBase base,
    required String apiKey,
  }) async {
    final key = apiKey.trim();
    if (key.isEmpty) throw Exception('密钥为空');

    final baseUrl = _normalizeBaseUrl(base.baseUrl);

    final endpoint = _resolveEndpoint(baseUrl, base.config['models_endpoint']);

    final headers = <String, dynamic>{
      'content-type': 'application/json',
      'authorization': 'Bearer $key',
    };

    // Merge header templates (non-sensitive) but do not allow overwriting auth.
    for (final entry in base.headersTemplate.entries) {
      final k = entry.key;
      final lk = k.toLowerCase();
      if (lk == 'authorization' || lk == 'x-api-key') continue;
      headers[k] = entry.value;
    }

    try {
      final resp = await _dio.get<dynamic>(
        endpoint,
        options: Options(headers: headers, responseType: ResponseType.json),
      );

      if ((resp.statusCode ?? 500) >= 400) {
        throw Exception('服务返回异常状态码：${resp.statusCode}');
      }

      final data = resp.data;

      // OpenAI format: { object: 'list', data: [ {id: 'gpt-4o', ...}, ... ] }
      if (data is Map) {
        final list = data['data'];
        if (list is List) {
          final ids = <String>[];
          for (final item in list) {
            if (item is Map) {
              final id = item['id'];
              if (id is String && id.trim().isNotEmpty) ids.add(id.trim());
            }
          }
          return ids..sort();
        }

        // Alternative format: { models: ['a','b'] }
        final models = data['models'];
        if (models is List) {
          final ids = models
              .whereType<String>()
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList()
            ..sort();
          return ids;
        }
      }

      // Fallback: list of strings.
      if (data is List) {
        final ids = data
            .whereType<String>()
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList()
          ..sort();
        return ids;
      }

      throw Exception('无法解析 models 返回格式');
    } on DioException catch (e) {
      throw Exception(e.message ?? '网络异常');
    }
  }

  String _normalizeBaseUrl(String input) {
    var url = input.trim();
    if (url.endsWith('/')) url = url.substring(0, url.length - 1);
    // Accept both https://host and https://host/v1. Normalize to https://host
    if (url.endsWith('/v1')) url = url.substring(0, url.length - 3);
    return url;
  }

  String _resolveEndpoint(String normalizedBaseUrl, Object? override) {
    final v = override is String ? override.trim() : '';
    if (v.isNotEmpty) {
      if (v.startsWith('http://') || v.startsWith('https://')) return v;
      if (v.startsWith('/')) return '$normalizedBaseUrl$v';
      return '$normalizedBaseUrl/$v';
    }

    return '$normalizedBaseUrl/v1/models';
  }
}
