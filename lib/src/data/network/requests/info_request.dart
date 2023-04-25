class InfoRequest {
 final int? id;
 final String titleEn;
 final String contentEn;
 final String titleAr;
 final String contentAr;
 final String type;
 InfoRequest({
  this.id,
  required this.titleEn,
  required this.contentEn,
  required this.titleAr,
  required this.contentAr,
  required this.type,
 });
}