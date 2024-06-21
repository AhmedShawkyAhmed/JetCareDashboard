// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      isRead: json['is_read'] as bool?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('message', instance.message);
  writeNotNull('is_read', instance.isRead);
  return val;
}
