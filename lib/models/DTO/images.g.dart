// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagesDTO _$ImagesDTOFromJson(Map<String, dynamic> json) => ImagesDTO(
      jpg: ImageUrlsDTO.fromJson(json['jpg'] as Map<String, dynamic>),
      webp: ImageUrlsDTO.fromJson(json['webp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImagesDTOToJson(ImagesDTO instance) => <String, dynamic>{
      'jpg': instance.jpg,
      'webp': instance.webp,
    };
