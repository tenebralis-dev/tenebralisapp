import 'package:freezed_annotation/freezed_annotation.dart';

/// Model mapping conventions for Supabase/Postgres.
///
/// Goals:
/// - Database columns are `snake_case`.
/// - Dart fields are `camelCase`.
/// - Use `@JsonKey(name: '...')` for explicit mapping.
/// - For JSONB columns, use `Object?`/`Map<String, dynamic>` then convert defensively
///   (see `ProfileModel` helpers).
/// - For enum columns with CHECK constraints, use `@JsonValue('db_value')`.
///
/// This file is intentionally tiny and code-based (not a markdown doc), so that
/// the conventions live close to the code.
///
/// Copy/paste template:
///
/// ```dart
/// @freezed
/// class ExampleModel with _$ExampleModel {
///   const factory ExampleModel({
///     required String id,
///     @JsonKey(name: 'user_id') required String userId,
///     @JsonKey(name: 'created_at') DateTime? createdAt,
///     @JsonKey(name: 'updated_at') DateTime? updatedAt,
///   }) = _ExampleModel;
///
///   factory ExampleModel.fromJson(Map<String, dynamic> json) =>
///       _$ExampleModelFromJson(json);
/// }
/// ```
const modelMappingConventions = _ModelMappingConventions();

class _ModelMappingConventions {
  const _ModelMappingConventions();

  /// Common snake_case column names used across tables.
  ///
  /// Prefer referencing these in model annotations to reduce typos.
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
  static const userId = 'user_id';
  static const worldId = 'world_id';
  static const saveId = 'save_id';
}
