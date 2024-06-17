// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStatisticsModel _$HomeStatisticsModelFromJson(Map<String, dynamic> json) =>
    HomeStatisticsModel(
      orders: json['orders'] == null
          ? null
          : OrdersStatisticsModel.fromJson(
              json['orders'] as Map<String, dynamic>),
      ads: json['ads'] == null
          ? null
          : StatisticModel.fromJson(json['ads'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : StatisticModel.fromJson(json['client'] as Map<String, dynamic>),
      crew: json['crew'] == null
          ? null
          : StatisticModel.fromJson(json['crew'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeStatisticsModelToJson(HomeStatisticsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('orders', instance.orders?.toJson());
  writeNotNull('client', instance.client?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  writeNotNull('ads', instance.ads?.toJson());
  return val;
}
