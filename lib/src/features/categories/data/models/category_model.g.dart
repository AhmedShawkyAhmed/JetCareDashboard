// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num?)?.toInt(),
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

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) {
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
  writeNotNull('image', instance.image);
  writeNotNull('type', instance.type);
  writeNotNull('price', instance.price);
  writeNotNull('is_active', instance.isActive);
  writeNotNull('packages', instance.packages?.map((e) => e.toJson()).toList());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}
