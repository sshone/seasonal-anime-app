import 'package:json_annotation/json_annotation.dart';

part 'licensor.g.dart';

@JsonSerializable()
class LicensorDTO {
  @JsonKey(name: 'mal_id')
  final int? malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  LicensorDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory LicensorDTO.fromJson(Map<String, dynamic> json) =>
      _$LicensorDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LicensorDTOToJson(this);
}
