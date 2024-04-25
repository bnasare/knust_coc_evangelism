// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalesImpl _$$LocalesImplFromJson(Map<String, dynamic> json) =>
    _$LocalesImpl(
      name: json['name'] as String,
      timeframe: json['timeframe'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LocalesImplToJson(_$LocalesImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'timeframe': instance.timeframe,
      'id': instance.id,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
