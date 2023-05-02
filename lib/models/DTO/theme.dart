import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
class ThemeDTO {
  @JsonKey(name: 'mal_id')
  final int? malId;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'url')
  final String? url;

  ThemeDTO({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory ThemeDTO.fromJson(Map<String, dynamic> json) =>
      _$ThemeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeDTOToJson(this);
}
