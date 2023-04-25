import '../../models/corporates_model.dart';

class CorporatesResponse {
  int? status;
  List<CorporatesModel>? corporatesModel;
  

  CorporatesResponse({this.status, this.corporatesModel,});

  factory CorporatesResponse.fromJson(Map<String, dynamic> json) => CorporatesResponse(
        status: json['status'],
        corporatesModel: json["corporateList"] != null
            ? List<CorporatesModel>.from(json["corporateList"].map((x)=> CorporatesModel.fromJson(x)))
            :[],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "corporateList": List<dynamic>.from(corporatesModel!.map((e) => e.toJson())),
  };
}