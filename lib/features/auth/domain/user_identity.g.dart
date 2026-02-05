// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserIdentityImpl _$$UserIdentityImplFromJson(Map<String, dynamic> json) =>
    _$UserIdentityImpl(
      worldId: json['world_id'] as String?,
      roleName: json['role_name'] as String? ?? 'Unknown',
      roleTitle: json['role_title'] as String? ?? '',
      statusBars: json['status_bars'] == null
          ? const {}
          : _statusBarsFromJson(json['status_bars']),
    );

Map<String, dynamic> _$$UserIdentityImplToJson(_$UserIdentityImpl instance) =>
    <String, dynamic>{
      'world_id': instance.worldId,
      'role_name': instance.roleName,
      'role_title': instance.roleTitle,
      'status_bars': instance.statusBars,
    };
