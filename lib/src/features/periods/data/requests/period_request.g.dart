// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodRequest _$PeriodRequestFromJson(Map<String, dynamic> json) =>
    PeriodRequest(
      id: (json['id'] as num?)?.toInt(),
      from: json['from'] as String?,
      to: json['to'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$PeriodRequestToJson(PeriodRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('from', instance.from);
  writeNotNull('to', instance.to);
  writeNotNull('is_active', instance.isActive);
  return val;
}
