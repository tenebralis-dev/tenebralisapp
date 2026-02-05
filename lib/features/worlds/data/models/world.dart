import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/model_mapping_conventions.dart';

part 'world.freezed.dart';
part 'world.g.dart';

// JsonKey(name: ...) 需要编译期常量。
// 这里直接用字符串字面量，避免引用非 public 类型导致的 "Not a constant expression"。
const _colUserId = 'user_id';
const _colCreatedAt = 'created_at';
const _colUpdatedAt = 'updated_at';

@freezed
class World with _$World {
  const factory World({
    required String id,
    @JsonKey(name: _colUserId) required String userId,

    required String name,
    String? description,
    String? slug,

    @JsonKey(name: 'archived_at') DateTime? archivedAt,
    @JsonKey(name: _colCreatedAt) DateTime? createdAt,
    @JsonKey(name: _colUpdatedAt) DateTime? updatedAt,
  }) = _World;

  factory World.fromJson(Map<String, dynamic> json) => _$WorldFromJson(json);
}
