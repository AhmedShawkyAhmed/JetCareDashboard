// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersStatisticsModel _$OrdersStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    OrdersStatisticsModel(
      count: (json['count'] as num?)?.toInt(),
      unassigned: (json['unassigned'] as num?)?.toInt(),
      corporate: (json['corporate'] as num?)?.toInt(),
      canceled: (json['canceled'] as num?)?.toInt(),
      completed: (json['completed'] as num?)?.toInt(),
      accepted: (json['accepted'] as num?)?.toInt(),
      assigned: (json['assigned'] as num?)?.toInt(),
      confirmed: (json['confirmed'] as num?)?.toInt(),
      complete: (json['complete'] as num?)?.toInt(),
      out: (json['out'] as num?)?.toInt(),
      rejected: (json['rejected'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrdersStatisticsModelToJson(
    OrdersStatisticsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  writeNotNull('assigned', instance.assigned);
  writeNotNull('unassigned', instance.unassigned);
  writeNotNull('completed', instance.completed);
  writeNotNull('accepted', instance.accepted);
  writeNotNull('canceled', instance.canceled);
  writeNotNull('rejected', instance.rejected);
  writeNotNull('corporate', instance.corporate);
  writeNotNull('complete', instance.complete);
  writeNotNull('confirmed', instance.confirmed);
  writeNotNull('out', instance.out);
  return val;
}
