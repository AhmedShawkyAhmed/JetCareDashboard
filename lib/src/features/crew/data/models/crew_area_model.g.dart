// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrewAreaModel _$CrewAreaModelFromJson(Map<String, dynamic> json) =>
    CrewAreaModel(
      id: (json['id'] as num?)?.toInt(),
      area: json['area'] == null
          ? null
          : AreaModel.fromJson(json['area'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CrewAreaModelToJson(CrewAreaModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('area', instance.area?.toJson());
  return val;
}
