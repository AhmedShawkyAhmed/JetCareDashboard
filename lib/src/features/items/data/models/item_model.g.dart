// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      price: json['price'] as num?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool?,
      type: $enumDecodeNullable(_$ItemTypesEnumMap, json['type']),
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      hasShipping: json['has_shipping'] as bool?,
      quantity: json['quantity'] as num?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('description_ar', instance.descriptionAr);
  writeNotNull('description_en', instance.descriptionEn);
  writeNotNull('unit', instance.unit);
  writeNotNull('image', instance.image);
  writeNotNull('price', instance.price);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('type', _$ItemTypesEnumMap[instance.type]);
  writeNotNull('has_shipping', instance.hasShipping);
  writeNotNull('is_active', instance.isActive);
  return val;
}

const _$ItemTypesEnumMap = {
  ItemTypes.item: 'item',
  ItemTypes.corporate: 'corporate',
  ItemTypes.extra: 'extra',
  ItemTypes.package: 'package',
};
