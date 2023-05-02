import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class GenreDTO {
  @JsonKey(name: 'mal_id')
  final int malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'url')
  final String? url;

  GenreDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory GenreDTO.fromJson(Map<String, dynamic> json) =>
      _$GenreDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDTOToJson(this);
}
