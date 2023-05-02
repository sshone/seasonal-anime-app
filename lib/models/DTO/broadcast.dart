import 'package:json_annotation/json_annotation.dart';

part 'broadcast.g.dart';

@JsonSerializable()
class BroadcastDTO {
  @JsonKey(name: 'day')
  final String? day;
  @JsonKey(name: 'time')
  final String? time;
  @JsonKey(name: 'timezone')
  final String? timezone;
  @JsonKey(name: 'string')
  final String? string;

  BroadcastDTO({
    required this.day,
    required this.time,
    required this.timezone,
    required this.string,
  });

  factory BroadcastDTO.fromJson(Map<String, dynamic> json) =>
      _$BroadcastDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastDTOToJson(this);
}
