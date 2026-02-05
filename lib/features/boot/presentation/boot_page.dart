import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart' show AppRoutes;

/// Boot page: title fades in, subtitle types like a terminal,
/// then automatically navigates to OS home.
class BootPage extends StatefulWidget {
  const BootPage({super.key});

  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  static const _title = 'Tenebralis Dream System';
  static const _subtitleFull = r'> boot: initializing Dream OS...';

  Timer? _typingTimer;
  Timer? _navTimer;
  int _typedCount = 0;

  @override
  void initState() {
    super.initState();

    // Start a terminal-like typing effect.
    _typingTimer = Timer.periodic(const Duration(milliseconds: 45), (timer) {
      if (!mounted) return;

      setState(() {
        _typedCount = (_typedCount + 1).clamp(0, _subtitleFull.length);
      });

      if (_typedCount >= _subtitleFull.length) {
        timer.cancel();
      }
    });

    // Auto navigate after ~2.6s (within requested 2–3 seconds).
    _navTimer = Timer(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      context.go(AppRoutes.osHome);
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.background;

    final subtitle = _subtitleFull.substring(0, _typedCount);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                )
                    .animate()
                    .fadeIn(duration: 650.ms, curve: Curves.easeOut)
                    .slideY(begin: 0.08, end: 0, curve: Curves.easeOut),
                const SizedBox(height: 14),
                _TerminalLine(
                  text: subtitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TerminalLine extends StatelessWidget {
  const _TerminalLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF9FE7FF),
            fontFamily: 'monospace',
            letterSpacing: 0.2,
          ) ??
          const TextStyle(
            color: Color(0xFF9FE7FF),
            fontFamily: 'monospace',
            fontSize: 16,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Cursor blink
          const Text('▌')
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 350.ms)
              .fadeOut(duration: 350.ms),
        ],
      ),
    );
  }
}
