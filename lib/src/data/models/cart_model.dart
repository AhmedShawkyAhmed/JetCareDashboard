import 'package:jetboard/src/data/models/orders_model.dart';

class CartModel{
  int id;
  int? userId;
  num count;
  num price;
  String status;
  Package? package;
  Package? item;

  CartModel({
    required this.id,
     this.userId,
    required this.count,
    required this.status,
    required this.price,
    this.item,
    this.package,
});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] ?? 0,
    userId: json['userId'] ?? 0,
    count: json['count'] ?? 0,
    price: json['price'] ?? 0,
    status: json['status'] ?? "",
    item:  json['items'] != null ? Package.fromJson(json['items']) : null,
    package:  json['packages'] != null ? Package.fromJson(json['packages']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'count': count,
    'price': price,
    'status': status,
    'items': item,
    'packages': package,
  };
}