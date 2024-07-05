// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageRequest _$PackageRequestFromJson(Map<String, dynamic> json) =>
    PackageRequest(
      id: (json['id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      price: json['price'] as num?,
      isActive: json['is_active'] as bool?,
      type: json['type'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      hasShipping: json['has_shipping'] as bool?,
    );

Map<String, dynamic> _$PackageRequestToJson(PackageRequest instance) {
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
  writeNotNull('price', instance.price);
  writeNotNull('type', instance.type);
  writeNotNull('has_shipping', instance.hasShipping);
  writeNotNull('is_active', instance.isActive);
  return val;
}
