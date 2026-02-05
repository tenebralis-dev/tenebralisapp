import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/supabase_service.dart';
import '../domain/api_connection.dart';

class CloudConnectionsRepository {
  CloudConnectionsRepository(this._client);

  final SupabaseClient _client;

  Future<List<CloudApiConnection>> list() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];

    final rows = await _client
        .from('api_connections')
        .select('*')
        .order('is_active', ascending: false)
        .order('updated_at', ascending: false);

    return (rows as List)
        .map((r) => _fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  Future<CloudApiConnection> create({required ApiConnectionBase base}) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('未登录，无法创建云端连接');
    }

    final row = await _client
        .from('api_connections')
        .insert(_toInsertJson(userId: user.id, base: base))
        .select('*')
        .single();

    return _fromRow(Map<String, dynamic>.from(row));
  }

  Future<CloudApiConnection> update({
    required String id,
    required ApiConnectionBase base,
  }) async {
    final row = await _client
        .from('api_connections')
        .update(_toUpdateJson(base))
        .eq('id', id)
        .select('*')
        .single();

    return _fromRow(Map<String, dynamic>.from(row));
  }

  Future<void> delete(String id) async {
    await _client.from('api_connections').delete().eq('id', id);
  }

  Map<String, dynamic> _toInsertJson({
    required String userId,
    required ApiConnectionBase base,
  }) {
    return {
      'user_id': userId,
      ..._toUpdateJson(base),
    };
  }

  Map<String, dynamic> _toUpdateJson(ApiConnectionBase base) {
    return {
      'name': base.name,
      'service_type': _serviceTypeToDb(base.serviceType),
      'base_url': base.baseUrl,
      'is_active': base.isActive,
      'default_model': base.defaultModel,
      'system_prompt': base.systemPrompt,
      'params_json': base.params,
      'headers_template_json': base.headersTemplate,
      'config_json': base.config,
    };
  }

  CloudApiConnection _fromRow(Map<String, dynamic> row) {
    final base = ApiConnectionBase(
      name: row['name'] as String? ?? '连接',
      serviceType: _serviceTypeFromDb(row['service_type'] as String?),
      baseUrl: row['base_url'] as String? ?? '',
      isActive: row['is_active'] as bool? ?? true,
      defaultModel: row['default_model'] as String?,
      systemPrompt: row['system_prompt'] as String?,
      params: Map<String, dynamic>.from(row['params_json'] as Map? ?? const {}),
      headersTemplate:
          Map<String, dynamic>.from(row['headers_template_json'] as Map? ?? const {}),
      config: Map<String, dynamic>.from(row['config_json'] as Map? ?? const {}),
      updatedAt: _parseTime(row['updated_at']),
    );

    return CloudApiConnection(
      id: row['id'] as String,
      userId: row['user_id'] as String,
      base: base,
      createdAt: _parseTime(row['created_at']),
      updatedAt: _parseTime(row['updated_at']),
    );
  }

  DateTime? _parseTime(dynamic v) {
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  String _serviceTypeToDb(ApiServiceType t) {
    return switch (t) {
      ApiServiceType.openaiCompat => 'openai_compat',
      ApiServiceType.stt => 'stt',
      ApiServiceType.tts => 'tts',
      ApiServiceType.image => 'image',
      ApiServiceType.custom => 'custom',
    };
  }

  ApiServiceType _serviceTypeFromDb(String? v) {
    return switch (v) {
      'openai_compat' => ApiServiceType.openaiCompat,
      'stt' => ApiServiceType.stt,
      'tts' => ApiServiceType.tts,
      'image' => ApiServiceType.image,
      'custom' => ApiServiceType.custom,
      _ => ApiServiceType.openaiCompat,
    };
  }
}

final cloudConnectionsRepositoryProvider = Provider<CloudConnectionsRepository>(
  (ref) => CloudConnectionsRepository(SupabaseService.client),
);
