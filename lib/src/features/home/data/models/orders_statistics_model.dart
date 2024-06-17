import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_statistics_model.g.dart';

@JsonSerializable()
class OrdersStatisticsModel {
  int? count;
  int? assigned;
  int? unassigned;
  int? completed;
  int? accepted;
  int? canceled;
  int? rejected;
  int? corporate;
  int? complete;
  int? confirmed;
  int? out;

  OrdersStatisticsModel({
    this.count,
    this.unassigned,
    this.corporate,
    this.canceled,
    this.completed,
    this.accepted,
    this.assigned,
    this.confirmed,
    this.complete,
    this.out,
    this.rejected,
  });

  factory OrdersStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersStatisticsModelToJson(this);
}
