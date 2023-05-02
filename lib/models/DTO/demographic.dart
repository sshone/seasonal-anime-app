import 'package:json_annotation/json_annotation.dart';
part 'demographic.g.dart';

@JsonSerializable()
class DemographicDTO {
  @JsonKey(name: 'mal_id')
  final int? malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  DemographicDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory DemographicDTO.fromJson(Map<String, dynamic> json) =>
      _$DemographicDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DemographicDTOToJson(this);
}
