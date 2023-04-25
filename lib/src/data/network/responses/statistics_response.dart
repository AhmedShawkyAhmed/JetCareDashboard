import 'package:jetboard/src/data/models/home_model.dart';
import 'package:jetboard/src/data/models/order_home_model.dart';

class StatisticsResponse {
  int? status;
  OrderHomeModel? orders;
  HomeModel? client, crew, ads, category, package, item;

  StatisticsResponse({
    this.status,
    this.orders,
    this.client,
    this.crew,
    this.ads,
    this.category,
    this.package,
    this.item,
  });

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) =>
      StatisticsResponse(
        status: json["status"] ?? 0,
        orders: json["orders"] != null
            ? OrderHomeModel.fromJson(json["orders"])
            : null,
        client:
            json["client"] != null ? HomeModel.fromJson(json["client"]) : null,
        crew: json["crew"] != null ? HomeModel.fromJson(json["crew"]) : null,
        ads: json["ads"] != null ? HomeModel.fromJson(json["ads"]) : null,
        category: json["category"] != null
            ? HomeModel.fromJson(json["category"])
            : null,
        package: json["package"] != null
            ? HomeModel.fromJson(json["package"])
            : null,
        item: json["item"] != null ? HomeModel.fromJson(json["item"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "orders": orders,
        "client": client,
        "crew": crew,
        "ads": ads,
        "category": category,
        "package": package,
        "item": item,
      };
}
