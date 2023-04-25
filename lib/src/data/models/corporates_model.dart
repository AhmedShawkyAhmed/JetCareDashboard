class CorporatesModel {
  int id;
  int userId;
  String name;
  String email;
  String phone;
  String message;
  int contact;
  String createdAt;
  String? adminComment;
  CorporatesItem? item;

  CorporatesModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.contact,
    required this.createdAt,
    required this.item,
    this.adminComment,
  });

  factory CorporatesModel.fromJson(Map<String, dynamic> json) =>
      CorporatesModel(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        message: json['message'],
        contact: json['contact'],
        createdAt: json['created_at'],
        adminComment: json['adminComment'] ?? "",
        item:
            json["item"] != null ? CorporatesItem.fromJson(json["item"]) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['message'] = message;
    data['contact'] = contact;
    data['adminComment'] = adminComment;
    data['created_at'] = createdAt;
    if (item != null) {
      data['item'] = item!.toJson();
    }

    return data;
  }
}

class CorporatesItem {
  int id;
  String nameAr;
  String nameEn;
  String image;
  String descriptionAr;
  String descriptionEn;
  String unit;
  double price;
  int quantity;
  String type;
  int active;

  CorporatesItem({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.unit,
    required this.price,
    required this.quantity,
    required this.type,
    required this.active,
  });

  factory CorporatesItem.fromJson(Map<String, dynamic> json) => CorporatesItem(
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

    return data;
  }
}
