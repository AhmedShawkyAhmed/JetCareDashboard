// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRequest _$CartRequestFromJson(Map<String, dynamic> json) => CartRequest(
      userId: (json['user_id'] as num).toInt(),
      count: json['count'] as num,
      price: json['price'] as num,
      itemId: json['item_id'] as num?,
      packageId: json['package_id'] as num?,
    );

Map<String, dynamic> _$CartRequestToJson(CartRequest instance) {
  final val = <String, dynamic>{
    'user_id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('package_id', instance.packageId);
  writeNotNull('item_id', instance.itemId);
  val['count'] = instance.count;
  val['price'] = instance.price;
  return val;
}
