// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderator_access_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeratorAccessModel _$ModeratorAccessModelFromJson(
        Map<String, dynamic> json) =>
    ModeratorAccessModel(
      id: (json['id'] as num?)?.toInt(),
      access: (json['access'] as List<dynamic>?)
          ?.map((e) => KeyValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModeratorAccessModelToJson(
    ModeratorAccessModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('access', instance.access?.map((e) => e.toJson()).toList());
  return val;
}
