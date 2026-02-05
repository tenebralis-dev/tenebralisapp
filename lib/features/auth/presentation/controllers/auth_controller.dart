import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late AuthRepository _repo;

  @override
  AuthUiState build() {
    _repo = ref.watch(authRepositoryProvider);
    return AuthUiState(user: _repo.currentUser);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, user: null);

    try {
      await _repo.signInWithEmail(email: email, password: password);
      state = state.copyWith(user: _repo.currentUser);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _mapAuthError(e));
      rethrow;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }

    state = state.copyWith(isLoading: false, errorMessage: null);
  }

  /// Register request.
  ///
  /// This will trigger Supabase to send a verification email.
  /// If your project is configured for Email OTP, it will send a code.
  /// If configured for Magic Link, it will send a link.
  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, user: null);

    try {
      await _repo.signUpWithEmail(email: email, password: password);
      state = state.copyWith(user: _repo.currentUser);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _mapAuthError(e));
      rethrow;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }

    state = state.copyWith(isLoading: false, errorMessage: null);
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, user: null);

    try {
      await _repo.verifyEmailOtp(email: email, token: token);
      state = state.copyWith(user: _repo.currentUser);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _mapAuthError(e));
      rethrow;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }

    state = state.copyWith(isLoading: false, errorMessage: null);
  }

  String _mapAuthError(AuthException e) {
    final msg = e.message;

    // Keep mapping small but useful.
    if (msg.toLowerCase().contains('invalid login')) {
      return '邮箱或密码错误';
    }
    if (msg.toLowerCase().contains('email')) {
      return msg;
    }
    if (msg.toLowerCase().contains('password')) {
      return msg;
    }

    return msg;
  }
}
