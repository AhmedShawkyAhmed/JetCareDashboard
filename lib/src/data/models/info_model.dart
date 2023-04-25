class InfoModel {
  int id;
  String titleEn;
  String contentEn;
  String titleAr;
  String contentAr;
  String type;

  InfoModel({
   required this.id,
   required this.titleEn,
   required this.contentEn,
   required this.titleAr,
   required this.contentAr,
   required this.type,
  });

factory  InfoModel.fromJson(Map<String, dynamic> json) => InfoModel
    (
    id : json['id'],
    titleEn : json['titleEn'],
    contentEn : json['contentEn'],
    titleAr : json['titleAr'],
    contentAr : json['contentAr'],
    type : json['type'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['titleEn'] = titleEn;
    data['contentEn'] = contentEn;
    data['titleAr'] = titleAr;
    data['contentAr'] = contentAr;
    data['type'] = type;
    return data;
  }
}
