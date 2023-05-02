import 'package:json_annotation/json_annotation.dart';
import 'airedProp.dart';

part 'aired.g.dart';

@JsonSerializable()
class AiredDTO {
  @JsonKey(name: 'from')
  final String? from;
  @JsonKey(name: 'to')
  final String? to;
  @JsonKey(name: 'prop')
  final AiredPropDTO? prop;

  AiredDTO({
    required this.from,
    required this.to,
    required this.prop,
  });

  factory AiredDTO.fromJson(Map<String, dynamic> json) =>
      _$AiredDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AiredDTOToJson(this);
}
