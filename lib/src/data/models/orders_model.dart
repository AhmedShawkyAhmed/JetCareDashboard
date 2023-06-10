import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/models/cart_model.dart';

class OrdersModel {
  int id;
  String? date;
  num? total;
  num? shipping;
  num? price;
  String? status;
  String? createdAt;
  User? user;
  Address? address;

  // Package? package;
  // Package? item;
  Space? space;
  Calendar? calendar;
  Period? period;
  User? crew;
  String? comment;
  String? adminComment;
  List<Extras>? extras;
  List<CartModel>? cart;

  OrdersModel({
    required this.id,
    this.date,
    this.total,
    this.status,
    this.createdAt,
    this.user,
    this.shipping,
    this.price,
    this.address,
    // this.package,
    // this.item,
    this.space,
    this.calendar,
    this.period,
    this.crew,
    this.comment,
    this.adminComment,
    this.extras,
    this.cart,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json['id'] ?? 0,
        date: json['date'] ?? "",
        total: json['total'] ?? 0,
        shipping: json['shipping'] ?? 0,
        price: json['price'] ?? 0,
        status: json['status'] ?? "",
        createdAt: json['created_at'] ?? "",
        comment: json['comment'] ?? "",
        adminComment: json['adminComment'] ?? "",
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null,
        // package:
        //     json['package'] != null ? Package.fromJson(json['package']) : null,
        // item: json['item'] != null ? Package.fromJson(json['item']) : null,
        space: json['space'] != null ? Space.fromJson(json['space']) : null,
        calendar: json['calendar'] != null
            ? Calendar.fromJson(json['calendar'])
            : null,
        period: json['period'] != null ? Period.fromJson(json['period']) : null,
        crew: json['crew'] != null ? User.fromJson(json['crew']) : null,
        extras: json["extras"] != null
            ? List<Extras>.from(json["extras"].map((x) => Extras.fromJson(x)))
            : json["extras"],
        cart: json["cart"] != null
            ? List<CartModel>.from(
                json["cart"].map((x) => CartModel.fromJson(x)))
            : json["cart"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['total'] = total;
    data['shipping'] = shipping;
    data['price'] = price;
    data['status'] = status;
    data['comment'] = comment;
    data['adminComment'] = adminComment;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user;
    }
    if (address != null) {
      data['address'] = address;
    }
    // if (package != null) {
    //   data['package'] = package;
    // }
    // if (item != null) {
    //   data['item'] = item;
    // }
    if (space != null) {
      data["space"] = space;
    }
    if (calendar != null) {
      data["calendar"] = calendar;
    }
    if (period != null) {
      data['period'] = period;
    }
    if (extras != null) {
      data['extras'] = extras!.map((e) => e.toJson()).toList();
    }
    if (cart != null) {
      data['cart'] = cart!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

class Address {
  int? id;
  String? phone;
  String? address;
  AreaModel? state;
  AreaModel? area;

  Address({
    this.id,
    this.phone,
    this.address,
    this.state,
    this.area,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        phone: json['phone'],
        address: json['address'],
        state: json['state'] != null ? AreaModel.fromJson(json['state']) : null,
        area: json['area'] != null ? AreaModel.fromJson(json['area']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['address'] = address;
    if (state != null) {
      data["state"] = state;
    }
    if (area != null) {
      data["area"] = area;
    }
    return data;
  }
}

class Package {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? image;
  num? price;

  Package(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.image,
      this.price});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json['id'],
        nameAr: json['nameAr'],
        nameEn: json['nameEn'],
        descriptionAr: json['descriptionAr'],
        descriptionEn: json['descriptionEn'],
        image: json['image'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['descriptionAr'] = descriptionAr;
    data['descriptionEn'] = descriptionEn;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}

class Space {
  int? id;
  String? from;
  String? to;
  int? price;
  int? active;

  Space({
    this.id,
    this.from,
    this.to,
    this.price,
    this.active,
  });

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        id: json['id'],
        from: json['from'],
        to: json['to'],
        price: json['price'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['price'] = price;
    data['active'] = active;
    return data;
  }
}

class Calendar {
  int? id;
  int? areaId;
  String? day;
  String? month;
  String? year;
  String? date;
  int? requests;
  int? price;

  Calendar(
      {this.id,
      this.areaId,
      this.day,
      this.month,
      this.year,
      this.date,
      this.requests,
      this.price});

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        id: json['id'],
        areaId: json['areaId'],
        day: json['day'],
        month: json['month'],
        year: json['year'],
        date: json['date'],
        requests: json['requests'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['areaId'] = areaId;
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['date'] = date;
    data['requests'] = requests;
    data['price'] = price;
    return data;
  }
}

class Period {
  int? id;
  String? from;
  String? to;

  Period({
    this.id,
    this.from,
    this.to,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json['id'],
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

class Extras {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? descriptionAr;
  String? descriptionEn;
  String? unit;
  int? price;
  int? quantity;
  String? type;
  int? active;
  int? relationId;

  Extras(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.descriptionAr,
      this.descriptionEn,
      this.unit,
      this.price,
      this.quantity,
      this.type,
      this.active,
      this.relationId});

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        id: json['id'],
        nameAr: json['nameAr'],
        nameEn: json['nameEn'],
        image: json['image'],
        descriptionAr: json['descriptionAr'],
        descriptionEn: json['descriptionEn'],
        unit: json['unit'],
        price: json['price'],
        quantity: json['quantity'],
        type: json['type'],
        active: json['active'],
        relationId: json['relationId'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['image'] = image;
    data['descriptionAr'] = descriptionAr;
    data['descriptionEn'] = descriptionEn;
    data['unit'] = unit;
    data['price'] = price;
    data['quantity'] = quantity;
    data['type'] = type;
    data['active'] = active;
    data['relationId'] = relationId;
    return data;
  }
}
