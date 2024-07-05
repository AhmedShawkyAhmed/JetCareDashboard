// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemRequest _$CategoryItemRequestFromJson(Map<String, dynamic> json) =>
    CategoryItemRequest(
      categoryId: (json['category_id'] as num).toInt(),
      packageIds: (json['package_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      itemIds: (json['item_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CategoryItemRequestToJson(CategoryItemRequest instance) {
  final val = <String, dynamic>{
    'category_id': instance.categoryId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('package_ids', instance.packageIds);
  writeNotNull('item_ids', instance.itemIds);
  return val;
}
