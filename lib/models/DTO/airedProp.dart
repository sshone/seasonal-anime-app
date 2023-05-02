import 'package:json_annotation/json_annotation.dart';

import 'date.dart';

part 'airedProp.g.dart';

@JsonSerializable()
class AiredPropDTO {
  @JsonKey(name: 'from')
  final DateDTO? from;
  @JsonKey(name: 'to')
  final DateDTO? to;
  @JsonKey(name: 'string')
  final String? string;

  AiredPropDTO({
    required this.from,
    required this.to,
    required this.string,
  });

  factory AiredPropDTO.fromJson(Map<String, dynamic> json) =>
      _$AiredPropDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AiredPropDTOToJson(this);
}
