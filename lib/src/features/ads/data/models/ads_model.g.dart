// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsModel _$AdsModelFromJson(Map<String, dynamic> json) => AdsModel(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      link: json['link'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$AdsModelToJson(AdsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('link', instance.link);
  writeNotNull('image', instance.image);
  writeNotNull('is_active', instance.isActive);
  return val;
}
