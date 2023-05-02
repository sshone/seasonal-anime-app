// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProducerDTO _$ProducerDTOFromJson(Map<String, dynamic> json) => ProducerDTO(
      malId: json['mal_id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ProducerDTOToJson(ProducerDTO instance) =>
    <String, dynamic>{
      'mal_id': instance.malId,
      'type': instance.type,
      'name': instance.name,
      'url': instance.url,
    };
