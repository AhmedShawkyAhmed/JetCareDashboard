// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      total: json['total'] as num?,
      price: json['price'] as num?,
      shipping: json['shipping'] as num?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      crew: json['crew'] == null
          ? null
          : UserModel.fromJson(json['crew'] as Map<String, dynamic>),
      date: json['date'] as String?,
      item: json['item'] == null
          ? null
          : ItemModel.fromJson(json['item'] as Map<String, dynamic>),
      period: json['period'] == null
          ? null
          : PeriodModel.fromJson(json['period'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      package: json['package'] == null
          ? null
          : PackageModel.fromJson(json['package'] as Map<String, dynamic>),
      calendar: json['calendar'] == null
          ? null
          : CalendarModel.fromJson(json['calendar'] as Map<String, dynamic>),
      extras: (json['extras'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('date', instance.date);
  writeNotNull('comment', instance.comment);
  writeNotNull('total', instance.total);
  writeNotNull('price', instance.price);
  writeNotNull('shipping', instance.shipping);
  writeNotNull('user', instance.user?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  writeNotNull('period', instance.period?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('package', instance.package?.toJson());
  writeNotNull('item', instance.item?.toJson());
  writeNotNull('calendar', instance.calendar?.toJson());
  writeNotNull('extras', instance.extras?.map((e) => e.toJson()).toList());
  writeNotNull('cart', instance.cart?.map((e) => e.toJson()).toList());
  return val;
}
