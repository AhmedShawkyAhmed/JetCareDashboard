import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/home/data/models/orders_statistics_model.dart';
import 'package:jetboard/src/features/home/data/models/statistic_model.dart';

part 'home_statistics_model.g.dart';

@JsonSerializable()
class HomeStatisticsModel {
  OrdersStatisticsModel? orders;
  StatisticModel? client;
  StatisticModel? crew;
  StatisticModel? ads;

  HomeStatisticsModel({
    this.orders,
    this.ads,
    this.client,
    this.crew,
  });

  factory HomeStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStatisticsModelToJson(this);
}
