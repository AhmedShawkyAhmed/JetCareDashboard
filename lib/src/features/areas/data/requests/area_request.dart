import 'package:freezed_annotation/freezed_annotation.dart';

part 'area_request.g.dart';

@JsonSerializable()
class AreaRequest {
  int? id;
  int? stateId;
  String? nameAr;
  String? nameEn;
  num? price;
  num? discount;
  num? transportation;
  bool? isActive;

  AreaRequest({
    this.id,
    this.stateId,
    this.nameAr,
    this.nameEn,
    this.price,
    this.discount,
    this.transportation,
    this.isActive,
  });

  factory AreaRequest.fromJson(Map<String, dynamic> json) =>
      _$AreaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AreaRequestToJson(this);
}
