// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportCommentRequest _$SupportCommentRequestFromJson(
        Map<String, dynamic> json) =>
    SupportCommentRequest(
      id: (json['id'] as num).toInt(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$SupportCommentRequestToJson(
        SupportCommentRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
    };
