// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateOrderRequest _$CorporateOrderRequestFromJson(
        Map<String, dynamic> json) =>
    CorporateOrderRequest(
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      message: json['message'] as String,
      itemId: (json['item_id'] as num).toInt(),
    );

Map<String, dynamic> _$CorporateOrderRequestToJson(
        CorporateOrderRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'message': instance.message,
      'item_id': instance.itemId,
    };
