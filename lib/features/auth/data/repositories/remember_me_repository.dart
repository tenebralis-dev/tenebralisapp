import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Store remembered login credentials securely.
///
/// IMPORTANT: Storing passwords always has risk.
/// We use platform secure storage (KeyStore/Keychain).
class RememberMeRepository {
  RememberMeRepository({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _keyEnabled = 'remember_me.enabled';
  static const _keyEmail = 'remember_me.email';
  static const _keyPassword = 'remember_me.password';

  Future<({bool enabled, String email, String password})> read() async {
    final enabledRaw = await _storage.read(key: _keyEnabled);
    final enabled = enabledRaw == 'true';

    final email = await _storage.read(key: _keyEmail) ?? '';
    final password = await _storage.read(key: _keyPassword) ?? '';

    return (enabled: enabled, email: email, password: password);
  }

  Future<void> setEnabled(bool enabled) async {
    await _storage.write(key: _keyEnabled, value: enabled ? 'true' : 'false');
    if (!enabled) {
      // Clear credentials when disabled.
      await clearCredentials();
    }
  }

  Future<void> saveCredentials({required String email, required String password}) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<void> clearCredentials() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPassword);
  }
}

final rememberMeRepositoryProvider = Provider<RememberMeRepository>((ref) {
  return RememberMeRepository();
});
