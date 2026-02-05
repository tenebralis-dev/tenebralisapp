import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';

part 'auth_repository.g.dart';

/// Auth Repository
/// Handles authentication operations
class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  /// Get current user
  User? get currentUser => _client.auth.currentUser;

  /// Get current session
  Session? get currentSession => _client.auth.currentSession;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Auth state changes stream
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  ///
  /// Note: Whether Supabase sends a magic link or an OTP code depends on
  /// project Auth settings (Email provider configuration).
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Verify email OTP code
  Future<AuthResponse> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    return await _client.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.email,
    );
  }

  /// Sign in with OAuth provider
  Future<bool> signInWithOAuth(OAuthProvider provider) async {
    return await _client.auth.signInWithOAuth(provider);
  }

  /// Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  /// Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  /// Update email
  Future<UserResponse> updateEmail(String newEmail) async {
    return await _client.auth.updateUser(
      UserAttributes(email: newEmail),
    );
  }

  /// Refresh session
  Future<AuthResponse> refreshSession() async {
    return await _client.auth.refreshSession();
  }
}

/// Provider for AuthRepository
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(SupabaseService.client);
}

/// Provider for current user
@riverpod
User? currentUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.currentUser;
}

/// Provider for auth state
@riverpod
Stream<AuthState> authState(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

/// Provider for authentication status
@riverpod
bool isAuthenticated(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.isAuthenticated;
}
