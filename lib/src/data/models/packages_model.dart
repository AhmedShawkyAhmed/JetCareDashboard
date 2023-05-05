class PackagesModel {
  int id;
  String nameAr;
  String nameEn;
  String descriptionAr;
  String descriptionEn;
  String image;
  String type;
  double price;
  List<PackagesItemsData>? items;
  List<PackagesItemsData>? packages;
  int? relationId;
  int active;

  PackagesModel(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.descriptionAr,
      required this.descriptionEn,
      required this.image,
      required this.type,
      required this.price,
      this.relationId,
      this.items,
      this.packages,
      required this.active});

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        id: json['id'],
        nameAr: json['nameAr'],
        nameEn: json['nameEn'],
        descriptionAr: json['descriptionAr'],
        descriptionEn: json['descriptionEn'],
        image: json['image'],
        type: json['type'],
        price: json['price'],
        relationId: json['relationId'],
        items: json["items"] != null
            ? List<PackagesItemsData>.from(
                json["items"].map((x) => PackagesItemsData.fromJson(x)))
            : json["items"],
        packages: json["package"] != null
            ? List<PackagesItemsData>.from(
                json["package"].map((x) => PackagesItemsData.fromJson(x)))
            : json["package"],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['descriptionAr'] = descriptionAr;
    data['descriptionEn'] = descriptionEn;
    data['image'] = image;
    data['type'] = type;
    data['price'] = price;
    data['relationId'] = relationId;
    data["items"] = List<dynamic>.from(items!.map((x) => x.toJson()));
    data["package"] = List<dynamic>.from(packages!.map((x) => x.toJson()));
    data['active'] = active;
    return data;
  }
}

class PackagesItemsData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? descriptionAr;
  String? descriptionEn;
  String? unit;
  num? price;
  String? type;
  int? active;
  int? relationId;

  PackagesItemsData(
      { this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.descriptionAr,
      this.descriptionEn,
      this.unit,
       this.price,
      this.type,
       this.active,
       this.relationId});

  factory PackagesItemsData.fromJson(Map<String, dynamic> json) =>
      PackagesItemsData(
        id : json['id'] ?? 0,
        nameEn : json['nameEn'] ?? "",
        descriptionEn : json['descriptionEn'] ?? "",
        nameAr : json['nameAr'] ?? "",
        descriptionAr : json['descriptionAr'] ?? "",
        image : json['image'] ?? "",
        unit: json['unit'] ?? "",
        price : json['price'] ?? 0,
        relationId : json['relationId'] ?? 0,
        type : json['type'] ?? "",
        active: json['active'] ?? 1,
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
    data['type'] = type;
    data['active'] = active;
    data['relationId'] = relationId;
    return data;
  }
}
