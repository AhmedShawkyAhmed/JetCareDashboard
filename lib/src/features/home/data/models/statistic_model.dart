import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistic_model.g.dart';

@JsonSerializable()
class StatisticModel {
  int? count;
  int? isActive;
  int? disabled;

  StatisticModel({
    this.count,
    this.isActive,
    this.disabled,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticModelToJson(this);
}
