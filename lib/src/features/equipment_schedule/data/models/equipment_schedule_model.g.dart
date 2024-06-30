// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentScheduleModel _$EquipmentScheduleModelFromJson(
        Map<String, dynamic> json) =>
    EquipmentScheduleModel(
      id: (json['id'] as num?)?.toInt(),
      equipment: json['equipment'] == null
          ? null
          : EquipmentModel.fromJson(json['equipment'] as Map<String, dynamic>),
      crew: json['crew'] == null
          ? null
          : UserModel.fromJson(json['crew'] as Map<String, dynamic>),
      date: json['date'] as String?,
      returned: json['returned'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$EquipmentScheduleModelToJson(
    EquipmentScheduleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('equipment', instance.equipment?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  writeNotNull('date', instance.date);
  writeNotNull('returned', instance.returned);
  writeNotNull('created_at', instance.createdAt);
  return val;
}
