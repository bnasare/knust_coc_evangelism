// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProspectImpl _$$ProspectImplFromJson(Map<String, dynamic> json) =>
    _$ProspectImpl(
      evangelismSetting: json['evangelismSetting'] as String,
      initialContact: json['initialContact'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      demographics: json['demographics'] as String,
      gender: json['gender'] as String,
      religiousAffiliation: json['religiousAffiliation'] as String,
      baptismalStatus: json['baptismalStatus'] as String,
      interactionDetails: json['interactionDetails'] as String,
      id: json['id'] as String,
      localeID: json['localeID'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ProspectImplToJson(_$ProspectImpl instance) =>
    <String, dynamic>{
      'evangelismSetting': instance.evangelismSetting,
      'initialContact': instance.initialContact,
      'name': instance.name,
      'mobile': instance.mobile,
      'demographics': instance.demographics,
      'gender': instance.gender,
      'religiousAffiliation': instance.religiousAffiliation,
      'baptismalStatus': instance.baptismalStatus,
      'interactionDetails': instance.interactionDetails,
      'id': instance.id,
      'localeID': instance.localeID,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
