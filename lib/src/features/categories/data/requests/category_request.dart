import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_request.g.dart';

@JsonSerializable()
class CategoryRequest {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  bool? isActive;

  CategoryRequest({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.isActive,
  });

  factory CategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryRequestToJson(this);
}
