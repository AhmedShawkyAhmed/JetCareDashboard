import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_model.g.dart';

@JsonSerializable()
class PeriodModel {
  int? id;
  String? from;
  String? to;
  bool? isActive;
  int? relationId;

  PeriodModel({
    this.id,
    this.from,
    this.to,
    this.isActive,
    this.relationId,
  });
  factory PeriodModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodModelToJson(this);
}