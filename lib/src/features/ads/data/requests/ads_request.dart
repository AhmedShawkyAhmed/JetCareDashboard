import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_request.g.dart';

@JsonSerializable()
class AdsRequest {
  int? id;
  String? nameAr;
  String? nameEn;
  String? link;
  bool? isActive;

  AdsRequest({
    this.id,
    this.nameAr,
    this.nameEn,
    this.link,
    this.isActive,
  });

  factory AdsRequest.fromJson(Map<String, dynamic> json) =>
      _$AdsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdsRequestToJson(this);
}
