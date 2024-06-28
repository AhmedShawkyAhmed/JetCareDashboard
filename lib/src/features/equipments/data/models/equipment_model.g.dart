// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) =>
    EquipmentModel(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$EquipmentModelToJson(EquipmentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('code', instance.code);
  writeNotNull('name', instance.name);
  writeNotNull('is_active', instance.isActive);
  return val;
}
