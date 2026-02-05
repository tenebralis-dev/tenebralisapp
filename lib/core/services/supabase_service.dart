import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env_config.dart';

part 'supabase_service.g.dart';

/// Supabase Service for database and auth operations
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase
  static Future<void> initialize() async {
    if (!EnvConfig.isSupabaseConfigured) {
      // Skip initialization if not configured
      // App will work in offline/demo mode
      return;
    }

    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }

  /// Check if Supabase is initialized
  static bool get isInitialized {
    try {
      Supabase.instance;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get current user
  static User? get currentUser => client.auth.currentUser;

  /// Get current session
  static Session? get currentSession => client.auth.currentSession;

  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;

  /// Auth state changes stream
  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  /// Sign in with email and password
  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Sign out
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Get data from a table
  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final response = await client.from(table).select();
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get data by ID
  static Future<Map<String, dynamic>?> getById(String table, String id) async {
    final response =
        await client.from(table).select().eq('id', id).maybeSingle();
    return response;
  }

  /// Insert data
  static Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).insert(data).select().single();
    return response;
  }

  /// Update data
  static Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response =
        await client.from(table).update(data).eq('id', id).select().single();
    return response;
  }

  /// Delete data
  static Future<void> delete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }

  /// Real-time subscription
  static RealtimeChannel subscribe(
    String table, {
    required void Function(Map<String, dynamic> payload) onInsert,
    void Function(Map<String, dynamic> payload)? onUpdate,
    void Function(Map<String, dynamic> payload)? onDelete,
  }) {
    return client
        .channel('public:$table')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: table,
          callback: (payload) => onInsert(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: table,
          callback: (payload) => onUpdate?.call(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: table,
          callback: (payload) => onDelete?.call(payload.oldRecord),
        )
        .subscribe();
  }
}

/// Provider for Supabase client
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return SupabaseService.client;
}

/// Provider for current user
@riverpod
User? currentUser(Ref ref) {
  return SupabaseService.currentUser;
}

/// Provider for auth state changes
@riverpod
Stream<AuthState> authStateChanges(Ref ref) {
  return SupabaseService.authStateChanges;
}
