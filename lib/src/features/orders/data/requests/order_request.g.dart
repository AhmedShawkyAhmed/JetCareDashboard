// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      userId: (json['user_id'] as num).toInt(),
      total: json['total'] as String,
      price: json['price'] as String,
      shipping: (json['shipping'] as num).toInt(),
      addressId: json['address_id'] as num,
      periodId: json['period_id'] as num,
      date: json['date'] as String,
      cart: (json['cart'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      comment: json['comment'] as String?,
      relationId: json['relation_id'] as num?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
    'period_id': instance.periodId,
    'address_id': instance.addressId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('relation_id', instance.relationId);
  val['date'] = instance.date;
  val['total'] = instance.total;
  val['price'] = instance.price;
  val['shipping'] = instance.shipping;
  val['cart'] = instance.cart;
  writeNotNull('comment', instance.comment);
  return val;
}
