import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/calendar/data/models/calendar_model.dart';
import 'package:jetboard/src/features/clients/data/models/address_model.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/orders/data/models/cart_item_model.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int? id;
  OrderStatus? status;
  String? createdAt, date, comment,adminComment;
  num? total, price, shipping,extra;
  UserModel? user, crew;
  PeriodModel? period;
  AddressModel? address;
  PackageModel? package;
  ItemModel? item;
  CalendarModel? calendar;
  List<ItemModel>? extras;
  List<CartItemModel>? cart;

  OrderModel({
    this.id,
    this.status,
    this.createdAt,
    this.total,
    this.price,
    this.shipping,
    this.extra,
    this.user,
    this.crew,
    this.date,
    this.item,
    this.period,
    this.address,
    this.package,
    this.calendar,
    this.extras,
    this.cart,
    this.comment,
    this.adminComment,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}