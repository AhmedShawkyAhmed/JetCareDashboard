import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_request.g.dart';

@JsonSerializable()
class PackageRequest {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  num? price;
  String? type;
  bool? hasShipping;
  bool? isActive;

  PackageRequest({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.isActive,
    this.type,
    this.descriptionAr,
    this.descriptionEn,
    this.hasShipping,
  });

  factory PackageRequest.fromJson(Map<String, dynamic> json) =>
      _$PackageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PackageRequestToJson(this);
}
