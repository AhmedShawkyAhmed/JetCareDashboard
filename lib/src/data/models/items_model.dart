class ItemsModel {
  int? id;
  String? nameEn;
  String? descriptionEn;
  String? nameAr;
  String? descriptionAr;
  String? image;
  String? unit;
  num? price;
  num? quantity;
  String? type;
  int? active;

  ItemsModel({
    this.id,
    this.nameEn,
    this.descriptionEn,
    this.nameAr,
    this.descriptionAr,
    this.image,
    this.unit,
    this.price,
    this.quantity,
    this.type,
    this.active,
  });

factory  ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel
    (
    id : json['id'] ?? 0,
    nameEn : json['nameEn'] ?? "",
    descriptionEn : json['descriptionEn'] ?? "",
    nameAr : json['nameAr'] ?? "",
    descriptionAr : json['descriptionAr'] ?? "",
    image : json['image'] ?? "",
    unit: json['unit'] ?? "",
    price : json['price'] ?? 0,
    quantity : json['quantity'] ?? 0,
    type : json['type'] ?? "",
    active: json['active'] ?? 1,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['descriptionEn'] = descriptionEn;
    data['nameAr'] = nameAr;
    data['descriptionAr'] = descriptionAr;
    data['image'] = image;
    data['unit'] = unit;
    data['price'] = price;
    data['quantity'] = quantity;
    data['type'] = type;
    data['active'] = active;
    return data;
  }
}
