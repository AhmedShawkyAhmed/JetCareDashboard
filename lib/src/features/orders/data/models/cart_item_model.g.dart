// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      status: json['status'] as String,
      price: json['price'] as num,
      count: json['count'] as num,
      package: json['package'] == null
          ? null
          : PackageModel.fromJson(json['package'] as Map<String, dynamic>),
      item: json['item'] == null
          ? null
          : ItemModel.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  val['count'] = instance.count;
  val['price'] = instance.price;
  val['status'] = instance.status;
  writeNotNull('package', instance.package?.toJson());
  writeNotNull('item', instance.item?.toJson());
  return val;
}
