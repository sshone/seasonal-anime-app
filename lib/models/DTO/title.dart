import 'package:json_annotation/json_annotation.dart';

part 'title.g.dart';

@JsonSerializable()
class TitleDTO {
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'title')
  final String? title;

  TitleDTO({
    required this.type,
    required this.title,
  });

  factory TitleDTO.fromJson(Map<String, dynamic> json) =>
      _$TitleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TitleDTOToJson(this);
}
