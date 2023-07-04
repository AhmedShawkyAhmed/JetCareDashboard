class AreaModel {
  int id;
  String nameEn;
  String nameAr;
  num? price;
  int active;

  AreaModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.price,
    required this.active,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json['id'] ?? 0,
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        price: json['price'] ?? 0,
        active: json['active'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['price'] = price;
    data['active'] = active;
    return data;
  }
}
