import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';

part 'package_details_model.g.dart';

@JsonSerializable()
class PackageDetailsModel {
  PackageModel? package;
  List<ItemModel>? items;

  PackageDetailsModel({
    this.package,
    this.items,
  });

  factory PackageDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsModelToJson(this);
}