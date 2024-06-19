// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportModel _$SupportModelFromJson(Map<String, dynamic> json) => SupportModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      adminComment: json['admin_comment'] as String?,
      isArchived: json['is_archived'] as bool?,
    );

Map<String, dynamic> _$SupportModelToJson(SupportModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('contact', instance.contact);
  writeNotNull('subject', instance.subject);
  writeNotNull('message', instance.message);
  writeNotNull('admin_comment', instance.adminComment);
  writeNotNull('is_archived', instance.isArchived);
  return val;
}
