// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateRequest _$StateRequestFromJson(Map<String, dynamic> json) => StateRequest(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$StateRequestToJson(StateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('is_active', instance.isActive);
  return val;
}
