import 'package:json_annotation/json_annotation.dart';

part 'producer.g.dart';

@JsonSerializable()
class ProducerDTO {
  @JsonKey(name: 'mal_id')
  final int? malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  ProducerDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory ProducerDTO.fromJson(Map<String, dynamic> json) =>
      _$ProducerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProducerDTOToJson(this);
}
