import 'package:jetboard/src/data/models/equipment_model.dart';

class EquipmentRespons {
  int? status;
  List<EquipmentModel>? equipmentModel;
  

  EquipmentRespons({this.status, this.equipmentModel});

  factory EquipmentRespons.fromJson(Map<String, dynamic> json) => EquipmentRespons(
        status: json['status'],
        equipmentModel: json["equipment"] != null
            ? List<EquipmentModel>.from(json["equipment"].map((x)=> EquipmentModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "equipment":List<dynamic>.from(equipmentModel!.map((e) => e.toJson())),
  };
}