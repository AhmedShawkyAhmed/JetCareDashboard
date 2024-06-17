// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMRequest _$FCMRequestFromJson(Map<String, dynamic> json) => FCMRequest(
      id: (json['id'] as num).toInt(),
      fcm: json['fcm'] as String,
    );

Map<String, dynamic> _$FCMRequestToJson(FCMRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fcm': instance.fcm,
    };
