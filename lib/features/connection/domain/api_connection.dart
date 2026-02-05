import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_connection.freezed.dart';
part 'api_connection.g.dart';

/// Strict service types matching DB check constraint.
///
/// DB: openai_compat|stt|tts|image|custom
enum ApiServiceType {
  @JsonValue('openai_compat')
  openaiCompat,
  @JsonValue('stt')
  stt,
  @JsonValue('tts')
  tts,
  @JsonValue('image')
  image,
  @JsonValue('custom')
  custom,
}

@freezed
class ApiConnectionBase with _$ApiConnectionBase {
  const factory ApiConnectionBase({
    required String name,
    required ApiServiceType serviceType,
    required String baseUrl,
    @Default(true) bool isActive,
    String? defaultModel,
    String? systemPrompt,
    @Default(<String, dynamic>{}) Map<String, dynamic> params,
    @Default(<String, dynamic>{}) Map<String, dynamic> headersTemplate,
    @Default(<String, dynamic>{}) Map<String, dynamic> config,
    DateTime? updatedAt,
  }) = _ApiConnectionBase;

  factory ApiConnectionBase.fromJson(Map<String, dynamic> json) =>
      _$ApiConnectionBaseFromJson(json);
}

@freezed
class CloudApiConnection with _$CloudApiConnection {
  const factory CloudApiConnection({
    required String id,
    required String userId,
    required ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CloudApiConnection;

  factory CloudApiConnection.fromJson(Map<String, dynamic> json) =>
      _$CloudApiConnectionFromJson(json);
}

@freezed
class LocalApiConnection with _$LocalApiConnection {
  const factory LocalApiConnection({
    required String localId,
    required ApiConnectionBase base,
    DateTime? createdAt,
    DateTime? updatedAt,

    /// Optional: track provenance for UI hints.
    String? copiedFromCloudId,
  }) = _LocalApiConnection;

  factory LocalApiConnection.fromJson(Map<String, dynamic> json) =>
      _$LocalApiConnectionFromJson(json);
}

enum ConnectionSource { cloud, local }

@freezed
class ConnectionListItem with _$ConnectionListItem {
  const factory ConnectionListItem.cloud({
    required CloudApiConnection connection,
  }) = _ConnectionListItemCloud;

  const factory ConnectionListItem.local({
    required LocalApiConnection connection,
  }) = _ConnectionListItemLocal;
}
