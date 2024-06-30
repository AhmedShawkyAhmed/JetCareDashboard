import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/utils/enums.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? unit;
  String? image;
  num? price;
  num? quantity;
  ItemTypes? type;
  bool? hasShipping;
  bool? isActive;

  ItemModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.image,
    this.isActive,
    this.type,
    this.descriptionAr,
    this.descriptionEn,
    this.hasShipping,
    this.quantity,
    this.unit,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
