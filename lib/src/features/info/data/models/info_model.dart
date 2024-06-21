import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable()
class InfoModel{
  int? id;
  String? titleAr;
  String? titleEn;
  String? contentAr;
  String? contentEn;
  String? type;

  InfoModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.contentAr,
    this.contentEn,
    this.type,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}