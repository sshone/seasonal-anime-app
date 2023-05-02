import 'package:json_annotation/json_annotation.dart';

part 'date.g.dart';

@JsonSerializable()
class DateDTO {
  @JsonKey(name: 'day')
  final int? day;
  @JsonKey(name: 'month')
  final int? month;
  @JsonKey(name: 'year')
  final int? year;

  DateDTO({
    required this.day,
    required this.month,
    required this.year,
  });

  factory DateDTO.fromJson(Map<String, dynamic> json) =>
      _$DateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DateDTOToJson(this);
}
