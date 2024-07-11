import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/features/orders/data/models/cart_item_model.dart';

part 'cart_request.g.dart';

@JsonSerializable()
class CartRequest {
  int userId;
  num? packageId;
  num? itemId;
  num? count;
  num? price;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<CartItemModel>? cart;

  CartRequest({
    required this.userId,
    this.cart,
    this.count,
    this.price,
    this.itemId,
    this.packageId,
  });

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}
