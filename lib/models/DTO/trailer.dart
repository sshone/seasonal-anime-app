import 'package:json_annotation/json_annotation.dart';

part 'trailer.g.dart';

@JsonSerializable()
class TrailerDTO {
  @JsonKey(name: 'youtube_id')
  final String? youtubeId;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'embed_url')
  final String? embedUrl;

  TrailerDTO({
    required this.youtubeId,
    required this.url,
    required this.embedUrl,
  });

  factory TrailerDTO.fromJson(Map<String, dynamic> json) =>
      _$TrailerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerDTOToJson(this);
}
