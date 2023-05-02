// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demographic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemographicDTO _$DemographicDTOFromJson(Map<String, dynamic> json) =>
    DemographicDTO(
      malId: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$DemographicDTOToJson(DemographicDTO instance) =>
    <String, dynamic>{
      'mal_id': instance.malId,
      'type': instance.type,
      'name': instance.name,
      'url': instance.url,
    };
