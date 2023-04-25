class PackagesRequest {
  int? id;
  int? relationId;
  String? nameEn;
  String? descriptionEn;
  String? nameAr;
  String? descriptionAr;
  String? image;
  String? type;
  double? price;
  int? active;
  List<int>?items;
  PackagesRequest({
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
    this.items,
  });
}
