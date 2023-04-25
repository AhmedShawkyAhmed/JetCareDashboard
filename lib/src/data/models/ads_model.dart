class AdsModel {
  int id;
  String nameEn;
  String link;
  String nameAr;
  String image;
  int active;

  AdsModel({
   required this.id,
   required this.nameEn,
   required this.link,
   required this.nameAr,
   required this.image,
   required this.active,
  });

factory  AdsModel.fromJson(Map<String, dynamic> json) => AdsModel
    (
    id : json['id'],
    nameEn : json['nameEn'],
    link : json['link'],
    nameAr : json['nameAr'],
    image : json['image'],
    active: json['active'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['link'] = link;
    data['nameAr'] = nameAr;
    data['image'] = image;
    data['active'] = active;
    return data;
  }
}