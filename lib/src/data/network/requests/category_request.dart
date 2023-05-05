class CategoryRequest {
  int? id;
  int? relationId;
  String? nameEn;
  String? descriptionEn;
  String? nameAr;
  String? descriptionAr;
  String? image;
  String? type;
  num? price;
  int? active;
  List<int>? package;
  List<int>? items;
  CategoryRequest({
    this.id,
    this.relationId,
    this.nameEn,
    this.descriptionEn,
    this.nameAr,
    this.descriptionAr,
    this.image,
    this.type,
    this.price,
    this.active,
    this.package,
    this.items,
  });
}
