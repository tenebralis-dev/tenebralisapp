import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../domain/api_connection.dart';

class CloudConnectionsCache {
  static const boxName = 'connections_cloud_cache_v1';

  Future<Box<String>> _box() => Hive.openBox<String>(boxName);

  Future<List<CloudApiConnection>> list() async {
    final box = await _box();
    return box.values
        .map((s) => CloudApiConnection.fromJson(
              Map<String, dynamic>.from(jsonDecode(s) as Map),
            ))
        .toList();
  }

  Future<void> putAll(List<CloudApiConnection> connections) async {
    final box = await _box();
    final map = <String, String>{
      for (final c in connections) c.id: jsonEncode(c.toJson()),
    };
    await box.putAll(map);
  }

  Future<void> upsert(CloudApiConnection c) async {
    final box = await _box();
    await box.put(c.id, jsonEncode(c.toJson()));
  }

  Future<void> delete(String id) async {
    final box = await _box();
    await box.delete(id);
  }

  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }
}
