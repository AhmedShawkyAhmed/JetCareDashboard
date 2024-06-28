import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment_model.g.dart';

@JsonSerializable()
class EquipmentModel {
  int? id;
  String? code;
  String? name;
  bool? isActive;

  EquipmentModel({
    this.id,
    this.code,
    this.name,
    this.isActive,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentModelToJson(this);
}
