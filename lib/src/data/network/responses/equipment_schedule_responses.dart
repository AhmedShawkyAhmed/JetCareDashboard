import 'package:jetboard/src/data/models/equipment_schedule_model.dart';

class EquipmentScheduleResponse {
  int? status;
  List<EquipmentScheduleModel>? equipmentScheduleModel;
  

  EquipmentScheduleResponse({this.status, this.equipmentScheduleModel});

  factory EquipmentScheduleResponse.fromJson(Map<String, dynamic> json) => EquipmentScheduleResponse(
        status: json['status'],
        equipmentScheduleModel: json["equipment"] != null
            ? List<EquipmentScheduleModel>.from(json["equipment"].map((x)=> EquipmentScheduleModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "equipment":List<dynamic>.from(equipmentScheduleModel!.map((e) => e.toJson())),
  };
}