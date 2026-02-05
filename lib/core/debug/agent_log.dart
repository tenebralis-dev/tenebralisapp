import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgentLog {

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

      // Print NDJSON to stdout/logcat so it works on real devices.
      debugPrint(jsonEncode(payload));
    } catch (_) {
      // ignore
    }
  }
}
