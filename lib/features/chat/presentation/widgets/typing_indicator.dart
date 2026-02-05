import 'package:flutter/material.dart';

/// Typing Indicator Widget
/// Shows when the AI is "typing" a response
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start animations with staggered delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Avatar placeholder
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00D9FF), Color(0xFF00BCD4)],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
          ),

          // Typing Dots
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Container(
                      margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
                      child: Transform.translate(
                        offset: Offset(0, -4 * _animations[index].value),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              Colors.white38,
                              const Color(0xFF00D9FF),
                              _animations[index].value,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/// Alternative: Linear typing indicator
class LinearTypingIndicator extends StatefulWidget {
  const LinearTypingIndicator({super.key});

  @override
  State<LinearTypingIndicator> createState() => _LinearTypingIndicatorState();
}

class _LinearTypingIndicatorState extends State<LinearTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text(
            '向导正在输入',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 20,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final dots = '.' * ((_controller.value * 3).floor() + 1);
                return Text(
                  dots.padRight(3),
                  style: const TextStyle(
                    color: Color(0xFF00D9FF),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
