
class ItemsRequest {
  int? id;
  String? nameEn;
  String? descriptionEn;
  String? nameAr;
  String? descriptionAr;
  String? image;
  String? unit;
  int? price;
  int? quantity;
  String? type;
  int? active;
  int? hasShipping;
  ItemsRequest({
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
    this.hasShipping,
  });
}
