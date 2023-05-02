// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageUrls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUrlsDTO _$ImageUrlsDTOFromJson(Map<String, dynamic> json) => ImageUrlsDTO(
      imageUrl: json['image_url'] as String,
      smallImageUrl: json['small_image_url'] as String,
      largeImageUrl: json['large_image_url'] as String,
    );

Map<String, dynamic> _$ImageUrlsDTOToJson(ImageUrlsDTO instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'small_image_url': instance.smallImageUrl,
      'large_image_url': instance.largeImageUrl,
    };
