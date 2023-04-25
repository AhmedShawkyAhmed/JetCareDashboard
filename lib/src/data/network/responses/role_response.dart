
import '../../models/info_model.dart';

class RoleResponse {
  int? status;
  List<InfoModel>? infoModel;

  RoleResponse({this.status, this.infoModel});

  factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
        status: json['status'],
        infoModel: json["roleList"] != null
            ? List<InfoModel>.from(json["roleList"].map((x)=> InfoModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "roleList":List<dynamic>.from(infoModel!.map((e) => e.toJson())),
  };
}