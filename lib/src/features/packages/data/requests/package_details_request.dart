import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_details_request.g.dart';

@JsonSerializable()
class PackageDetailsRequest {
  int packageId;
  List<String> nameAr;
  List<String> nameEn;

  PackageDetailsRequest({
    required this.packageId,
    required this.nameAr,
    required this.nameEn,
  });

  factory PackageDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsRequestToJson(this);
}
