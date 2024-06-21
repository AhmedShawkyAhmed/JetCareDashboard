import 'package:freezed_annotation/freezed_annotation.dart';

part 'area_model.g.dart';

@JsonSerializable()
class AreaModel {
  int? id;
  int? stateId;
  String? nameAr;
  String? nameEn;
  num? price;
  num? discount;
  num? transportation;
  bool? isActive;
  bool? isArchived;

  AreaModel({
    this.id,
    this.stateId,
    this.nameAr,
    this.nameEn,
    this.price,
    this.discount,
    this.transportation,
    this.isActive,
    this.isArchived,
  });
  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);
}