import 'package:json_annotation/json_annotation.dart';

part 'imageUrls.g.dart';

@JsonSerializable()
class ImageUrlsDTO {
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'small_image_url')
  final String smallImageUrl;
  @JsonKey(name: 'large_image_url')
  final String largeImageUrl;

  ImageUrlsDTO({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory ImageUrlsDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageUrlsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlsDTOToJson(this);
}
