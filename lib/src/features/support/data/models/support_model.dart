import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable()
class SupportModel{
  int id;
  String? name;
  String? contact;
  String? subject;
  String? message;
  String? adminComment;
  bool? isArchived;

  SupportModel({
    required this.id,
    this.name,
    this.contact,
    this.subject,
    this.message,
    this.adminComment,
    this.isArchived,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportModelToJson(this);
}