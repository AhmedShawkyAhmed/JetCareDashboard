// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodModel _$PeriodModelFromJson(Map<String, dynamic> json) => PeriodModel(
      id: (json['id'] as num?)?.toInt(),
      from: json['from'] as String?,
      to: json['to'] as String?,
      isActive: json['is_active'] as bool?,
      relationId: (json['relation_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PeriodModelToJson(PeriodModel instance) {
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
  writeNotNull('relation_id', instance.relationId);
  return val;
}
