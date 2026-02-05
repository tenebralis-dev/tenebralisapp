import 'package:flutter/material.dart';

/// A candy-like Material elevated button with subtle highlight.
class AuthGummyButton extends StatelessWidget {
  const AuthGummyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ).copyWith(
          // Slight gradient-ish effect via overlay colors.
          overlayColor: WidgetStatePropertyAll(
            scheme.onPrimary.withValues(alpha: 0.08),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // highlight
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.26),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.62],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null) ...[
                          leading!,
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
