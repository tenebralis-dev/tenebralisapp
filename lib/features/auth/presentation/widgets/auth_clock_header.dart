import 'dart:async';

import 'package:flutter/material.dart';

/// A lock-screen like clock header for the auth page.
/// Uses Material text styles + tabular numerals.
class AuthClockHeader extends StatefulWidget {
  const AuthClockHeader({super.key});

  @override
  State<AuthClockHeader> createState() => _AuthClockHeaderState();
}

class _AuthClockHeaderState extends State<AuthClockHeader> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  String _formatTime(DateTime d) => '${_two(d.hour)}:${_two(d.minute)}';

  String _formatDate(DateTime d) {
    const weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final mm = _two(d.month);
    final dd = _two(d.day);
    final w = weeks[(d.weekday - 1).clamp(0, 6)];
    return '$mm/$dd $w';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          _formatTime(_now),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w300,
                color: scheme.onSurface.withValues(alpha: 0.92),
                height: 0.92,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          _formatDate(_now),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.72),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
        ),
      ],
    );
  }
}
