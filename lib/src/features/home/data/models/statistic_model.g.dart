// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticModel _$StatisticModelFromJson(Map<String, dynamic> json) =>
    StatisticModel(
      count: (json['count'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      disabled: (json['disabled'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatisticModelToJson(StatisticModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  writeNotNull('is_active', instance.isActive);
  writeNotNull('disabled', instance.disabled);
  return val;
}
