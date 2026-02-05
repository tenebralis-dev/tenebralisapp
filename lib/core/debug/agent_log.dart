import 'dart:convert';

import 'dart:io';

import 'package:flutter/foundation.dart';

class AgentLog {
  static const _logPath = r'c:\dev\tenebralisapp\.cursor\debug.log';

  static void log({
    required String sessionId,
    required String runId,
    required String hypothesisId,
    required String location,
    required String message,
    Map<String, Object?> data = const {},
  }) {
    try {
      final payload = <String, Object?>{
        'sessionId': sessionId,
        'runId': runId,
        'hypothesisId': hypothesisId,
        'location': location,
        'message': message,
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      final line = '${jsonEncode(payload)}\n';

      // Always print to stdout/logcat.
      debugPrint(line);

      // Also append to a file when possible.
      // NOTE: On Android/iOS sandbox, writing to Windows path will fail.
      // We keep stdout logging as the primary channel.
      try {
        final f = File(_logPath);
        f.parent.createSync(recursive: true);
        f.writeAsStringSync(line, mode: FileMode.append, flush: true);
      } catch (_) {}
    } catch (_) {
      // ignore
    }
  }
}
