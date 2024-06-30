import 'package:freezed_annotation/freezed_annotation.dart';

part 'corporate_order_request.g.dart';

@JsonSerializable()
class CorporateOrderRequest {
  int userId;
  String name;
  String email;
  String phone;
  String message;
  int itemId;

  CorporateOrderRequest({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.itemId,
  });

  factory CorporateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CorporateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CorporateOrderRequestToJson(this);
}
