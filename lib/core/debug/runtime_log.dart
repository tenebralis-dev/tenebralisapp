import 'dart:convert';
import 'dart:io';

/// Tiny runtime logger for Debug mode (writes NDJSON).
///
/// IMPORTANT: do not log secrets/PII.
class RuntimeLog {
  static const String _logPath = r'c:\dev\tenebralisapp\.cursor\debug.log';
  static const String _androidFallback = '.cursor/debug.log';

  static void log({
    required String hypothesisId,
    required String location,
    required String message,
    Map<String, Object?> data = const {},
    String sessionId = 'debug-session',
    String runId = 'run1',
  }) {
    try {
      final line = jsonEncode({
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'sessionId': sessionId,
        'runId': runId,
        'hypothesisId': hypothesisId,
        'location': location,
        'message': message,
        'data': data,
      });
      try {
        File(_logPath).writeAsStringSync('$line\n', mode: FileMode.append);
      } catch (_) {
        // Android sandbox: fallback to app documents dir.
        File(_androidFallback)
            .writeAsStringSync('$line\n', mode: FileMode.append);
      }
    } catch (_) {
      // swallow
    }
  }
}
