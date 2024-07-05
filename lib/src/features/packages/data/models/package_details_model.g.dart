// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetailsModel _$PackageDetailsModelFromJson(Map<String, dynamic> json) =>
    PackageDetailsModel(
      package: json['package'] == null
          ? null
          : PackageModel.fromJson(json['package'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageDetailsModelToJson(PackageDetailsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('package', instance.package?.toJson());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}
