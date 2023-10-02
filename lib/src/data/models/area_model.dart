class AreaModel {
  int? id;
  String? nameEn;
  String? nameAr;
  num? price;
  num? discount;
  num? transportation;
  int? active;
  int? relationId;

  AreaModel({
     this.id,
     this.nameEn,
     this.nameAr,
    this.price,
    this.discount,
    this.transportation,
     this.active,
     this.relationId,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json['id'] ?? 0,
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        price: json['price'] ?? 0,
    discount: json['discount'] ?? 0,
    transportation: json['transportation'] ?? 0,
        active: json['active'] ?? 0,
    relationId: json['relationId'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['price'] = price;
    data['discount'] = discount;
    data['transportation'] = transportation;
    data['active'] = active;
    data['relationId'] = relationId;
    return data;
  }
}
