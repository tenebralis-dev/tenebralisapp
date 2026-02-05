import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConnectionSecretsStore {
  ConnectionSecretsStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static String _key(String ref) => 'apiKey:$ref';

  Future<String?> readApiKey(String ref) => _storage.read(key: _key(ref));

  Future<void> writeApiKey(String ref, String value) =>
      _storage.write(key: _key(ref), value: value);

  Future<void> deleteApiKey(String ref) => _storage.delete(key: _key(ref));

  Future<void> copyApiKey({required String fromRef, required String toRef}) async {
    final v = await readApiKey(fromRef);
    if (v == null || v.trim().isEmpty) return;
    await writeApiKey(toRef, v);
  }
}
