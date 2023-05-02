import 'package:json_annotation/json_annotation.dart';

part 'studio.g.dart';

@JsonSerializable()
class StudioDTO {
  @JsonKey(name: 'mal_id')
  final int? malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  StudioDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory StudioDTO.fromJson(Map<String, dynamic> json) =>
      _$StudioDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StudioDTOToJson(this);
}
