// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateOrderModel _$CorporateOrderModelFromJson(Map<String, dynamic> json) =>
    CorporateOrderModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      message: json['message'] as String?,
      contact: json['contact'] as bool?,
      adminComment: json['admin_comment'] as String?,
      item: json['item'] == null
          ? null
          : ItemModel.fromJson(json['item'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      crew: json['crew'] == null
          ? null
          : UserModel.fromJson(json['crew'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CorporateOrderModelToJson(CorporateOrderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('message', instance.message);
  writeNotNull('contact', instance.contact);
  writeNotNull('admin_comment', instance.adminComment);
  writeNotNull('item', instance.item?.toJson());
  writeNotNull('user', instance.user?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  return val;
}
