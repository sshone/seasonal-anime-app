// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aired.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiredDTO _$AiredDTOFromJson(Map<String, dynamic> json) => AiredDTO(
      from: json['from'] as String?,
      to: json['to'] as String?,
      prop: json['prop'] == null
          ? null
          : AiredPropDTO.fromJson(json['prop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AiredDTOToJson(AiredDTO instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'prop': instance.prop,
    };
