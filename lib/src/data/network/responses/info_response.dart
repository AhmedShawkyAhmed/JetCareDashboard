import 'package:jetboard/src/data/models/info_model.dart';

class InfoResponse {
  int? status;
  List<InfoModel>? infoModel;
  InfoModel? infoModell;


  InfoResponse({this.status, this.infoModel, this.infoModell});

  factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
        status: json['status'],
        infoModel: json["allInfo"] != null
            ? List<InfoModel>.from(json["allInfo"].map((x)=> InfoModel.fromJson(x)))
            :[],
        infoModell: json['info'] != null ? InfoModel.fromJson(json["info"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "allInfo":List<dynamic>.from(infoModel!.map((e) => e.toJson())),
    "info": infoModell
  };
}


