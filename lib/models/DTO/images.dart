import 'package:json_annotation/json_annotation.dart';

import 'imageUrls.dart';

part 'images.g.dart';

@JsonSerializable()
class ImagesDTO {
  @JsonKey(name: 'jpg')
  final ImageUrlsDTO jpg;
  @JsonKey(name: 'webp')
  final ImageUrlsDTO webp;

  ImagesDTO({
    required this.jpg,
    required this.webp,
  });

  factory ImagesDTO.fromJson(Map<String, dynamic> json) =>
      _$ImagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesDTOToJson(this);
}
