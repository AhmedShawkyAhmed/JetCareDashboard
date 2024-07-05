import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';

part 'package_model.g.dart';

@JsonSerializable()
class PackageModel {
  int? id;
  bool? hasShipping;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  String? type;
  num? price;
  bool? isActive;
  List<ItemModel>? items;
  List<PackageModel>? packages;

  PackageModel({
    this.id,
    this.hasShipping,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.image,
    this.type,
    this.price,
    this.isActive,
    this.items,
    this.packages,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}