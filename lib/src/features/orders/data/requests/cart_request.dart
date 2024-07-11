import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_request.g.dart';

@JsonSerializable()
class CartRequest {
  int userId;
  num? packageId;
  num? itemId;
  num count;
  num price;

  CartRequest({
    required this.userId,
    required this.count,
    required this.price,
    this.itemId,
    this.packageId,
  });

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}
