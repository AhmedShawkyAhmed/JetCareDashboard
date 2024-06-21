// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoRequest _$InfoRequestFromJson(Map<String, dynamic> json) => InfoRequest(
      id: (json['id'] as num?)?.toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      contentAr: json['content_ar'] as String,
      contentEn: json['content_en'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$InfoRequestToJson(InfoRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title_ar'] = instance.titleAr;
  val['title_en'] = instance.titleEn;
  val['content_ar'] = instance.contentAr;
  val['content_en'] = instance.contentEn;
  val['type'] = instance.type;
  return val;
}
