import 'package:jetboard/src/data/models/area_model.dart';

class AreaResponse {
  int? status;
  List<AreaModel>? areaModel;
  AreaModel? areaModell;


  AreaResponse({this.status, this.areaModel, this.areaModell});

  factory AreaResponse.fromJson(Map<String, dynamic> json) => AreaResponse(
        status: json['status'],
        areaModel: json["areaList"] != null
            ? List<AreaModel>.from(json["areaList"].map((x)=> AreaModel.fromJson(x)))
            :[],
        areaModell: json['area'] != null ? AreaModel.fromJson(json["area"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "areaList":List<dynamic>.from(areaModel!.map((e) => e.toJson())),
    "area": areaModell
  };
}


