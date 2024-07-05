// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetailsRequest _$PackageDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    PackageDetailsRequest(
      packageId: (json['package_id'] as num).toInt(),
      nameAr:
          (json['name_ar'] as List<dynamic>).map((e) => e as String).toList(),
      nameEn:
          (json['name_en'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PackageDetailsRequestToJson(
        PackageDetailsRequest instance) =>
    <String, dynamic>{
      'package_id': instance.packageId,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
    };
