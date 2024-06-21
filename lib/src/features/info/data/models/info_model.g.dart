// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      id: (json['id'] as num?)?.toInt(),
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      contentAr: json['content_ar'] as String?,
      contentEn: json['content_en'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title_ar', instance.titleAr);
  writeNotNull('title_en', instance.titleEn);
  writeNotNull('content_ar', instance.contentAr);
  writeNotNull('content_en', instance.contentEn);
  writeNotNull('type', instance.type);
  return val;
}
