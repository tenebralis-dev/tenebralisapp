import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthUiState with _$AuthUiState {
  const factory AuthUiState({
    @Default(false) bool isLoading,
    String? errorMessage,

    /// Current authenticated user (Supabase).
    ///
    /// Optional: the app can work in offline/demo mode.
    User? user,
  }) = _AuthUiState;
}
