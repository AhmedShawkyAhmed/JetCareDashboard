import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_request.g.dart';

@JsonSerializable()
class PeriodRequest {
  int? id;
  String? from;
  String? to;
  bool? isActive;

  PeriodRequest({
    this.id,
    this.from,
    this.to,
    this.isActive,
  });

  factory PeriodRequest.fromJson(Map<String, dynamic> json) =>
      _$PeriodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodRequestToJson(this);
}
