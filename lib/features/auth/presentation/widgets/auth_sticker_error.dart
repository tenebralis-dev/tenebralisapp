import 'package:flutter/material.dart';

class AuthStickerError extends StatelessWidget {
  const AuthStickerError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.error.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 8),
            color: scheme.error.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onErrorContainer,
              fontWeight: FontWeight.w600,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
