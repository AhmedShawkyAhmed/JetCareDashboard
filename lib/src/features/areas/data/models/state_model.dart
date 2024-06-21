import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_model.g.dart';

@JsonSerializable()
class StateModel {
  int? id;
  String? nameAr;
  String? nameEn;
  bool? isActive;
  bool? isArchived;

  StateModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.isActive,
    this.isArchived,
  });
  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}