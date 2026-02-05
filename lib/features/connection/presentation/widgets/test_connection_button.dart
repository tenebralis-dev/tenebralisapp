import 'package:flutter/material.dart';

class TestConnectionButton extends StatelessWidget {
  const TestConnectionButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.bolt_outlined),
        label: Text(isLoading ? '验证中…' : '验证神经通路'),
      ),
    );
  }
}
