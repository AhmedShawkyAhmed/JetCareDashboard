import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_model.g.dart';

@JsonSerializable()
class AdsModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? link;
  String? image;
  bool? isActive;

  AdsModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.link,
    this.image,
    this.isActive,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) =>
      _$AdsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdsModelToJson(this);
}
