import 'package:jetboard/src/data/models/orders_model.dart';

class OrdersResponse {
  int? status;
  List<OrdersModel>? ordersModel;

  OrdersResponse({this.status, this.ordersModel,});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        status: json['status'],
        ordersModel: json["orders"] != null
            ? List<OrdersModel>.from(
                json["orders"].map((x) => OrdersModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "orders": List<dynamic>.from(ordersModel!.map((e) => e.toJson())),
      };
}
