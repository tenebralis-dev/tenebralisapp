import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/strings.dart';
import '../../data/repositories/remember_me_repository.dart';
import '../controllers/auth_controller.dart';
import 'auth_gummy_button.dart';
import 'auth_pill_text_field.dart';
import 'auth_sticker_error.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;

  bool _rememberMe = false;
  bool _loadedRemembered = false;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _loadRemembered();
  }

  Future<void> _loadRemembered() async {
    try {
      final repo = ref.read(rememberMeRepositoryProvider);
      final data = await repo.read();
      if (!mounted) return;

      setState(() {
        _rememberMe = data.enabled;
        if (data.enabled) {
          _emailController.text = data.email;
          _passwordController.text = data.password;
        }
        _loadedRemembered = true;
      });
    } catch (_) {
      // ignore
      if (!mounted) return;
      setState(() => _loadedRemembered = true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

    setState(() {
      _emailError = email.isEmpty
          ? s.enterEmailError
          : (!_isValidEmail(email) ? s.invalidEmailError : null);
      _passwordError = password.isEmpty
          ? s.enterPasswordError
          : (password.length < 6 ? s.passwordMinError : null);
    });
  }

  Future<void> _submit() async {
    final s = ref.read(stringsProvider);
    _validateInline(s);
    if (_emailError != null || _passwordError != null) return;
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authControllerProvider.notifier);
    final rememberRepo = ref.read(rememberMeRepositoryProvider);

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      await notifier.login(
        email: email,
        password: password,
      );

      // Persist remember-me
      await rememberRepo.setEnabled(_rememberMe);
      if (_rememberMe) {
        await rememberRepo.saveCredentials(email: email, password: password);
      }

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
            s.loginAccountTitle,
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
          AuthPillTextField(
            controller: _passwordController,
            label: s.passwordLabel,
            placeholder: s.passwordPlaceholder,
            prefixIcon: Icons.lock_outline,
            obscureText: !_passwordVisible,
            suffixIcon: IconButton(
              tooltip: _passwordVisible ? s.hidePassword : s.showPassword,
              onPressed:
                  auth.isLoading ? null : () => setState(() => _passwordVisible = !_passwordVisible),
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
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: auth.isLoading
                    ? null
                    : (v) {
                        setState(() => _rememberMe = v ?? false);
                      },
              ),
              Expanded(
                child: Text(
                  s.rememberMe,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              if (!_loadedRemembered)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
            ],
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
            onPressed: auth.isLoading ? null : _submit,
            child: auth.isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: scheme.onPrimary,
                    ),
                  )
                : Text(s.enterSystem),
          ),
          const SizedBox(height: 12),
          Text(
            s.continueHint,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
