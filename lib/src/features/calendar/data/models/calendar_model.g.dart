// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) =>
    CalendarModel(
      id: (json['id'] as num?)?.toInt(),
      day: (json['day'] as num?)?.toInt(),
      date: json['db_date'] as String?,
      periods: (json['periods'] as List<dynamic>?)
          ?.map((e) => PeriodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      area: (json['area'] as List<dynamic>?)
          ?.map((e) => AreaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      month: (json['month'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      dayName: json['day_name'] as String?,
      monthName: json['month_name'] as String?,
    );

Map<String, dynamic> _$CalendarModelToJson(CalendarModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('db_date', instance.date);
  writeNotNull('year', instance.year);
  writeNotNull('month', instance.month);
  writeNotNull('day', instance.day);
  writeNotNull('day_name', instance.dayName);
  writeNotNull('month_name', instance.monthName);
  writeNotNull('periods', instance.periods?.map((e) => e.toJson()).toList());
  writeNotNull('area', instance.area?.map((e) => e.toJson()).toList());
  return val;
}
