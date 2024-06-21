import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_request.g.dart';

@JsonSerializable()
class InfoRequest {
  int? id;
  String titleAr;
  String titleEn;
  String contentAr;
  String contentEn;
  String type;

  InfoRequest({
    this.id,
    required this.titleAr,
    required this.titleEn,
    required this.contentAr,
    required this.contentEn,
    required this.type,
  });

  factory InfoRequest.fromJson(Map<String, dynamic> json) =>
      _$InfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InfoRequestToJson(this);
}
