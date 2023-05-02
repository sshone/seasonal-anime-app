// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LicensorDTO _$LicensorDTOFromJson(Map<String, dynamic> json) => LicensorDTO(
      malId: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LicensorDTOToJson(LicensorDTO instance) =>
    <String, dynamic>{
      'mal_id': instance.malId,
      'type': instance.type,
      'name': instance.name,
      'url': instance.url,
    };
