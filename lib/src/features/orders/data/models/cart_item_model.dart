import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  int? id;
  int? userId;
  num count;
  num price;
  String status;
  PackageModel? package;
  ItemModel? item;

  CartItemModel({
    this.id,
    this.userId,
    required this.status,
    required this.price,
    required this.count,
    this.package,
    this.item,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
