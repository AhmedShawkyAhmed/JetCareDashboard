// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) => PackageModel(
      id: (json['id'] as num?)?.toInt(),
      hasShipping: json['has_shipping'] as bool?,
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      price: json['price'] as num?,
      isActive: json['is_active'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('has_shipping', instance.hasShipping);
  writeNotNull('name_ar', instance.nameAr);
  writeNotNull('name_en', instance.nameEn);
  writeNotNull('description_ar', instance.descriptionAr);
  writeNotNull('description_en', instance.descriptionEn);
  writeNotNull('image', instance.image);
  writeNotNull('type', instance.type);
  writeNotNull('price', instance.price);
  writeNotNull('is_active', instance.isActive);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('packages', instance.packages?.map((e) => e.toJson()).toList());
  return val;
}
