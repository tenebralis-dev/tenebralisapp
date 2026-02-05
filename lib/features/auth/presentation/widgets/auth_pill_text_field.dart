import 'package:flutter/material.dart';

/// A pill-shaped Material 3 text field wrapper.
///
/// NOTE: still uses standard `TextFormField` + `InputDecoration`.
class AuthPillTextField extends StatelessWidget {
  const AuthPillTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    this.keyboardType,
    this.autofillHints,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.65),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: scheme.outlineVariant,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: scheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
