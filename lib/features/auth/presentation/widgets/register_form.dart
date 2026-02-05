import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/strings.dart';
import '../controllers/auth_controller.dart';
import 'auth_pill_text_field.dart';
import 'auth_sticker_error.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _showOtpStep = false;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _otpError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    final email = value.trim();
    final reg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return reg.hasMatch(email);
  }

  void _validateInline(AppStrings s) {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _emailError = email.isEmpty
          ? s.enterEmailError
          : (!_isValidEmail(email) ? s.invalidEmailError : null);
      _passwordError = password.isEmpty
          ? s.enterPasswordError
          : (password.length < 6 ? s.passwordMinError : null);
      _confirmPasswordError = confirmPassword.isEmpty
          ? s.confirmPasswordError
          : (confirmPassword != password ? s.passwordNotMatchError : null);
    });
  }

  void _validateOtpInline(AppStrings s) {
    final token = _otpController.text.trim();

    setState(() {
      _otpError = token.isEmpty
          ? s.enterOtpError
          : (token.length < 6 ? s.otpLengthError : null);
    });
  }

  Future<void> _submitRegister() async {
    final s = ref.read(stringsProvider);
    _validateInline(s);
    if (_emailError != null || _passwordError != null || _confirmPasswordError != null) {
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authControllerProvider.notifier);

    try {
      await notifier.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      setState(() {
        _showOtpStep = true;
        _otpError = null;
      });
    } catch (_) {
      // state.errorMessage will be shown inline
    }
  }

  Future<void> _submitVerifyOtp() async {
    final s = ref.read(stringsProvider);
    _validateOtpInline(s);
    if (_otpError != null) return;

    final notifier = ref.read(authControllerProvider.notifier);

    try {
      await notifier.verifyEmailOtp(
        email: _emailController.text.trim(),
        token: _otpController.text.trim(),
      );
      if (!mounted) return;
      context.go(AppRoutes.osHome);
    } catch (_) {
      // state.errorMessage will be shown inline
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    final scheme = Theme.of(context).colorScheme;
    final s = ref.watch(stringsProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _showOtpStep ? s.emailVerifyTitle : s.createAccount,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AuthPillTextField(
            controller: _emailController,
            label: s.emailLabel,
            placeholder: s.emailPlaceholder,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            onChanged: (_) => _validateInline(s),
            validator: (v) {
              final value = (v ?? '').trim();
              if (value.isEmpty) return s.enterEmailError;
              if (!_isValidEmail(value)) return s.invalidEmailError;
              return null;
            },
            enabled: !auth.isLoading,
          ),
          const SizedBox(height: 16),
          if (!_showOtpStep) ...[
            AuthPillTextField(
              controller: _passwordController,
              label: s.passwordLabel,
              placeholder: s.passwordPlaceholder,
              prefixIcon: Icons.lock_outline,
              obscureText: !_passwordVisible,
              suffixIcon: IconButton(
                tooltip: _passwordVisible ? s.hidePassword : s.showPassword,
                onPressed: auth.isLoading
                    ? null
                    : () => setState(() => _passwordVisible = !_passwordVisible),
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              onChanged: (_) => _validateInline(s),
              validator: (v) {
                final value = v ?? '';
                if (value.isEmpty) return s.enterPasswordError;
                if (value.length < 6) return s.passwordMinError;
                return null;
              },
              enabled: !auth.isLoading,
            ),
            const SizedBox(height: 16),
            AuthPillTextField(
              controller: _confirmPasswordController,
              label: s.confirmPasswordLabel,
              placeholder: s.confirmPasswordPlaceholder,
              prefixIcon: Icons.lock_outline,
              obscureText: !_confirmPasswordVisible,
              suffixIcon: IconButton(
                tooltip: _confirmPasswordVisible ? s.hidePassword : s.showPassword,
                onPressed: auth.isLoading
                    ? null
                    : () => setState(
                          () => _confirmPasswordVisible = !_confirmPasswordVisible,
                        ),
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              onChanged: (_) => _validateInline(s),
              validator: (v) {
                final value = v ?? '';
                if (value.isEmpty) return s.confirmPasswordError;
                if (value != _passwordController.text) return s.passwordNotMatchError;
                return null;
              },
              enabled: !auth.isLoading,
            ),
            if (auth.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                auth.errorMessage!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: auth.isLoading ? null : _submitRegister,
              child: auth.isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: scheme.onPrimary,
                      ),
                    )
                  : Text(s.registerAndSendOtp),
            ),
          ] else ...[
            Text(
              s.otpSentHint,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            AuthPillTextField(
              controller: _otpController,
              label: s.otpLabel,
              placeholder: s.otpPlaceholder,
              prefixIcon: Icons.verified_outlined,
              keyboardType: TextInputType.number,
              onChanged: (_) => _validateOtpInline(s),
              enabled: !auth.isLoading,
              validator: (_) => null,
            ),
            if (_otpError != null) ...[
              const SizedBox(height: 12),
              Text(
                _otpError!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.error),
              ),
            ],
            if (auth.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                auth.errorMessage!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: auth.isLoading ? null : _submitVerifyOtp,
              child: auth.isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: scheme.onPrimary,
                      ),
                    )
                  : Text(s.verifyAndEnter),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: auth.isLoading
                  ? null
                  : () {
                      setState(() {
                        _showOtpStep = false;
                        _otpController.clear();
                        _otpError = null;
                      });
                    },
              child: Text(s.backToEditEmailPassword),
            ),
          ],
        ],
      ),
    );
  }
}
