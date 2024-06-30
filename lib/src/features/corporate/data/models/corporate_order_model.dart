import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';

part 'corporate_order_model.g.dart';

@JsonSerializable()
class CorporateOrderModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? message;
  bool? contact;
  String? adminComment;
  ItemModel? item;
  UserModel? user;
  UserModel? crew;

  CorporateOrderModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.message,
    this.contact,
    this.adminComment,
    this.item,
    this.user,
    this.crew,
  });

  factory CorporateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CorporateOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CorporateOrderModelToJson(this);
}
