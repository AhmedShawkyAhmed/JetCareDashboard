import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  int userId;
  num periodId;
  num addressId;
  num? relationId;
  String date;
  String total;
  String price;
  int shipping;
  List<int> cart;
  String? comment;

  OrderRequest({
    required this.userId,
    required this.total,
    required this.price,
    required this.shipping,
    required this.addressId,
    required this.periodId,
    required this.date,
    required this.cart,
    this.comment,
    this.relationId,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
