// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRequest _$NotificationRequestFromJson(Map<String, dynamic> json) =>
    NotificationRequest(
      userId: (json['user_id'] as num?)?.toInt(),
      title: json['title'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$NotificationRequestToJson(NotificationRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  val['title'] = instance.title;
  val['message'] = instance.message;
  return val;
}
