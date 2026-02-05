import 'dart:ui';

import 'package:flutter/material.dart';

/// Chat Input Widget
class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
    this.hintText = '输入消息...',
  });

  final TextEditingController controller;
  final void Function(String text) onSend;
  final bool isLoading;
  final String hintText;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSend() {
    if (widget.controller.text.trim().isNotEmpty && !widget.isLoading) {
      widget.onSend(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Quick Actions Button
            _ActionButton(
              icon: Icons.add,
              onTap: () {
                // TODO: Show quick actions menu
              },
            ),
            const SizedBox(width: 8),

            // Text Input
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text Field
                        Expanded(
                          child: TextField(
                            controller: widget.controller,
                            maxLines: 4,
                            minLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: TextStyle(
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _handleSend(),
                          ),
                        ),

                        // Emoji Button
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: _ActionButton(
                            icon: Icons.emoji_emotions_outlined,
                            size: 36,
                            onTap: () {
                              // TODO: Show emoji picker
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Send Button
            _SendButton(
              hasText: _hasText,
              isLoading: widget.isLoading,
              onTap: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}

/// Action Button (+ and emoji)
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onTap,
    this.size = 44,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white70,
          size: size * 0.5,
        ),
      ),
    );
  }
}

/// Send Button with animation
class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.hasText,
    required this.isLoading,
    required this.onTap,
  });

  final bool hasText;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (hasText && !isLoading) ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: (hasText && !isLoading)
              ? const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)],
                )
              : null,
          color: (hasText && !isLoading)
              ? null
              : Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          boxShadow: (hasText && !isLoading)
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white70,
                ),
              )
            : Icon(
                Icons.send,
                color: hasText ? Colors.white : Colors.white38,
                size: 20,
              ),
      ),
    );
  }
}

/// Quick Actions Menu
class QuickActionsMenu extends StatelessWidget {
  const QuickActionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(icon: Icons.image, label: '图片', onTap: () {}),
      _QuickAction(icon: Icons.mic, label: '语音', onTap: () {}),
      _QuickAction(icon: Icons.camera_alt, label: '相机', onTap: () {}),
      _QuickAction(icon: Icons.location_on, label: '位置', onTap: () {}),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: actions,
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
