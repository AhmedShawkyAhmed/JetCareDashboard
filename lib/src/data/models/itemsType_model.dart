class ItemsTypeModel {
  int id;
  String titleAr;
  String contentAr;
  String titleEn;
  String contentEn;
  String type;

  ItemsTypeModel({
    required this.id,
    required this.titleAr,
    required this.contentAr,
    required this.titleEn,
    required this.contentEn,
    required this.type,
  });

  factory ItemsTypeModel.fromJson(Map<String, dynamic> json) => ItemsTypeModel(
        id: json['id'],
        titleAr: json['titleAr'],
        contentAr: json['contentAr'],
        titleEn: json['titleEn'],
        contentEn: json['contentEn'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    data['id'] = id;
    data['titleAr'] = titleAr;
    data['contentAr'] = contentAr;
    data['titleEn'] = titleEn;
    data['contentEn'] = contentEn;
    data['type'] = type;
    return data;
  }
}
