import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment Configuration (runtime .env)
///
/// NOTE:
/// - Flutter does NOT auto-load `.env`.
/// - Call `EnvConfig.load()` before using any values.
class EnvConfig {
  EnvConfig._();

  static const String _missing = '__MISSING__';

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? _missing;
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? _missing;

  /// Optional: used later by AI features.
  static String? get llmApiKey => dotenv.env['LLM_API_KEY'];

  static bool get isSupabaseConfigured =>
      supabaseUrl != _missing && supabaseAnonKey != _missing;

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}
