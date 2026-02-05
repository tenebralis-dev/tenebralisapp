import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../domain/api_connection.dart';

class LocalConnectionsStore {
  static const boxName = 'connections_local_v1';

  Future<Box<String>> _box() => Hive.openBox<String>(boxName);

  Future<List<LocalApiConnection>> list() async {
    final box = await _box();
    return box.values
        .map((s) => LocalApiConnection.fromJson(
              Map<String, dynamic>.from(jsonDecode(s) as Map),
            ))
        .toList();
  }

  Future<void> upsert(LocalApiConnection c) async {
    final box = await _box();
    await box.put(c.localId, jsonEncode(c.toJson()));
  }

  Future<void> delete(String localId) async {
    final box = await _box();
    await box.delete(localId);
  }

  Future<LocalApiConnection?> get(String localId) async {
    final box = await _box();
    final s = box.get(localId);
    if (s == null) return null;
    return LocalApiConnection.fromJson(
      Map<String, dynamic>.from(jsonDecode(s) as Map),
    );
  }
}
