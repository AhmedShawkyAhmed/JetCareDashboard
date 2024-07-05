import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  String? type;
  num? price;
  bool? isActive;
  List<PackageModel>? packages;
  List<ItemModel>? items;

  CategoryModel({
    this.id,
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

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
