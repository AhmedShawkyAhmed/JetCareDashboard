import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/features/equipments/data/models/equipment_model.dart';

part 'equipment_schedule_model.g.dart';

@JsonSerializable()
class EquipmentScheduleModel {
  int? id;
  EquipmentModel? equipment;
  UserModel? crew;
  String? date;
  String? returned;
  String? createdAt;

  EquipmentScheduleModel({
    this.id,
    this.equipment,
    this.crew,
    this.date,
    this.returned,
    this.createdAt,
  });

  factory EquipmentScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentScheduleModelToJson(this);
}
