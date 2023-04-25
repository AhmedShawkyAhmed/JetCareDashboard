import 'package:jetboard/src/data/models/spaces_model.dart';

class SpacesResponsr {
  int? status;
  List<SpacesModel>? spacesModel;
  SpacesModel? spacesModell;
  

  SpacesResponsr({this.status, this.spacesModel, this.spacesModell});

  factory SpacesResponsr.fromJson(Map<String, dynamic> json) => SpacesResponsr(
        status: json['status'],
        spacesModel: json["spaceList"] != null
            ? List<SpacesModel>.from(json["spaceList"].map((x)=> SpacesModel.fromJson(x)))
            :[],
         spacesModell: json['space'] != null ? SpacesModel.fromJson(json["space"])
        :null,
      );

  Map<String, dynamic> toJson() => {
    "status":status,
    "periodList":List<dynamic>.from(spacesModel!.map((e) => e.toJson())),
    "space:":spacesModell,
  };
}