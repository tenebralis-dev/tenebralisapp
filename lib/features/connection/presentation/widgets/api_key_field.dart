import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApiKeyField extends StatelessWidget {
  const ApiKeyField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleObscure,
    required this.onCopy,
    required this.onClear,
  });

  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleObscure;
  final VoidCallback onCopy;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        fontFamily: 'monospace',
        letterSpacing: 0.2,
      ),
      decoration: InputDecoration(
        labelText: '密钥',
        hintText: 'sk-ant-…',
        prefixIcon: const Icon(Icons.key_outlined),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: obscureText ? '显示密钥' : '隐藏密钥',
              onPressed: onToggleObscure,
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            IconButton(
              tooltip: '复制',
              onPressed: onCopy,
              icon: const Icon(Icons.copy_outlined),
            ),
            IconButton(
              tooltip: '清除',
              onPressed: onClear,
              icon: const Icon(Icons.backspace_outlined),
            ),
          ],
        ),
      ),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
    );
  }
}
