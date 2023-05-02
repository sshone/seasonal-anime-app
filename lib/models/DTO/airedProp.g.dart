// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airedProp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiredPropDTO _$AiredPropDTOFromJson(Map<String, dynamic> json) => AiredPropDTO(
      from: json['from'] == null
          ? null
          : DateDTO.fromJson(json['from'] as Map<String, dynamic>),
      to: json['to'] == null
          ? null
          : DateDTO.fromJson(json['to'] as Map<String, dynamic>),
      string: json['string'] as String?,
    );

Map<String, dynamic> _$AiredPropDTOToJson(AiredPropDTO instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'string': instance.string,
    };
