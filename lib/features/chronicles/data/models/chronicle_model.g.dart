// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChronicleModelImpl _$$ChronicleModelImplFromJson(Map<String, dynamic> json) =>
    _$ChronicleModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      worldId: json['world_id'] as String?,
      type: $enumDecode(_$ChronicleTypeEnumMap, json['type']),
      content: ChronicleContent.fromJson(
        json['content'] as Map<String, dynamic>,
      ),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ChronicleModelImplToJson(
  _$ChronicleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'world_id': instance.worldId,
  'type': _$ChronicleTypeEnumMap[instance.type]!,
  'content': instance.content,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$ChronicleTypeEnumMap = {
  ChronicleType.chat: 'chat',
  ChronicleType.memo: 'memo',
  ChronicleType.transaction: 'transaction',
};

_$ChatContentImpl _$$ChatContentImplFromJson(Map<String, dynamic> json) =>
    _$ChatContentImpl(
      sender: json['sender'] as String,
      npcKey: json['npcKey'] as String?,
      message: json['message'] as String,
      systemEvents:
          (json['systemEvents'] as List<dynamic>?)
              ?.map((e) => SystemEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      thought: json['thought'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ChatContentImplToJson(_$ChatContentImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'npcKey': instance.npcKey,
      'message': instance.message,
      'systemEvents': instance.systemEvents,
      'thought': instance.thought,
      'runtimeType': instance.$type,
    };

_$MemoContentImpl _$$MemoContentImplFromJson(Map<String, dynamic> json) =>
    _$MemoContentImpl(
      title: json['title'] as String,
      body: json['body'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isPinned: json['isPinned'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MemoContentImplToJson(_$MemoContentImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
      'isPinned': instance.isPinned,
      'runtimeType': instance.$type,
    };

_$TransactionContentImpl _$$TransactionContentImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionContentImpl(
  transactionType: json['transactionType'] as String,
  amount: (json['amount'] as num).toInt(),
  currencyType: json['currencyType'] as String? ?? 'points',
  reason: json['reason'] as String,
  referenceId: json['referenceId'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$TransactionContentImplToJson(
  _$TransactionContentImpl instance,
) => <String, dynamic>{
  'transactionType': instance.transactionType,
  'amount': instance.amount,
  'currencyType': instance.currencyType,
  'reason': instance.reason,
  'referenceId': instance.referenceId,
  'runtimeType': instance.$type,
};

_$SystemEventImpl _$$SystemEventImplFromJson(Map<String, dynamic> json) =>
    _$SystemEventImpl(
      type: json['type'] as String,
      amount: (json['amount'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      questId: json['quest_id'] as String?,
      status: json['status'] as String?,
      npcKey: json['npc_key'] as String?,
      value: (json['value'] as num?)?.toInt(),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SystemEventImplToJson(_$SystemEventImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'reason': instance.reason,
      'quest_id': instance.questId,
      'status': instance.status,
      'npc_key': instance.npcKey,
      'value': instance.value,
      'data': instance.data,
    };
